require 'json'
require 'byebug'

class Flash
  def initialize(req)
    @flash = {}
    potential_cookie = req.cookies['_rails_lite_flash']
    @now = potential_cookie ? JSON.parse(potential_cookie) : {}
  end

  def [](key)
    @flash[key]
  end

  def []=(key, value)
    @flash[key] = value
  end

  def now
    @now
  end

  def store_flash(res)
    res.set_cookie('_rails_lite_flash', {
      path: "/",
      value: @flash.to_json
    })
  end
end
