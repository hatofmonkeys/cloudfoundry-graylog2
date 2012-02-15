require 'gelf'

CONF_FILE = '/etc/cf-graylog2.conf'

FileTest.exists?(CONF_FILE) && load(CONF_FILE)

CF_HOME ||= '/home/cloudfoundry/vcap'
GRAYLOG2_HOST ||= 'localhost'

def stfu
    begin
      orig_stderr = $stderr.clone
      $stderr.reopen File.new('/dev/null', 'w')
      retval = yield
    rescue Exception => e
      $stderr.reopen orig_stderr
      raise e
    ensure
      $stderr.reopen orig_stderr
    end
    retval
end

stfu do
  load "#{CF_HOME}/bin/vcap"
end

module Run
  module Tail
    def initialize(component)
      @component = component
      @notifier = GELF::Notifier.new(GRAYLOG2_HOST)
    end
    def receive_line(line)
      # puts prefix + line
      @notifier.notify!(prefix + line)
      if line.start_with?('F') # FATAL
        @notifier.notify!(prefix + "fatal error, closing tail")
        close_connection_after_writing
      end
    end
  end
end
args = [ "tail" ]
opts_parser = OptionParser.new do |opts|
  opts.on('--port PORT')                           { |port| $port = port.to_i }
  opts.on('--configdir CONFIGDIR', '-c CONFIGDIR') { |dir| $configdir = File.expand_path(dir.to_s) }
  opts.on('--config CONFIGDIR')                    { |dir| $configdir = File.expand_path(dir.to_s) }
  opts.on('--no-color', '--nocolor', '--nc')       { $nocolor = true }
  opts.on('--noprompt', '-n')                      { $noprompt = true }
end
args = opts_parser.parse!(args)
$nocolor = true
command = args.shift.downcase
Run.send(command, args)
