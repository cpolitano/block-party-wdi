$(document).ready(function(){
  
  // AJAX call to execute destroy function in blocks controller
  deleteItem: function(type, item) {
    id = $(item).attr("id");
    button = $(item).children();
    button.css({"background-color": "#B531E8"});
    button.text("deleted!");
    $.ajax({
      url: type + "/" + id, 
      type: "DELETE",
      dataType: "json",
      success: function() {
        console.log('success!');
        $(item).delay(10000).fadeOut(10000).remove();
      }
    });
  }

  $("li.unblock").on("click", function(){
    var self = this;
    deleteItem("blocks",self);
  })

  $("li.delete-tweet").on("click", function(){
    var self = this;
    deleteItem("tweets", self);
  })

  $("li.delete-word").on("click", function(){
    var self = this;
    deleteItem("words", self);
  })
  
});
