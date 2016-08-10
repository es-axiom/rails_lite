require 'erb'
require 'byebug'

class ShowExceptions
  attr_reader :app
  
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  rescue => e
    render_exception(e)
  end

  private

  def render_exception(e)
    @e = e
    [
      "500",
      { "Content-type" => "text/html" },
      [e.backtrace, e.backtrace_locations, e.message]
    ]
  end

end
