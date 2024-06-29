require "bundler/setup"
Bundler.require
require "sinatra/reloader" if development?
require "./models/models.rb"

require "./base"

# routesディレクトリの全てのルート定義ファイルを読み込む
Dir[File.join(__dir__, 'routes', '*.rb')].each { |file| require file }

class App < Base
  get "/" do
    send_json({ message: "LiT! Card System" })
  end

  # 以下、読み込んだroutesディレクトリのルートを設定
  use Routes::UserRoute
end