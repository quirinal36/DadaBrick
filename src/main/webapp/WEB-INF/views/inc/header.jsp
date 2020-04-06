<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script>

var startDate = "2020년 2월 21일"
var endDate = "사회적 거리두기 종료일"
console.log("전주코딩학원은 " + startDate + "부터 " + endDate + "까지 휴원합니다.");

// header 상단 고정
$(window).scroll(function(){
	var sPosition = $(window).scrollTop();
	console.log(sPosition);
	if( sPosition > 0 ) {
		$("#header").addClass("fixed");
	} else {
		$("#header").removeClass("fixed");
	}
});
</script>
<header>
	<div id="headerWrap">
		<div id="header">
			<div>
				<h1>
					<a href="/">
						<img src="/resources/img/comm/logo.png" alt="logo">
					</a>
				</h1>
				<div id="gnbWrap">
					<ul class="dep1">
						<li>
							<a href="#">점토벽돌</a>
							<ul class="dep2">
								<li><a href="#">점토벽돌</a></li>
								<li><a href="#">전돌벽돌</a></li>
								<li><a href="#">수입벽돌</a></li>
								<li><a href="#">수공예벽돌</a></li>
							</ul>
						</li>
						<li>
							<a href="#">타일벽돌</a>
							<ul class="dep2">
								<li><a href="#">모노타일/브릭</a></li>
								<li><a href="#">점토타일</a></li>
								<li><a href="#">고벽돌타일</a></li>
								<li><a href="#">청고벽돌타일</a></li>
								<li><a href="#">디자인블록</a></li>
							</ul>
						</li>
						<li>
							<a href="#">고벽돌</a>
							<ul class="dep2">
								<li><a href="#">고벽돌</a></li>
								<li><a href="#">고벽돌타일</a></li>
								<li><a href="#">청고벽돌</a></li>
								<li><a href="#">청고벽돌타일</a></li>
							</ul>
						</li>
						<li>
							<a href="#">화산석</a>
							<ul class="dep2">
								<li><a href="#">화산석타일</a></li>
								<li><a href="#">화산석판재</a></li>
								<li><a href="#">화산석부정형</a></li>
								<li><a href="#">화산석벽돌</a></li>
							</ul>
						</li>
						<li>
							<a href="#">화강석</a>
							<ul class="dep2">
								<li><a href="#">화강석판재</a></li>
								<li><a href="#">화강석타일</a></li>
								<li><a href="#">화강석공예</a></li>
								<li><a href="#">아트월타일</a></li>
							</ul>
						</li>
						<li>
							<a href="#">바닥벽돌</a>
							<ul class="dep2">
								<li><a href="#">점토바닥벽돌</a></li>
								<li><a href="#">벽돌타일(바닥)</a></li>
								<li><a href="#">장애인바닥벽돌</a></li>
								<li><a href="#">인터노킹</a></li>
							</ul>
						</li>
						<li>
							<a href="#">고객센터</a>
							<ul class="dep2">
								<li><a href="#">공지사항</a></li>
								<li><a href="#">질문과 답변</a></li>
								<li><a href="#">회사소개</a></li>
								<li><a href="#">자료실</a></li>
							</ul>
						</li>
					</ul>
				</div>
				<div class="right">
					<input type="button" value="검색" class="bt_search">
					<a href="#" target="_blank" class="bt_insta"><img src="/resources/img/comm/bt_insta.png" alt="인스타그램"></a>
				</div>
			</div>
		</div>
	</div>
</header>
