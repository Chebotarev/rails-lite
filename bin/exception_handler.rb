require 'erb'


class ExceptionHandler
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      app.call(env)
    rescue StandardError => e
      rescue_app(e)
    end
  end

  def rescue_app(e)
    headers = {
      'Content-Type' => 'text/html'
    }

    [500, headers, generate_content(e)]
  end

  def generate_content(e)
    location = e.backtrace_locations.first
    bad_line = location.lineno
    code_array = File.readlines(location.absolute_path)

    ERB.new(File.read('./bin/exception.html.erb')).result(binding)
  end
end
