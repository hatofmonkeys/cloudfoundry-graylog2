# CloudFoundry-Graylog2

A simple gem to throw the logs from 'vcap tail' into Graylog2 for ease of search and access.

## Setup

Set up a Graylog2 server somewhere accepting GELF messages on port 12201 UDP.

Install this gem on your Cloud Foundry servers.

    gem install cloudfoundry-graylog2 # or add to your bundle

Create a file on your Cloud Foundry servers to tell them where about vcap and where your Graylog2 server is;

    #/etc/cf-graylog2.conf
    CF_HOME = '/home/colin/cloudfoundry/vcap'
    GRAYLOG2_HOST = '192.168.0.43'

## Starting/Stopping

    cf-graylog2-control {start|stop|status}

I'll do the decent thing and create debs and rpms (including init scripts) once anyone apart from me starts using this.

## Contributing

Please, please, please fork this, improve it, and issue a pull request. You know you want to.