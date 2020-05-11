function submitProduct(){
	var param = $("#admin-add-form").serialize();
	
	if(confirm("저장하시겠습니까?")){
		/*
		var dataObj = {};
		$($("#admin-add-form").serializeArray()).each(function (i,field){
			dataObj[field.name] = field.value;
		});
		if(dataObj['priority'] == '' || dataObj['priority'] < 0){
			$("#admin-add-form").find("input[name='priority']").remove();
		}
		if(dataObj['bannerText'] == ''){
			$("#admin-add-form").find("input[name='bannerColor']").remove();
			$("#admin-add-form").find("input[name='bannerText']").remove();
		}
		*/
		var url = $("#admin-add-form").attr("action");
		
		$.ajax({
			url : url,
			data: param,
			type: "POST",
			dataType: "json"
		}).done(function(json){
			if(json.result > 0){
				alert("등록되었습니다.");
				window.location.replace("/products/list/"+json.category);
			}
		});
	}
}
function makeLI(file, name){
	return $("<li>")
		.append(
			$("<input>")
				.attr("type","button").addClass("bt_imgDelete").val("삭제")
				.attr("onclick", "delImageClick(this);"))
		.append(
			$("<input>")
				.attr("type","hidden").attr("name", name).val(file.id))
		.attr("id", file.id).attr("style", "background-image:url("+file.url+");");
}
function delImageClick(btn){
	var id = $(btn).parent().find("input[type='hidden']").val();
	var url = "/upload/delete";
	var param = "id="+id;

	$.ajax({
		url : url,
		data: param,
		type: "POST",
		dataType: "json"
	}).done(function(json){
		$(btn).parent().remove();
		$("#image-upload-btn").show();
	});
}
$(document).ready(function(){
	// 대표이미지
	$('#image-upload-btn').fileupload({
		imageCrop: true,
        dataType: 'json',
        done: function (e, data) {
        	var file = data.result.file;
        	$("#rep-image").empty();
        	$("#image-upload-btn").hide();
        	$("#rep-image").append(makeLI(file, 'representImage'));
        },
        progressall: function (e, data) {
        	var progress = parseInt(data.loaded / data.total * 100, 10);
            
            $('#progress_img .progress-bar').css(
                'width',
                progress + '%'
            );
            if(progress == 100){
            	$('#progress_img .progress-bar').css('width','0');
            }
        },
        dropZone: $('#dropzone-img-rep')
	});
	
	// detail 이미지
	$('#detail-upload-btn').fileupload({
		imageCrop: true,
        dataType: 'json',
        done: function (e, data) {
        	var file = data.result.file;
        	var length = $("#rep-image").size();
        	if(length < 10){
        		$("#det-image").append(makeLI(file, 'detImage'));
        	}else if(length == 10){
        		$("#image-upload-btn").hide();
        	}
        },
        progressall: function (e, data) {
        	var progress = parseInt(data.loaded / data.total * 100, 10);
            
            $('#progress_img .progress-bar').css(
                'width',
                progress + '%'
            );
            if(progress == 100){
            	$('#progress_img .progress-bar').css('width','0');
            }
        },
        dropZone: $('#dropzone-img-det')
	});
});