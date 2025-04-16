<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="https://cdn.jsdelivr.net/npm/clipboard@2.0.6/dist/clipboard.min.js"></script>

<!-- Slick Carousel CSS -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>

<!-- Slick Carousel Theme (선택 사항) -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
<title>${title }</title>
<c:import url="/inc/head"></c:import>
<script>
$(function(){
	$("#header").addClass("line");
});
function deleteProduct(productId){
	var url = "/products/delete";
	var param = "id="+productId;
	
	if(confirm("삭제하시겠습니까?")){
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

</script>
<style>
.detail_slider_wrap {
  max-width: 800px;
  margin: 0 auto;
}

.detail_slick_slider {
  width: 100%;
  height: auto;
}

.slide {
  width: 100%;
  height: 450px; /* 원하는 높이로 조정 가능 */
  position: relative;
  overflow: hidden;
}
.slide img {
  width: 100%;
  height: 100%;
  object-fit: cover;   /* 슬라이드를 꽉 채우기! 일부 이미지가 잘릴 수 있음 */
  display: block;
}
.slick-prev:before {
  color: black;         /* 또는 원하는 색상 */
  font-size: 30px;
  content: '←';         /* 왼쪽 화살표 */
}
.slick-next:before {
  color: black;         /* 또는 원하는 색상 */
  font-size: 30px;
  content: '→';         /* 오른쪽 화살표 */
}
.video-thumbnail {
  position: relative;
  width: 100%;
  height: 100%;
  cursor: pointer;
}

.video-thumbnail img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.play-button {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  font-size: 50px;
  color: white;
  text-shadow: 2px 2px 4px rgba(0,0,0,0.6);
  z-index: 2;
  pointer-events: none; /* 클릭은 썸네일 전체에 걸림 */
}

.youtube-player {
  display: none;
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}

</style>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="containerWrap">
		<div id="container">
			<div id="contentsPrint">
				<!-- 상세 페이지 상단 -->
				<div id="contentsTitle">
					<h2>${product.name }</h2>
				</div>
				<!-- 상세 페이지 슬라이드 -->
				<div class="detail_slider_wrap">
					<div class="detail_slick_slider">
						<c:forEach items="${detailPhotoList }" var="item">
							<div class="slide">
								<img src="${item.url}" class="slide-img" alt="제품 이미지" />
							</div>
						</c:forEach>
						<c:forEach items="${videoInfoList }" var="item">
							<div class="slide video-slide" data-video-id="${item.videoId}">
							  <div class="video-thumbnail">
							    <img src="https://img.youtube.com/vi/${item.videoId}/hqdefault.jpg" alt="동영상 썸네일" class="item" />
							    <div class="play-button">▶</div>
							  </div>
							  <div class="youtube-player" id="player-${item.videoId}"></div>
							</div>
						</c:forEach>
						<!-- 
						<c:forEach items="${detailPhotoList }" var="item">
							<a href="${item.url}" target="_blank">
								<div class="item" style="background-image: url(${item.url});">
								사진
								</div>
							</a>
						</c:forEach>
						 -->
						 
					</div>
					<!-- 
					<div class="detail_slider_pager">
						<div>
							<div>
								<c:forEach items="${detailPhotoList }" var="item" varStatus="sts">
									<a href="" data-slide-index="${sts.index }"><img src="${item.url}" alt="사진" class="item"></a>
								</c:forEach>
							</div>
						</div>
					</div>
					 -->
				</div>
				<!-- 상세 페이지 제품정보 -->
				<div id="products_info_wrap">
					<table class="tbl1">
						<tbody>
							<tr>
								<th>제품명</th>
								<td>${product.name }</td>
								<th>카테고리</th>
								<td>${product.menuName }</td>
							</tr>
							<tr>
								<th>제품번호</th>
								<td>${product.primaryId}</td>
								<th>규격</th>
								<td>${product.size}</td>
							</tr>
							<tr>
								<th>포장</th>
								<td>${product.packaging }</td>
								<th>배송</th>
								<td>${product.delivery }</td>
							</tr>
							<tr>
								<th>색상</th>
								<td>${product.color }</td>
								<th>재질</th>
								<td>${product.material }</td>
							</tr>
						</tbody>
					</table>
					<div class="bt_wrap">
						<sec:authorize access="hasRole('ROLE_ADMIN')">
							<a href="<c:url value="/products/edit/${product.id }"/>" class="bt1">수정</a>
							<a href="javascript:deleteProduct('${product.id }');" class="bt1">삭제</a>
						</sec:authorize>
						<a id="go-ask" href="#:;" class="bt1">문의하기</a>
						<a href="<c:url value="/products/list/${product.menuId }"/>" class="bt1 on">목록</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>


<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Slick Carousel JS -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script>
let players = {};

var tag = document.createElement('script');
tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
	
function onYouTubeIframeAPIReady() {
  document.querySelectorAll('.video-slide').forEach(slide => {
    const videoId = slide.dataset.videoId;
    const playerDiv = slide.querySelector("#player-"+videoId);
    players[videoId] = new YT.Player(playerDiv, {
      videoId: videoId,
      playerVars: {
        autoplay: 0,
        controls: 1,
        rel: 0
      },
      events: {
        'onReady': function (event) {
          players[videoId] = event.target;
        }
      }
    });
  });
}

$(document).ready(function(){
  $('.detail_slick_slider').slick({
    infinite: true,
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: true,
    dots: true,
    fade: true,
    cssEase: 'linear'
  });

  // 재생 버튼 클릭 이벤트
  $('.video-thumbnail').on('click', function(){
    const $slide = $(this).closest('.video-slide');
    const videoId = $slide.data('video-id');
    const $player = $slide.find('.youtube-player');
    const player = players[videoId];

    $(this).hide(); // 썸네일 숨기기
    $player.show(); // iframe 보이기

    if(player && typeof player.playVideo === 'function') {
      player.playVideo();
    }
  });
});

var clipboard = new ClipboardJS('#go-ask', {
	text: function(){
		return "1. 제품명: ${product.name }\r\n2. 제품번호:${product.primaryId}";
	}
}); 
clipboard.on('success', function(e){
	if(confirm("제품명과 제품번호가 복사되었습니다. 확인을 누르면 질문과 답변 페이지로 이동합니다.")){
		window.location.replace("/board/faq/");
	}
});
clipboard.on('error', function(e){
	
});
</script>
</body>
</html>