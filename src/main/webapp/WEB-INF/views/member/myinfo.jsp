<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="container_wrap">
		<div id="container">
			<div id="contentsTitle">
				<div>
					<h2>활동명 변경</h2>
				</div>
			</div>
			<div id="contentsPrint">
				<form action="<c:url value="/member/edit"/>" method="POST" id="user-form" onsubmit="return edit();">
					<!-- 활동명 변경 -->
					<div id="section1">
						<p>
							사용 중인 활동명은 [${user.nickname }]입니다.<br>
							변경하실 활동명을 입력하세요.
						</p>
						<div class="ipt_wrap">
							<input type="text" placeholder="활동명 입력" class="ipt1" name="nickname" value="${user.nickname }">
							<input type="hidden" name="id" value="${user.id }"/>
							<input type="hidden" name="kakaoId" value="${user.kakaoId }"/>
						</div>
						<div class="bt_wrap">
							<input type="button"onclick="javascript:edit();" class="bt1" value="변경"/>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
<script type="text/javascript">
function edit(){ 
	var param = $("#user-form").serialize();
	var url = "/member/edit";
	
	$.ajax({
		url : url,
		data: param,
		type: "POST",
		dataType: 'json'
	}).done(function(json){
		if(json.result > 0 && confirm("변경 완료되었습니다.")){
			window.location.reload();
		}
	});
	
}
</script>
</body>
</html>