class Like < ActiveRecord::Base
  belongs_to :liketable, :polymorphic => true, :counter_cache => true
  belongs_to :author, :class_name => "User"

  validates_presence_of :author
  
  #after_create :increase_like_counter
  #after_destroy :decrease_like_counter

  #after_commit :add_to_redis, :on => :create
  #after_commit :delete_from_redis, :on => :destroy


  def increase_like_counter
    liketable.increment(:likes_count, 1)
    liketable.save
  end

  def decrease_like_counter
    liketable.increment(:likes_count, -1)
    liketable.save
  end

  def add_to_redis
    $redis.SADD self.author.email, liketable.id
  end

  def delete_from_redis
   $redis.SREM self.author.email, liketable.id 
  end
end
