$(document).ready(function() {

function checkCampaings() {
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

function checkStatus_social() {
  $.ajax({
    url: "social_status",
    type: "POST",
    dataType: "html",
    data: "",
    success: function(data) {
        setTimeout(function(){
        checkStatus_social();
      },10000);
    }
  })

}

checkCampaings();
checkStatus_social();
});
