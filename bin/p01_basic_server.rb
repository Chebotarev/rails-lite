#!/usr/bin/env ruby
require 'rack'

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  res['Content-Type'] = 'text/json'
  res.write(env)
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)
