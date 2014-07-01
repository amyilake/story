class CreateTales < ActiveRecord::Migration
  def change
    create_table :tales do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.string :type
      t.integer :like_count
      t.integer :comment_count
      t.boolean :favorite
      t.boolean :public
      t.string :image
      t.string :remote_image_url
      t.timestamps
    end
  end
end
