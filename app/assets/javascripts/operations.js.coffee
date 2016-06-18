jQuery ->
  $('form.import_form').bind 'ajax:success', (e, data, status, xhr) ->
    json_data = $.parseJSON(xhr.responseText)
    $('.companies').html(JST["templates/companies"]({companies: json_data}));
  .bind 'ajax:error', (e, xhr, status, error) ->
    errors = $.parseJSON(xhr.responseText)
    message =  errors['errors']['name']
    $('.errors').html(JST["templates/errors"]({message: message}));

