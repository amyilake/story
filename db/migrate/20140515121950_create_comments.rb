class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :author_id
      t.integer :likes_count
      t.belongs_to :commentable , polymorphic: true
      
      t.timestamps
    end
    add_index :comments , [:commentable_id , :commentable_type]
  end
end
