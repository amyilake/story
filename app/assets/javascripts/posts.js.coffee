# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  if $('#posts').length
    new PostsPager()

class PostsPager
  constructor: ->
    $(window).scroll(@check)
  
  check: =>
    if @nearBottom()
      $(window).unbind('scroll', @check)
      alert 'near bottom'

  nearBottom: =>
    $(window).scrollTop() > $(document).height() - $(window).height() - 50
