require 'erb'

class ExceptionHandler
  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      @app.call(env)
    rescue StandardError => e
      status = 503
      headers = { 'Content-Type' => 'text/html' }
      body = [e.message, e.backtrace]
      [status, headers, body]
    end
  end
end
