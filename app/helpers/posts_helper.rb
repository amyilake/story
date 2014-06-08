module PostsHelper

  def posts_for_mustache(post)
    
    if post.image_url.present?
      post_photo = post.image_url
    else
      post_photo = "/assets/baby.jpg"
    end
    
    if current_user && current_user.check_like_post?(post)
      like_text = '收回贊'
      like_method = 'delete'
    else
      like_text = '贊'
      like_method = 'post'
    end

    {
      :post => post,

      :author_name => post.author.name,
      :author_image => post.author.image_url(:thumb).to_s,
      :author_url => user_posts_path(post.author.id),

      :post_url => post_url(post),
      :post_title => truncate( post.title , length: 25, omission: '..'),
      :post_photo => post_photo,
      
      :comment_count => post.comment_count,
      
      :data_id => post.id,

      :like_count => post.like_count,
      :like_text => like_text,
      :like_url => post_likes_path(post),
      :like_method => like_method
    }
  end

end
