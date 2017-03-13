$(document).on('ready page:load', function() {
  $('#delete-btn').on('click', function(){
    if(confirm(I18n.t('are_you_sure'))){
      $(':checked').each(function(){
        id = $(this).attr('id');
        action = $(location).attr('href') + '/' + id;
        name = '#product' + id;
        $.ajax({
          url: action,
          method: 'DELETE',
          data: {id: id},
          dataType: 'json',
          success: function(){
            $(name).hide();
          },
          error: function() {
            alert(I18n.t('cant_delete'))
          }
        })
      })
    };
  })
})
