$(function() {
  $('.datepicker').datepicker({
    format: "dd/mm/yyyy",
    language: 'pt-BR'
  });

  $("#base_person_cpf").mask("000.000.000-00");
  $("#base_person_cnpj").mask("00.000.000/0000-00");
  $("#base_person_cep").mask("00000-000");
  $("#base_person_telefone").mask("(00)00000-0000");
  $("#data_de_nascimento").mask("00/00/0000");

  $('form').submit(function() {
    $('#base_person_cpf, #base_person_cnpj, #base_person_cep, #base_person_telefone').unmask();
  });
});