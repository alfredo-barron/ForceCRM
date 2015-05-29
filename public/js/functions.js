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

function envios() {
  $.ajax({
    url: "checkcampaing",
    type: "POST",
    dataType: "html",
    data: "",
    success: function(data) {
        setTimeout(function(){
        envios();
      },1);
    }
  })

}

envios();
checkCampaings();
});
