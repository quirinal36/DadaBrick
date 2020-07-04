<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd-HHmm" var="nowDate"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
<script type="text/javascript">
function moveTo(id){
   var url = $("form").attr("action");
   var param = $("form").serialize();
   
   if($("input[name='password']").val() == ''){
	   alert("비밀번호를 입력 해주세요.");
   }else{
	   $.ajax({
	      url : url,
	      data: param,
	      type: "POST",
	      dataType: 'json'
	   }).done(function(json){
	      if(json.result > 0){
	         window.location.replace(json.dest);
	      }else if(json.result < 0){
	    	  alert(json.msg);
	      }
	   });
   }
}

$(function(){
	$("input[name='password']").keyup(function(e){
		e.preventDefault();
		if(e.keyCode == 13){ 
			moveTo($("input[name='redirectId']").val());
			return false;
		}
	});
});
</script>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="containerWrap">
		<div id="container">
			<div id="contentsPrint">
	            <!-- 상세 페이지 상단 -->
	            <div id="contentsTitle">
	               <h2>질문과 답변</h2>
	            </div>
	            <div id="section1" class="ipt_pwd_wrap">
	               <p>비밀번호를 입력하세요.</p>
	               <form action="/board/inputPwd" method="POST">
	                  <input type="password" name="password" class="ipt1"/>
	                  <input type="hidden" name="redirectId" value="${redirectId }"/>
	                  <div class="bt_wrap">
	                     <input type="submit" value="확인" onclick="moveTo('${redirectId}')" class="bt1 on"/>
	                     <input type="button" value="취소" class="bt1">
	                  </div>
	               </form>
	            </div>
	        </div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>