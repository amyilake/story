class AddRemoteImageUrlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :remote_image_url, :string
    remove_column :posts, :remote_photo_path
    remove_column :posts, :remote_photo_name
  end
end
