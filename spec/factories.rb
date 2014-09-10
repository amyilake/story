
FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "foo#{n}"}
    password "password"
    sequence(:email) { |n| "#{name}#{n}@example.com" }
  end
end


FactoryGirl.define do
  factory :post do
    image { fixture_file_upload( "#{Rails.root}/spec/support/ilake.png", "image/png") }
  end
end

FactoryGirl.define do
  factory :like do
    # assocation :author, :factory => :user
  end
end

FactoryGirl.define do
  factory :comment do
    content ""
    commentable_id 1
    commentable_type "MyString"
    author_id 1
    likes_count 1
  end
end


FactoryGirl.define do
  factory :tale do
  end
end
