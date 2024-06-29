module Routes
	class UserRoute < Base
    get "/users" do
      users = User.all
      send_json({ users: users })
    end
  end
end
