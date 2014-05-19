class Like < ActiveRecord::Base
  belongs_to :liketable , polymorphic: true
  belongs_to :author , :class_name => "User"
  
  after_create :increase_like_counter
  after_destroy :decrease_like_counter

  def increase_like_counter
    liketable.increment(:like_count, 1)
    liketable.save
  end

  def decrease_like_counter
    liketable.increment(:like_count, -1)
    liketable.save
  end
end
