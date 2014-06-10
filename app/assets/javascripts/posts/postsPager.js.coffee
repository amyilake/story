@postsPager

jQuery ->
  if $('#posts').length
    @postsPager = new PostsPager(1)

ready = -> #document load
  if $('#posts').length
    url = location.pathname # check url have 'users' or not
    if(url.indexOf("users") >= 0)
      user_id = url.match(/\/users\/(.*)/)[1]
      user_id = user_id.replace('\/posts','')
      @postsPager.user_id = user_id
    else
      @postsPager.user_id = ''

    @postsPager.page = 1 #set page = 1 init
    @postsPager.startScroll() # set Scroll init

$(document).ready(ready)
$(document).on('page:load', ready)


class PostsPager
  constructor: (@page,@user_id) ->
    if $('#posts').length
      $(window).scroll(@check)
  
  check: =>
    if @nearBottom()
      @page++
      $(window).unbind('scroll', @check)
      $.getJSON($('#posts').data('json-url'), user_id: @user_id, page: @page, @render)
      
  nearBottom: =>
    if $('#posts').length
      $(window).scrollTop() > $(document).height() - $(window).height() - 50

  render: (posts) =>
    for post in posts
      console.log(post)
      $('#posts').append Mustache.to_html($('#post_template').html(), post)
    $(window).scroll(@check) if posts.length > 0

  startScroll: ->
    $(window).unbind('scroll', @check)
    $(window).scroll(@check)
