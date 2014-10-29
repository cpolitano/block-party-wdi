$(document).ready(function(){
  
  // AJAX call to execute destroy function in blocks controller
  $("li.unblock").on("click", function(){
    var self = this;
    id = $(this).attr("id");
    button = $(this).children();
    button.css({"background-color": "#B531E8"});
    button.text("unblocked!");

    $.ajax({
      url: "blocks/" + id, 
      type: "DELETE",
      dataType: "json",
      success: function() {
        console.log('success!');
        $(self).delay(10000).fadeOut(10000).remove();
      }
    });
  })
  
});
