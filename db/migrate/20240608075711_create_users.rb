class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :name
      t.string :english_name
      t.string :region
      t.string :role
      t.string :color
      t.string :icon_url
      t.string :big_icon_url
      t.text :introduction
      t.string :twitter_username
      t.string :instagram_username
      t.string :github_username

      t.timestamps null: false
    end
  end
end
