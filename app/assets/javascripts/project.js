$(document).ready(function(){
  $(document).ajaxStart(function(){
      $('#upload-indicator').show();
  }).ajaxComplete(function(){
      $('#upload-indicator').hide();
  });

  $(".change-photo").click(function(){
    $("#upload-form").toggle();
    return false;
  });

  //AJAX file upload for required elements
  $(".upload-btn").live("click", function(){
    var crop_canvas_url = '/profiles/' + $(this).attr("data-profile") + '/crop_canvas';
    var update_photo_url = '/profiles/' + $(this).attr("data-profile") + '/update_photo';
    $.ajaxFileUpload({
      url: update_photo_url,
      secureuri:false,
      fileElementId: "upload-form",
      success: function (data, status){
        if(typeof(data.error) != 'undefined'){
          if(data.error != '')
          {
            alert(data.error);
          } else {
            alert(data.msg);
          }
        } else {
          $("#upload-form").hide();
          jQuery.ajax({dataType:'script', type:'get', url:crop_canvas_url});
        }
      },
      error: function (data, status, e){
        alert(e);
      }
    });
    return false;
  });
});
