
jQuery ->
  $("form").on "click", ".remove_fields", (event) ->
    $(this).prev("input[type=hidden]").val(1)
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $("form").on "click", '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    #//ckeditor reinit
    tale_posts_attributes_id_content="tale_posts_attributes_"+time+"_content"
    CKEDITOR.replace(tale_posts_attributes_id_content, {"toolbar":"Pure","namespace":""})
    event.preventDefault()

$('.carousel').carousel()
