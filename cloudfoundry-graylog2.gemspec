# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "cloudfoundry-graylog2"
  s.version     = "0.0.1"
  s.authors     = ["Colin Humphreys"]
  s.homepage    = "https://github.com/hatofmonkeys/cloudfoundry-graylog2"
  s.summary     = "#{s.name}-#{s.version}"
  s.description = "Send Cloud Foundry logs to Graylog2"
  s.license     = 'MIT'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_path = "lib"

  s.add_dependency "gelf"
  s.add_dependency "daemons"
  s.add_development_dependency "rake"
end
