<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="<c:url value="/resources/js/symposium.js"/>"></script>
<link href="<c:url value="/resources/css/dropzone.css"/>" type="text/css" rel="stylesheet" />
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js?autoload=false"></script>
<title>${title }</title>
<c:import url="/inc/head"></c:import>
<script type="text/javascript">
$(document).ready(function(){
	$("input[name='isSpeaker']").on('change', function(){
		var isSpeaker = parseInt($(this).val()) == 1? true : false;
		if(isSpeaker){
			//$(".file").show();
		}else{
			//$(".file").hide();
			$("#file_ul").empty();
		}
	});
	$(".nationality .radio1").on('change', function(){
		$(".nationality .radio1").each(function(i, item){
			var value = parseInt($(item).val());
			if(value == 4 && $(item).prop("checked")){
				$("input[name='nationalCustom']").attr("disabled", false);
				$("input[name='nationalCustom']").show();
			}else {
				$("input[name='nationalCustom']").val('');
				$("input[name='nationalCustom']").attr("disabled", true);
				$("input[name='nationalCustom']").hide();
			}
		});
	});
	$("input[name='telephone']").keyup(function(e){
		if(e.keyCode >= 96 && e.keyCode <=105){
			
		}else{
			$(this).val($(this).val().replace(/[^0-9]/g,""));
		}
	});
});
function delButtonClick(button){
	var id = $(button).val();
	$(".bt_del_file").each(function(index, item){
		if(id == $(item).val()){
			$(item).parent().remove();
			return;
		}
	});
}
function applySubmit(){
	var url = $("#applyForm").attr("action");
	var files = [];
	$("#file_ul").find(".bt_del_file").each(function(i, item){
		files.push($(item).val());
	});
	var isSpeaker = parseInt($("input[name='isSpeaker']:checked").val())== 1? true : false;
	
	if(files.length == 0 && isSpeaker){
		alert(jQuery.i18n.prop("symposium.submit_form"));
		return false;
	}
	
	var param = $("#applyForm").serialize();
	
	if(isSpeaker){
		param += "&files="+files.join(",");
	}
	
	if($("#national_chk4").prop("checked") == true && $("input[name='nationalCustom']").val() == ''){
		alert(jQuery.i18n.prop("symposium.national.empty"));
		return false;
	}
	if($("input[name='username']").val() == ''){
		alert(jQuery.i18n.prop("symposium.empty.name"));
		return false;
	}	
	if($("input[name='classification']").val() == ''){
		alert(jQuery.i18n.prop("symposium.empty.affiliation"));
		return false;
	}	
	if($("input[name='level']").val() == ''){
		alert(jQuery.i18n.prop("symposium.empty.position"));
		return false;
	}	
	if($("input[name='telephone']").val() == ''){
		alert(jQuery.i18n.prop("symposium.empty.telephone"));
		return false;
	}	
	if($("input[name='email']").val() == ''){
		alert(jQuery.i18n.prop("symposium.empty.email"));
		return false;
	}
	if($("input[name='domain']").val() == ''){
		alert(jQuery.i18n.prop("symposium.empty.email"));
		return false;
	}
		
	if(confirm(jQuery.i18n.prop("symposium.to_register"))){
		$.ajax({
			url : url,
			data: param,
			type: "POST",
			dataType: 'json'
		}).done(function(json){
			if(json.result > 0){
				move(2);
			}else{
				alert(json.msg);
			}
		});
	}
}
</script>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="container_wrap">
		<div id="container">
			<div id="contentsTitle">
				<div>
					<h2>
						<spring:message code="symposium.attendant"/>
					</h2>
				</div>
			</div>
			<c:choose>
				<c:when test="${expired eq true }">
					<%-- 기간이 만료되었거나 아직 시작하지 않았을 때 화면구성 --%>
					${expired_msg }
				</c:when>
				<c:otherwise>
					<div id="contentsPrint">
						<!-- 심포지엄 참가신청 - 동의 -->
						<div class="member form_step1">
							<!-- 현재상태 -->
							<div class="location">
								<div class="on"><spring:message code="symposium.apply.tab1"/></div>
								<div><spring:message code="symposium.apply.tab2"/></div>
								<div><spring:message code="symposium.apply.tab3"/></div>
							</div>
							<div class="paper">
								<strong><spring:message code="symposium.apply.policy"/></strong>
								<div class="term" style="height: auto;">
									<spring:message code="symposium.privacy_policy" text="symposium.privacy_policy"></spring:message>
								</div>
								<div class="chk_wrap">
									<input type="checkbox" id="term_chk1" class="chk1">
									<label for="term_chk1"><spring:message code="symposium.apply.agree"/></label>
								</div>
								<input type="button" value="<spring:message code="symposium.apply.next"/>" class="bt3 on" onclick="javascript:move(1);">
							</div>
						</div>
						
						<!-- 심포지엄 참가신청 - 정보 입력 -->
						<div class="member member_form1 form_step2" style="display: none;">
							<!-- 현재상태 -->
							<div class="location">
								<div><spring:message code="symposium.apply.tab1"/></div>
								<div class="on"><spring:message code="symposium.apply.tab2"/></div>
								<div><spring:message code="symposium.apply.tab3"/></div>
							</div>
							<div class="paper">
								<form action="<c:url value="/symposium/apply"/>" id="applyForm">
									<input type="hidden" name="sympId" value="${symposium.id }"/>
									<dl class="member_chk">
										<dt><spring:message code="symposium.attendee"/></dt>
										<dd>
											<ul class="chk_wrap">
												<li>
													<input type="radio" name="memberType" id="member_chk1" class="radio1" value="2" checked>
													<label for="member_chk1"><spring:message code="symposium.general"/></label>
												</li>
												<li>
													<input type="radio" name="memberType" id="member_chk2" class="radio1" value="3">
													<label for="member_chk2"><spring:message code="symposium.apply.view.company"/></label>
												</li>
												<li>
													<input type="radio" name="memberType" id="member_chk3" class="radio1" value="4">
													<label for="member_chk3"><spring:message code="symposium.apply.view.student"/></label>
												</li>
											</ul>
										</dd>
									</dl>
									<dl class="member_chk">
										<dt><spring:message code="symposium.apply.view.is_speaker"/></dt>
										<dd>
											<ul class="chk_wrap">
												<li>
													<input type="radio" name="isSpeaker" id="speaker_chk1" class="radio1" value="1">
													<label for="speaker_chk1"><spring:message code="symposium.apply.view.speaker"/></label>
												</li>
												<li>
													<input type="radio" name="isSpeaker" id="speaker_chk2" class="radio1" value="2" checked>
													<label for="speaker_chk2"><spring:message code="symposium.apply.view.no_speaker"/></label>
												</li>
											</ul>
										</dd>
									</dl>
									<dl class="member_chk nationality">
										<dt><spring:message code="symposium.nationality"/></dt>
										<dd>
											<ul class="chk_wrap">
												<li>
													<input type="radio" name="national" id="national_chk1" class="radio1" value="1" checked>
													<label for="national_chk1"><spring:message code="symposium.korea"/></label>
												</li>
												<li>
													<input type="radio" name="national" id="national_chk2" class="radio1" value="2">
													<label for="national_chk2"><spring:message code="symposium.china"/></label>
												</li>
												<li>
													<input type="radio" name="national" id="national_chk3" class="radio1" value="3">
													<label for="national_chk3"><spring:message code="symposium.japan"/></label>
												</li>
												<li>
													<input type="radio" name="national" id="national_chk4" class="radio1" value="4">
													<label for="national_chk4">
														<spring:message code="symposium.national.etc"/>
													</label>
												</li>
											</ul>
											<input type="text" placeholder="국적을 입력하세요." class="ipt1" name="nationalCustom" style="display:none;">
										</dd>
									</dl>
									<dl>
										<dt><spring:message code="symposium.name"/></dt>
										<dd>
											<input type="text" placeholder="<spring:message code="symposium.apply.search.please_input_name"/>" class="ipt1" name="username" autocomplete="off" value="${user.username }">
											<p class="message error"><spring:message code="symposium.apply.search.please_input_name"/></p>
										</dd>
									</dl>
									<dl>
										<dt><spring:message code="member.affiliation"/></dt>
										<dd>
											<input type="text" placeholder="<spring:message code="member.enter_your_affiliation"/>" class="ipt1" name="classification" autocomplete="off" value="${user.classification }">
											<p class="message error"><spring:message code="member.enter_your_affiliation"/></p>
										</dd>
									</dl>
									<dl>
										<dt><spring:message code="symposium.position"/></dt>
										<dd>
											<input type="text" placeholder="<spring:message code="member.enter_your_position"/>" class="ipt1" name="level" autocomplete="off" value="${user.level }">
											<p class="message error"><spring:message code="member.enter_your_position"/></p>
										</dd>
									</dl>
									<dl class="company_tel">
										<dt><spring:message code="symposium.tel"/></dt>
										<dd>
											<input type="text" placeholder="<spring:message code="symposium.tel.hint"/>" class="ipt1" name="telephone" autocomplete="off" value="${user.telephone }">
										</dd>
									</dl>
									<dl class="email">
										<dt><spring:message code="symposium.email"/></dt>
										<dd>
											<input type="text" placeholder="<spring:message code="member.enter_your_email"/>" class="ipt1" name="email" autocomplete="off" value="${user.email }">
											<span>@</span>
											<input type="text" placeholder="<spring:message code="member.enter_your_domain"/>" class="ipt1" name="domain" autocomplete="off" value="${user.domain }">
											<p class="message error"><spring:message code="member.enter_your_email"/></p>
										</dd>
									</dl>
									<dl class="file">
										<dt><spring:message code="symposium.form"/></dt>
										<dd>
											<div class="board_write_file"  id="dropzone-file">
												<!-- 첨부파일 목록 -->
												<ul id = "file_ul">
													<!-- 
													<li>
														<span>2019 하계 중국 심포지움 안내파일.hwp</span>
														<input type="button" value="삭제" class="bt_del_file">
													</li>
													 -->
												</ul>
												<input id="fileupload" type="file" name="files[]" 
													data-url="<c:url value="/upload/file"/>">
											    <div id="progress_file">
											        <div class="progress-bar" style="width: 0%;"></div>
											    </div>
											</div>
										</dd>
									</dl>
									<input type="button" value="<spring:message code="symposium.submit"/>" class="bt3 on" id="submit" onclick="javascript:applySubmit();">
								</form>
							</div>
						</div>
						
						<!-- 심포지엄 참가신청 - 신청완료 -->
						<div class="member form_complete" style="display:none;">
							<div class="paper">
								<spring:message code="symposium.after.submit"/><br>						
								<a href="<c:url value="/"/>" class="bt3 on">HOME</a>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
<script type="text/javascript">
$(document).ready(function(){
	$('#fileupload').fileupload({
    	imageCrop: true,
        dataType: 'json',
        done: function (e, data) {
        	
        	var file = data.result.file;
            
        	$("#file_ul").empty();
           	$("#file_ul").append(
           		$("<li>").append(
           			$("<span>").text(file.name)
           		).append(
           			$("<input>").attr("type","button").addClass("bt_del_file").attr("title","삭제")
           				.attr("onclick", "delButtonClick(this);").val(file.id)
           		)
           	);
        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            
            $('#progress_file .progress-bar').css(
                'width',
                progress + '%'
            );
            if(progress == 100){
            	$('#progress_file .progress-bar').css('width','0%');
            }
        },
 
        dropZone: $('#dropzone-file')
    });
});

</script>

<script src="<c:url value="/resources/js/jquery.ui.widget.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.iframe-transport.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.fileupload.js"/>"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>	
</body>
</html>