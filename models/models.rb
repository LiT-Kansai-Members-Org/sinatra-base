require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection

# modelsディレクトリの全てのモデルファイルを読み込む
Dir[File.expand_path('../models/*.rb', __dir__)].each { |file| require file }
