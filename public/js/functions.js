$(document).ready(function() {

function checkCampaings () {
  $.ajax({
    url: "checkcampaing",
    type: "POST",
    dataType: "html",
    data: "",
    success: function(data) {
        setTimeout(function(){
        checkCampaings();
      },10000);
    }
  })

}

checkCampaings();
});
