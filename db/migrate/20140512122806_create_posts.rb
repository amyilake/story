class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.string :type
      t.text :remote_photo_path
      t.string :remote_photo_name
      t.integer :like_count
      t.integer :comment_count
      t.boolean :favorite
      t.boolean :public
      t.timestamps
    end
  end
end
