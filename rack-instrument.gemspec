# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'rack-instrument'
  spec.version       = '0.1.0'
  spec.authors       = ['Brooke McKim']
  spec.email         = ['brooke.mckim@gmail.com']
  spec.description   = %q{Rack middleware for recording request metrics}
  spec.summary       = %q{Rack::Instrument is a rack middleware for instrumenting request time, total requests, and total requests per path.}
  spec.homepage      = "https://github.com/brookemckim/rack-instrument"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'

  spec.add_dependency 'rack'
end

