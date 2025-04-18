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
					<a href="<c:url value="/member/login"><c:param name="loginRedirect" value="${currentUrl}" /></c:url>">
					LOGIN
					</a>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<a href="<c:url value="/member/myinfo"/>">INFO</a>
					<a href="javascript:logout(`${currentUrl}`);">LOGOUT</a>
				</sec:authorize>
			</div>
		</div>
	</div>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script type="text/javascript">
		Kakao.init('${apiKey}');
		function logout(url){
			Kakao.Auth.logout(function(){
				window.location.replace("/logout?logoutRedirect=" + url);
			});
		}
	</script>
</footer>
<script src="<c:url value="/resources/js/jquery.ui.widget.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.iframe-transport.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.fileupload.js"/>"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
<!-- 이미지 교체 팝업 -->
<div class="popupWrap popup1">
	<div class="bg"></div>
	<div class="popup_view_wrap">
		<div>
			<div class="popup_view">
				<input type="button" value="닫기" class="bt_popup_close">
				<!-- 팝업 내용 시작 -->
				<form action="/upload/slide" method="POST">
					<input id="popup-image-upload-btn" type="file" accept="image/*" value="사진 업로드" class="bt1" data-url="<c:url value="/upload/sized/image"/>">
					<div class="address">
						<ul id="slide-image" class="imgUpload_list"> 
						</ul>
						<div id="progress_rep_image" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
					    	<div class="progress-bar" style="width: 0%;" ></div>
					    </div>
					</div>
					<input type="hidden" name="display"/>
					<input type="hidden" name="menuId"/>
					<input type="text" placeholder="링크 입력" class="ipt1" name="linkUrl">
					<input type="button" value="등록" class="bt3 on" onclick="javascript:uploadSlide(this);">
				</form>
				<!-- 팝업 내용 끝 -->
			</div>
		</div>
	</div>
</div>
<!-- 대표전화 -->
<div id="callcenter">
	<a href="tel:15884481">
		<span>대표전화</span>
		<strong>1588-4481</strong>
	</a>
</div>

<!-- AceCounter Log Gathering Script V.8.0.2019080601 -->
<script language='javascript'>
	var _AceGID=(function(){var Inf=['gtb17.acecounter.com','8080','BI3A45840792016','AW','0','NaPm,Ncisy','ALL','0']; var _CI=(!_AceGID)?[]:_AceGID.val;var _N=0;var _T=new Image(0,0);if(_CI.join('.').indexOf(Inf[3])<0){ _T.src ="https://"+Inf[0]+'/?cookie'; _CI.push(Inf);  _N=_CI.length; } return {o: _N,val:_CI}; })();
	var _AceCounter=(function(){var G=_AceGID;var _sc=document.createElement('script');var _sm=document.getElementsByTagName('script')[0];if(G.o!=0){var _A=G.val[G.o-1];var _G=(_A[0]).substr(0,_A[0].indexOf('.'));var _C=(_A[7]!='0')?(_A[2]):_A[3];var _U=(_A[5]).replace(/\,/g,'_');_sc.src='https:'+'//cr.acecounter.com/Web/AceCounter_'+_C+'.js?gc='+_A[2]+'&py='+_A[4]+'&gd='+_G+'&gp='+_A[1]+'&up='+_U+'&rd='+(new Date().getTime());_sm.parentNode.insertBefore(_sc,_sm);return _sc.src;}})();
</script>
<!-- AceCounter Log Gathering Script End -->
<script type="text/javascript">
$(document).ready(function(){
	// 대표이미지
	$('#popup-image-upload-btn').fileupload({
		imageCrop: true,
        dataType: 'json',
        done: function (e, data) {
        	var file = data.result.file;
        	
        	$("#slide-image").empty();
        	$("#slide-image").append(makeLI(file, 'photoId'));
        },
        progressall: function (e, data) {
        	var progress = parseInt(data.loaded / data.total * 100, 10);
            
            $('#progress_img .progress-bar').css(
                'width',
                progress + '%'
            );
            if(progress == 100){
            	$('#progress_img .progress-bar').css('width','0');
            }
        },
        dropZone: $('#dropzone-img-rep')
	});
	$(".bt_popup_close").click(function(btn){
		$("#slide-image").empty();
	});
});
function uploadSlide(button){
	var url = $(button).parent().attr("action");
	var param = $(button).parent().serialize();
	
	if(confirm("등록하시겠습니까?")){
		$.ajax({
			url : url,
			data: param,
			type: "POST",
			dataType: "json"
		}).done(function(json){
			if(json.result > 0){
				alert("등록되었습니다.");
				window.location.reload();
			}
		});
	}
}
function makeLI(file, name){
	return $("<li>")
		.append(
			$("<input>")
				.attr("type","button").addClass("bt_imgDelete").val("삭제")
				.attr("onclick", "delImageClick(this);"))
		.append(
			$("<input>")
				.attr("type","hidden").attr("name", name).val(file.id))
		.attr("id", file.id).attr("style", "background-image:url("+file.url+");");
}
function delImageClick(btn){
	var id = $(btn).parent().find("input[type='hidden']").val();
	var url = "/upload/delete";
	var param = "id="+id;

	$.ajax({
		url : url,
		data: param,
		type: "POST",
		dataType: "json"
	}).done(function(json){
		$(btn).parent().remove();
		$("#image-upload-btn").show();
	});
}
</script>