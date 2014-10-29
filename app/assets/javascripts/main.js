$(document).ready(function(){
  
  // AJAX call to execute destroy function in blocks controller
  $("li.unblock").on("click", function(){
    id = $(this).attr("id");
    button = $(this).children();
    button.css({"background-color": "#25E89A"});
    button.text("unblocked!");
    $.ajax({
      url: "blocks/" + id, 
      type: "DELETE",
      dataType: "json",
      success: function() {
        console.log('success!');
        $(this).remove();
      }
    });
  })
  
});
