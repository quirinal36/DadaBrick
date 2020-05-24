$(function(){
	// idx_main slider
	$(".idx_main").bxSlider({
		mode: "fade",
		controls: true,
		auto: true,
		pager: true,
		pause: 5000
	});
	// detail_slider
	$(".detail_slider").bxSlider({
		mode: "fade",
		controls: true,
		auto: true,
		pager: true,
		pause: 5000,
		pagerCustom: ".detail_slider_pager"
	});
});

function idxProductsSlider() {
	var window_width = $(window).width();
	if( window_width <= 1000 ) {
		$(".idx_products").bxSlider({
			controls: true,
			auto: false,
			pager: false,
			moveSlides: 1,
			minSlides: 3,
			maxSlides: 3,
			slideWidth: 82,
			slideMargin: 5
		});
	} else {
		$(".idx_products").bxSlider({
			controls: true,
			auto: false,
			pager: false,
			moveSlides: 1,
			minSlides: 3,
			maxSlides: 4,
			slideWidth: 220,
			slideMargin: 60
		});
	}
}

$(function(){
	idxProductsSlider();
});

$(window).resize(function(){
	idxProductsSlider();
});


// idx_insta size
function idx_insta_size() {
	var window_width = $(window).width();
	if( window_width <= 1000 ) {
		var idx_instaWrap_width = $(".idx_insta_wrap").width();
		var insta_margin = 5;
		var insta_width = ( idx_instaWrap_width - insta_margin * 3 ) / 4;
		$(".idx_insta li").width(insta_width).height(insta_width);
		$(".idx_insta li").css("margin-top", insta_margin);
		$(".idx_insta li:nth-child(-n+4)").css("margin-top", 0);
	} else {
		var idx_instaWrap_width = $(".idx_insta_wrap").width();
		var insta_margin = 10;
		var insta_width = ( idx_instaWrap_width - insta_margin * 5 ) / 6;
		$(".idx_insta li").width(insta_width).height(insta_width);
		$(".idx_insta li").css("margin-top", insta_margin);
		$(".idx_insta li:nth-child(-n+6)").css("margin-top", 0);
	}
}

$(function(){
	idx_insta_size();
});
$(window).resize(function(){
	idx_insta_size();
});

// 상품목록 탭메뉴 가로길이
$(function(){
	var num = $("#contentsTitle ul li").length; // 탭메뉴 갯수
	$("#contentsTitle ul li").css("width", 100 / num + "%"); // 탭메뉴 넓이
});

// 팝업
$(function(){
	// 팝업 닫기 버튼
	$(".popupWrap .bt_popup_close").click(function(){
		$(".popupWrap").fadeOut();
	});
	
	// 팝업1 : 인덱스 상단 이미지 변경 팝업
	$(".popup1_opener").click(function(){
		var display = $(this).parent().find("input[name='display']").val();
		var menuId = $(this).parent().find("input[name='menuId']").val();
		
		$(".popup1 form input[name='display']").val(display);
		$(".popup1 form input[name='menuId']").val(menuId);
		
		if(parseInt($(".popup1 form input[name='display']").val()) > 1){
			$(".popup1 form input[name='linkUrl']").hide();
		}
		$(".popup1").fadeIn();
	});
});


// 상세보기 페이지 썸네일 영역 가로길이
function detailPagerWidth() {
	var img_width = $(".detail_slider_pager a").width(); // 썸네일 1개당 가로길이
	var img_length = $(".detail_slider_pager a").length; // 썸네일 갯수
	var pager_width = (img_width + 4) * img_length + 36; // 썸네일 영역 가로길이
	$(".detail_slider_pager > div > div").width(pager_width);
}

$(function(){
	var window_width = $(window).width();
	if( window_width <= 1000 ) {
		detailPagerWidth();
	}
});
$(window).resize(function(){
	var window_width = $(window).width();
	if( window_width <= 1000 ) {
		detailPagerWidth();
	} else {
		$(".detail_slider_pager > div > div").css("width", "auto");
	}
});







