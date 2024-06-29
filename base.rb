class Base < Sinatra::Application
  private

  # json形式のデータを返す処理
  def send_json(data)
    content_type :json
    data.to_json
  end

  # 以下、エラー処理

  def bad_request(message=nil)
    data = {
      "message": message || "Bad Request",
      "status": 400
    }
    status 400
    send_json(data)
  end

  def unauthorized(message=nil)
    data = {
      "message": message || "Unauthorized",
      "status": 401
    }
    status 401
    send_json data
  end

  def forbidden(message=nil)
    data = {
      "message": message || "Forbidden",
      "status": 403
    }
    status 403
    send_json data
  end

  def not_found_error(message=nil)
    data = {
      "message": message || "Not Found",
      "status": 404
    }
    status 404
    send_json data
  end

  def internal_server_error(message=nil)
    data = {
      "message": message || "Internal Server Error",
      "status": 500
    }
    status 500
    send_json data
  end
end
