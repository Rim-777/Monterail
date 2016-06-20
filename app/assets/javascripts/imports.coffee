jQuery ->
  $('form.import_form').bind 'ajax:success', (e, data, status, xhr) ->
    json_data = $.parseJSON(xhr.responseText)
    if data_is_operations(json_data)
      operation_list = json_data
      $('.companies').html(JST["templates/companies_table"])
      for operation in  operation_list
        company_id = operation['company_id']
        add_company_row(operation['company_name'], company_id) if company_row_absent(company_id)
        add_company_operation_table(company_id) if company_operation_table_absent(company_id)
        $('#company_' + company_id + '_operations_table').append(JST["templates/operation"]({operation: operation}))
    else
      companies_list = json_data
      $('.companies').html(JST["templates/companies"]({companies: companies_list}))
  .bind 'ajax:error', (e, xhr, status, error) ->
    errors = $.parseJSON(xhr.responseText)
    message = errors['errors']['name']
    $('.errors').html(JST["templates/errors"]({message: message}))


data_is_operations= (data)->
  !!data[0]['company_name']

company_row_absent= (company_id)->
  !($('#company_' +  company_id)[0])

add_company_row= (company_name, company_id)->
  $('.companies_list').append(JST["templates/company"]({company_name: company_name, company_id:  company_id }))

company_operation_table_absent=(company_id)->
  !$('#company_' +  company_id).find('.operations_table')[0]

add_company_operation_table= (company_id)->
  $('#company_' +  company_id).append(JST["templates/operations_table"]({company_id: company_id}))
