

$(document).ready(function() {

  function reportes() {
  $.ajax({
    url: "reportes",
    type: "POST",
    dataType: "json",
    data: "",
    success: function(data) {

    }
  });
}

reportes();
});
