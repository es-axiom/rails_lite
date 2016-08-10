require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(request)
    cookie = request.cookies["_rails_lite_app"]
    @content = (cookie ? JSON.parse(cookie) : {})
  end

  def [](key)
    @content[key]
  end

  def []=(key, val)
    @content[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(response)
    cookie = {
      path: '/',
      value: @content.to_json
    }
    response.set_cookie("_rails_lite_app", cookie)
  end
end
