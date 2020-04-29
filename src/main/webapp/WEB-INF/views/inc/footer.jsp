<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<footer>
	<div id="footerWrap">
		<div>
			<ul>
				<li>(유)다다벽돌</li>
				<li>사업자등록번호 : 836-88-00727</li>
				<li>대표 : 김철민</li>
				<li>E-mail : dadabrick@naver.com</li>
			</ul>
			<ul>
				<li>공장 및 전시장 : 전북 김제시 백구면 학동리 581-19</li>
				<li>TEL : 063-545-1516</li>
				<li>FAX : 063-545-1517</li>
			</ul>
			<ul>
				<li>서울전시장 : 서울시 강남구 논현로 127길 23</li>
				<li>TEL 02-542-7779</li>
				<li>서울영업부 : 010-8989-2904</li>
				<li>영남권영업부 : 010-6789-6298</li>
			</ul>
			<ul>
				<li>Copyright (유)다다벽돌. All Rights Reserved.</li>
			</ul>
			<div class="right">
				<sec:authorize access="isAnonymous()">
					<a href="<c:url value="/member/login"/>">LOGIN</a>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<a href="#">INFO</a>
					<a href="javascript:logout();">LOGOUT</a>
				</sec:authorize>
			</div>
		</div>
	</div>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script type="text/javascript">
		Kakao.init('${apiKey}');
		function logout(){
			Kakao.Auth.logout(function(){
				window.location.replace("/j_spring_security_logout");
			});
		}
	</script>
</footer>

<!-- 이미지 교체 팝업 -->
<div class="popupWrap popup1">
	<div class="bg"></div>
	<div class="popup_view_wrap">
		<div>
			<div class="popup_view">
				<input type="button" value="닫기" class="bt_popup_close">
				<!-- 팝업 내용 시작 -->
				<form>
					<input type="button" value="사진 업로드" class="bt1">
					<div class="address">
						153156153132.jpg
						<input type="button" value="삭제" class="bt_del">
					</div>
					<input type="text" placeholder="링크 입력" class="ipt1">
					<input type="button" value="등록" class="bt3 on">
				</form>
				<!-- 팝업 내용 끝 -->
			</div>
		</div>
	</div>
</div>