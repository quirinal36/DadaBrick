function submitProduct(){
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
		var param = $("#admin-add-form").serialize();
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
			$("<img>").attr("src", file.url))
		.append(
			$("<input>")
				.attr("type","button").addClass("bt2").val("삭제")
				.attr("onclick", "delImageClick(this);"))
		.append(
			$("<input>")
				.attr("type","hidden").attr("name", name).val(file.id))
		.attr("id", file.id).addClass("bt_imgUpload");
}
$(document).ready(function(){
	// 대표이미지
	$('#image-upload-btn').fileupload({
		imageCrop: true,
        dataType: 'json',
        done: function (e, data) {
        	var file = data.result.file;
        	
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
});