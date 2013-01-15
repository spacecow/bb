$(function(){
  $("input#sale_created_at").datepicker({
    dateFormat: 'yy-mm-dd'
  });

  var familiar_id = "input#sale_familiar_token";
  $(familiar_id).tokenInput($(familiar_id).data('url'), {
    tokenLimit: 1,
    preventDuplicates: true
  });
  $("input#sale_value").select();
});

