<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="/board/inputPwd" method="POST">
	비밀번호를 입력하세요.
	<input type="password" name="password"/>
	<input type="hidden" name="redirectId" value="${redirectId }"/>
	<input type="button" value="확인"/>
</form> 
</body>
</html>