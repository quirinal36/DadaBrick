function pageGo(pageNum){
	$("input[name='pageNo']").val(pageNum);
	$("form").submit();
}
function search(form){
	$(form).submit();
}
function arangeList(sortBy){
	var url = $("form").attr("action");
	url = url + "?sortBy="+sortBy;
	window.location.replace(url);
}
function movePrev(btn){
	var id = $(btn).parent().find("input[name='id']").val();
	var orderNum = $(btn).parent().find("input[name='orderNum']").val();
	var menuId = $(btn).parent().find("input[name='menuId']").val();
	
	console.log("product id : " + id +" /orderNum: " + orderNum);
	
	var url = "/products/move/prev";
	var param = "id="+id+"&orderNum="+orderNum+"&menuId="+menuId;
	$.ajax({
		url : url,
		data: param,
		type: "POST",
		dataType: "json"
	}).done(function(json){
		if(json.result > 0){
			window.location.reload();
		}
	});
}
function moveNext(btn){
	var id = $(btn).parent().find("input[name='id']").val();
	var orderNum = $(btn).parent().find("input[name='orderNum']").val();
	var menuId = $(btn).parent().find("input[name='menuId']").val();
	console.log("product id : " + id +" /orderNum: " + orderNum);
	var url = "/products/move/next";
	var param = "id="+id+"&orderNum="+orderNum+"&menuId="+menuId;
	$.ajax({
		url : url,
		data: param,
		type: "POST",
		dataType: "json"
	}).done(function(json){
		if(json.result > 0){
			window.location.reload();
		}
	});
}