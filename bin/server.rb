require 'rack'

require_relative './exception_handler'
require_relative './static_assets'

require_relative '../lib/router'
require_relative '../lib/controller_base'

class TestController < ControllerBase
  def index
    render_content("Hello", "text/html")
  end
end

router = Router.new
router.draw do
  get Regexp.new("^/hello$"), TestController, :index
end

base = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

app = Rack::Builder.new do
  use StaticAssets
  use ExceptionHandler
  run base
end.to_app

Rack::Server.start(
  app: app,
  Port: 3000
)
