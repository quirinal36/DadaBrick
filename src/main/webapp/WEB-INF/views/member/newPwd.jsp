<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
			<c:import url="/inc/lnb_wrap"></c:import>
			<c:import url="/inc/contentsTitle"></c:import>
			<div id="contentsPrint">
				
				<!-- 새 비밀번호 -->
				<div class="member member_form1">
					<div class="paper">
						<dl>
							<dt>새 비밀번호</dt>
							<dd>
								<input type="password" placeholder="새 비밀번호 입력" class="ipt1">
								<p class="message error">6자리 이상 입력하세요.</p>
							</dd>
						</dl>
						<dl>
							<dt>비밀번호 확인</dt>
							<dd>
								<input type="password" placeholder="비밀번호 재입력" class="ipt1">
								<p class="message error">비밀번호가 일치하지 않습니다.</p>
								<p class="message confirm">비밀번호가 일치합니다.</p>
							</dd>
						</dl>
						<input type="button" value="비밀번호 변경" class="bt3">
					</div>
				</div>
				
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>