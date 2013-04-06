require 'rack'

class Rack::Instrument
  # This can be used as the instrument in order to disable instrumentation
  # without removing it completely.
  #
  # use Rack::Instrument, Rack::Instrument::NullInstrument.new
  class NullInstrument
    def increment(*args); end
    def timing(*args); end
  end

  # use Rack::Instrument, Statsd.new('localhost'), [:request, :time, :path]
  def initialize(app, instrument, instrumentations = [])
    @app = app
    @instrument = instrument || NullInstrument.new

    @instrument_request = instrumentations.include? :request
    @instrument_time    = instrumentations.include? :time
    @instrument_path    = instrumentations.include? :path
  end

  attr_accessor :instrument

  # Flag for whether or not requests should be counted.
  attr_reader :instrument_request

  # Flag for whether or not requests should be timed.
  attr_reader :instrument_time

  # Flag for whether or not specific paths should be counted.
  attr_reader :instrument_path

  # Rack
  def call(env)
    request_start = Time.now

    record_request
    record_path(env)

    status, headers, response = @app.call(env)

    record_time(request_start)

    [status, headers, response]
  end

  # Count the total number of requests.
  def record_request
    return unless instrument_request

    instrument.increment 'requests'
  end

  # Instrument the total request time.
  def record_time(request_start)
    return unless instrument_time

    request_end  = Time.now
    request_time = (request_end - request_start) * 1000

    instrument.timing 'request_time', request_time
  end

  # Count the number of times a specific path has been visited.
  def record_path(env)
    return unless instrument_path

    # Normalize and remove leading /
    path = env['REQUEST_PATH'].downcase.slice(1..-1)

    # Convert / to _
    path_key = path.gsub('/', '_').gsub('.', '_')
    path_key = 'index' if path_key.empty?

    instrument.increment 'requests.' + path_key
  end
end

