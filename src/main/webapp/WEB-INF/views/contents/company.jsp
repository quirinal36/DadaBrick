<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
<script>
$(function(){
	$("#header").addClass("line");
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
					<h2>회사소개</h2>
				</div>
				<div class="company_wrap">
					<div class="company_section1">
						<img src="/resources/img/comm/logo.png" class="다다벽돌">
						<div>
							<p>
								창조적인 공간 연출!<br>
								고객과 공간을 함께 만들어가는 아름다운 동행!<br>
								끊임없는 신(新) 개발과 다양성!
							</p>
							<p>
								그리고 다다벽돌만의 특별한 감각으로<br>
								차별화된 최고의 제품만을 고집합니다.							
							</p>
						</div>
					</div>
				</div>
				<div class="company_section2">
					<strong>
						고풍스럽고 내추럴한 분위기와<br>
						세련되고 현대적인 감각까지!
					</strong>
					<ul>
						<li>
							<div class="image" style="background-image: url(/resources/img/contents/company_section2_1.png);">사진</div>
							<p>
								오늘날의 건축문화는 단순한 기술이 아닌,<br>
								친환경적이고  내구성과 함께 미적인 요소를 모두 갖춘<br>
								사람과 공간이 함께 살아 숨 쉬는 행복한 기술입니다.
							</p>
						</li>
						<li>
							<div class="image" style="background-image: url(/resources/img/contents/company_section2_1.png);">사진</div>
							<p>
								시각적인 만족을 넘어서 고객의 건강을 생각하고,<br>
								현대적인 감각과 미래를 선도하는 기술,<br>
								최상급 건축 마감재 개발에 힘쓰겠습니다.
							</p>
						</li>
						<li>
							<div class="image" style="background-image: url(/resources/img/contents/company_section2_1.png);">사진</div>
							<p>
								소비자에게 다양성과 차별화, 질 좋은 제품을 공급하기 위해<br>
								제품 한 장 한 장에 정직과, 성실, 신뢰를 담아<br>
								최선을 다해 좋은 제품만을 생산하겠습니다.
							</p>
						</li>
					</ul>
				</div>
				<div class="company_section3">
					<!-- * 카카오맵 - 지도퍼가기 -->
					<!-- 1. 지도 노드 -->
					<div id="daumRoughmapContainer1588132619054" class="root_daum_roughmap root_daum_roughmap_landing"></div>
					
					<!--
						2. 설치 스크립트
						* 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.
					-->
					<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
					
					<!-- 3. 실행 스크립트 -->
					<script charset="UTF-8">
						new daum.roughmap.Lander({
							"timestamp" : "1588132619054",
							"key" : "y6jq",
							"mapWidth" : "1000",
							"mapHeight" : "400"
						}).render();
					</script>
					<div class="cont">
						<strong>전시장 오시는 길</strong>
						<div>
							<dl>
								<dt>주소</dt>
								<dd>
									서울시 강남구 논현로 127길 23<br>
									(학동역 4번출구에서 도보 5분)
								</dd>
							</dl>
							<dl>
								<dt>전화번호</dt>
								<dd>02-542-7779 </dd>
							</dl>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>