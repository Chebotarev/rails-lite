class StaticAssets
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = app.call(env)

    if status == 404
      check_assets(env)
    else
      [status, headers, body]
    end
  end

  def check_assets(env)
    req = Rack::Request.new(env)
    file_path = "./assets#{req.path_info}"

    if File.exist?(file_path)
      res = Rack::Response.new
      res['Content-type'] = 'image/jpg'
      res.write(File.read(file_path))
      res.finish
    else
      app.call(env)
    end
  end
end
