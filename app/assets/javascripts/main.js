$(document).ready(function(){
  
  // A method to unblock a user.
  $(".unblock").on("click", function(){
    resourceUrl = 'https://api.twitter.com/1.1/blocks/destroy.json?screen_name=';
    userName = '';
    $.ajax({
      type: 'POST',
      dataType: 'json',
      url: resourceURL + userName,
      data: { key: value },
      success: function () {
        console.log("success");
      },
      error: function() {
        console.log("didn't work");
      },
    });
  })
  
});