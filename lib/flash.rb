require 'json'
require 'byebug'

class Flash
  attr_accessor :now

  def initialize(request)
    flash = request.cookies['_rails_lite_app_flash']
    @now = (flash ? JSON.parse(flash) : {} )
    @content = {}
  end

  def [](key)
    @now[key] || @content[key]
  end

  def []=(key, val)
    @content[key] = val
  end

  def store_flash(response)
    flash = {
      path: '/',
      value: @content.to_json
    }
    response.set_cookie("_rails_lite_app_flash", flash)
  end
end
