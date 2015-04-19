// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.



$(document).on("page:change", function() {
    $('#submit').click(function(){
        var email = $('input[type=email]').val();
        $.ajax({
          url: "/signup",
          type: "post",
          data: {email: email},
          dataType: "json",
          success: function(){
            $('input[type=email]').val('');
            $('input[type=email]').attr('placeholder', "Thanks! We'll let you know!")
          },
          error:function(){
            $('input[type=email]').val('');
            $('input[type=email]').attr('placeholder', 'Invalid Email')
          }
        });
    });
});