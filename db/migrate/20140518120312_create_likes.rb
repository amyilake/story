class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :author_id
      t.belongs_to :liketable , polymorphic: true

      t.timestamps
    end
    add_index :likes , [:liketable_id , :liketable_type]
  end
end
