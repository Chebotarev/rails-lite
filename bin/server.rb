require 'rack'
require_relative '../lib/controller_base'
require_relative '../lib/router'
require_relative './exception_handler'

class BadController < ControllerBase
  def index
  end
end

router = Router.new
router.draw do
  get Regexp.new(""), BadController, :index
end

base = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

app = Rack::Builder.new do
  use ExceptionHandler
  run base
end.to_app

Rack::Server.start(
  app: app,
  Port: 3000
)
