# Example rack application that uses statsd-ruby for instrumentation

require 'rack'
require 'rack/instrument'
require 'statsd' # https://github.com/reinh/statsd

statsd = Statsd.new 'localhost'
statsd.namespace = 'myapp'

use Rack::Instrument, statsd, [:request, :time, :path]

map '/' do
  run lambda { |env|
    [200, {}, ["Instrumenting is Instrumental\n"]]
  }
end

