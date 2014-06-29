class Tale < ActiveRecord::Base
  
  has_many :posts, :dependent => :destroy
  belongs_to :author, :class_name => "User" 
  
  accepts_nested_attributes_for :posts, allow_destroy: true

  validates :image, :presence => { :message => "Story image is required" }
  mount_uploader :image, ImageUploader

  self.per_page = 10
end
