@postsPager

jQuery ->
  if $('#tales').length
    @postsPager = new PostsPager(1)

ready = ->
  if $('#tales').length
    url = location.pathname # check url have 'users' or not
    if(url.indexOf("users") >= 0)
      user_id = url.match(/\/users\/(.*)/)[1]
      user_id = user_id.replace('\/posts','')
      postsPager.user_id = user_id
    else
      postsPager.user_id = ''

    postsPager.page = 1 #set page = 1 init
    postsPager.startScroll() # set Scroll init

$(document).ready(ready)
$(document).on('page:load', ready)


class PostsPager
  constructor: (@page,@user_id) ->
    if $('#tales').length
      $(window).scroll(@check)
  
  check: =>
    if @nearBottom()
      @page++
      $(window).unbind('scroll', @check)
      $.getJSON($('#tales').data('json-url'), user_id: @user_id, page: @page, @render)
      
  nearBottom: =>
    if $('#tales').length
      $(window).scrollTop() > $(document).height() - $(window).height() - 50

  render: (tales) =>
    console.log tales
    for tale in tales
      $('#tales').append Mustache.to_html($('#tale_template').html(), tale)
    $(window).scroll(@check) if tale.length > 0

  startScroll: ->
    $(window).unbind('scroll', @check)
    $(window).scroll(@check)
