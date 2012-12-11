$(document).ready(function(){
    $(document).ajaxStart(function(){
        $('#upload-indicator').show();
    }).ajaxComplete(function(){
        $('#upload-indicator').hide();
    });

    //AJAX file upload for required elements
    $(".photo-widget-container .upload-btn").live("click", function(){
        var refresh_url = '/profiles/' + $(this).parent().attr("data-profile") + '/refresh_photo';
        var update_photo_url = '/profiles/' + $(this).parent().attr("data-profile") + '/update_photo';
        $.ajaxFileUpload({
            url: update_photo_url,
            secureuri:false,
            fileElementId: $(this).parent().attr("id"),
            success: function (data, status){
                if(typeof(data.error) != 'undefined'){
                    if(data.error != '')
                    {
                        alert(data.error);
                    } else {
                        alert(data.msg);
                    }
                } else {
                    jQuery.ajax({dataType:'script', type:'get', url:refresh_url});
                }
            },
            error: function (data, status, e){
                alert(e);
            }
        });
        return false;
    });
});
