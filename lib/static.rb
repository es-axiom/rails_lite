require 'byebug'

class Static
  def initialize(app)
    @app = app
  end

  def call(env)
    # debugger
    file_path = env["PATH_INFO"]
    # debugger
      # debugger
    if file_path =~ /public\/.*/
      @content = File.read(".#{file_path}")
      content_type = "text/html"
      render_response(content_type)
    end
  rescue => e
    render_error(e)
  end

  def render_error(e)
    [
      '404',
      { "Content-type" => "text/html" },
      [e.message, e.backtrace, e.backtrace_locations]
    ]
  end

  def render_response(content_type)
    [
      '200',
      { "Content-type" => content_type },
      [@content]
    ]
  end
end
