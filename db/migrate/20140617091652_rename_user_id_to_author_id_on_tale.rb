class RenameUserIdToAuthorIdOnTale < ActiveRecord::Migration
  def change
    rename_column :tales, :user_id, :author_id
  end
end
