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
	console.log("product id : " + id +" /orderNum: " + orderNum);
}
function moveNext(btn){
	var id = $(btn).parent().find("input[name='id']").val();
	var orderNum = $(btn).parent().find("input[name='orderNum']").val();
	console.log("product id : " + id +" /orderNum: " + orderNum);
}