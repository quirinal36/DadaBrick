<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
					<h2>이메일무단수집거부</h2>
				</div>
			</div>
			<c:import url="/inc/contentsTitle">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<div id="contentsPrint">
				<div class="term_wrap">
					본 웹사이트에 게시된 이메일 주소가 전자우편 수집 프로그램이나 그 밖의 기술적 장치를 이용하여 무단으로 수집되는 것을 거부하며, 이를 위반시 정보통신망법에 의해 형사처벌됨을 유념하시기 바랍니다.<br><br>
					<정보통신망 이용촉진 및 정보보호 등에 관한 법률><br><br>
					<strong>제50조의2 (전자우편주소의 무단 수집행위 등 금지)</strong><br>
					누구든지 인터넷 홈페이지 운영자 또는 관리자의 사전 동의 없이 인터넷 홈페이지에서 자동으로 전자우편주소를 수집 하는 프로그램 그 밖의 기술적 장치를 이용하여 전자우편주소를 수집하여서는 아니된다.<br>
					누구든지 제1항의 규정을 위반하여 수집된 전자우편주소를 판매ㆍ유통하여서는 아니된다.<br>
					누구든지 제1항 및 제2항의 규정에 의하여 수집ㆍ판매 및 유통이 금지된 전자우편주소임을 알고 이를 정보 전송에 이용하여서는 아니된다.<br><br>
					<strong>제74조 (벌칙) 다음 각호의 1에 해당하는 자는 1천만원 이하의 벌금에 처한다.</strong><br>
					제8조제4항의 규정을 위반하여 표시ㆍ판매 또는 판매할 목적으로 진열한 자<br>
					제44조의7제1항제1호의 규정을 위반하여 음란한 부호ㆍ문언ㆍ음향ㆍ화상 또는 영상을 배포ㆍ판매ㆍ임대하거나 공연히 전시한 자<br>
					제44조의7제1항제3호의 규정을 위반하여 공포심이나 불안감을 유발하는 부호ㆍ문언ㆍ음향ㆍ화상 또는 영상을 반복적으로 상대방에게 도달하게 한 자<br>
					제50조제6항의 규정을 위반하여 기술적 조치를 한 자<br>
					제50조의8의 규정을 위반하여 광고성 정보를 전송한 자 제50조의2의 규정을 위반하여 전자우편 주소를 수집ㆍ판매ㆍ유통 또는 정보전송에 이용한 자<br>
					제50조의8의 규정을 위반하여 광고성 정보를 전송한 자<br>
					제53조제4항을 위반하여 등록사항의 변경등록 또는 사업의 양도ㆍ양수 또는 합병ㆍ상속의 신고를 하지 아니한 자<br>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>