$(function () {
  $('#envia_email').click(function(){
    $('.erro_email').empty();
    var testEmail = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
    if ( testEmail.test($('#email').val()) && $('#email').val().length ) {
      window.location.href = root_url + "usuarios/edit_password_via_email?email=" + $('#email').val();
    }else{
      $('.erro_email').append('<p style="color: red; margin-top: 5px;">Formato de email incorreto, por favor digite um email válido para continuar.</p>');
    }
  });
});
