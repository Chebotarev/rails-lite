require 'erb'


class ExceptionHandler
  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      @app.call(env)
    rescue StandardError => e
      status = 500
      headers = { 'Content-Type' => 'text/html' }
      content = ERB.new(File.read('./bin/exception.html.erb')).result(binding)
      body = [content]
      [status, headers, body]
    end
  end
end
