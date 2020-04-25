$(function(){
	// idx_main slider
	$(".idx_main").bxSlider({
		mode: "fade",
		controls: true,
		auto: true,
		pager: true,
		pause: 5000
	});
	// idx_products slider
	$(".idx_products").bxSlider({
		controls: true,
		auto: false,
		pager: false,
		maxSlides: 4,
		slideWidth: 220,
		slideMargin: 60,
		moveSlides: 1
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


// idx_insta size
function idx_insta_size() {
	var idx_instaWrap_width = $(".idx_insta_wrap").width();
	var insta_margin = 10;
	var insta_width = ( idx_instaWrap_width - insta_margin * 5 ) / 6;
	$(".idx_insta a").width(insta_width).height(insta_width);
	$(".idx_insta a").css("margin-top", insta_margin);
	$(".idx_insta a:nth-child(-n+6)").css("margin-top", 0);
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













