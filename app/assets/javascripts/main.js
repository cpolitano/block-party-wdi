$(document).ready(function(){
  
  // Show and hide About section
  $("#about").on("click", function(){
    $(".intro").hide();
    $(".about").fadeIn(750);
    $("#signin").text("let's get this party started");
  })

  $("#hide").on("click", function(){
    $(".about").hide();
    $(".intro").fadeIn(750);
  })

  // AJAX call to execute destroy function in blocks controller
  // function deleteItem(type, item) {
  //   $.ajax({
  //     url: type + "/" + id, 
  //     type: "DELETE",
  //     dataType: "json",
  //     success: function() {
  //       console.log('success!');
  //       $(item).delay(10000).fadeOut(10000).remove();
  //     }
  //   });
  // }

  $("li.unblock").on("click", function(){
    var self = this;
    id = $(self).attr("id");
    button = $(self).children();
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

  $("li.delete-tweet").on("click", function(){
    var self = this;
    id = $(self).attr("id");
    button = $(self).children();
    button.css({"background-color": "#B531E8"});
    button.text("deleted!");

    $.ajax({
      url: "tweets/" + id, 
      type: "DELETE",
      dataType: "json",
      success: function() {
        console.log('success!');
        $(self).delay(10000).fadeOut(10000).remove();
      }
    });
  })

  $("li.delete-word").on("click", function(){
    var self = this;
    id = $(self).attr("id");
    button = $(self).children();
    button.css({"background-color": "#B531E8"});
    button.text("deleted!");

    $.ajax({
      url: "words/" + id, 
      type: "DELETE",
      dataType: "json",
      success: function() {
        console.log('success!');
        $(self).delay(10000).fadeOut(10000).remove();
      }
    });
  })
  
});
