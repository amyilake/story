class EditTales < ActiveRecord::Migration
  def change
    rename_column :tales, :comment_count, :comments_count
    rename_column :tales, :like_count, :likes_count
  end
end
