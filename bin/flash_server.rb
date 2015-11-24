require 'rack'
require_relative '../lib/controller_base'
require_relative '../lib/router'

class FlashController < ControllerBase
  def index
  end

  def test
    flash['test'] = "Hello"
    redirect_to "/show"
  end

  def now
    flash.now['now'] = "World"
  end
end

router = Router.new
router.draw do
  get Regexp.new("^/show$"), FlashController, :index
  get Regexp.new("^/now$"), FlashController, :now
  get Regexp.new("^/flash$"), FlashController, :test
end

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)
