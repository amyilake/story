namespace :db do
  desc "create posts data"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    #[Category, Product, Person].each(&:delete_all)

      Post.populate 10..30 do |post| 
        post.title = Populator.words(1..3).titleize
        post.content = Populator.sentences(2..10)
        post.like_count = 0
        post.comment_count = 0
        post.author_id = 1..2
        post.created_at = 2.years.ago..Time.now
      end

  end
end
