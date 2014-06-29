class AddTaleIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :tale_id, :integer
  end
end
