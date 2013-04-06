# Rack::Instrument

Rack::Instrument is a rack middleware for instrumenting request time,
total requests, and total requests per path. I am testing with
statsd[https://github.com/reinh/statsd] as an instrumenter, but you can use any 
object that responds to increment or timing.

## Installation

Add this line to your application's Gemfile:

    gem 'rack-instrument'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-instrument

## Usage

```ruby
require 'rack/instrument'
require 'statsd'

# Instansiate your instrumenter.
statsd = Statsd.new 'localhost'
statsd.namespace = 'myapp'

# Pass the instrumentor along with an Array of the metrics you would
# like. 
#
#  Metrics
#    :request - Increments the total request count.
#    :time    - Records total request time.
#    :path    - Increments the total request count per path.
use Rack::Instrument, statsd, [:request, :time, :path]
```

Check the examples directory for more examples.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

