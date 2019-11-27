<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="<c:url value="/resources/js/symposium.js"/>"></script>
<title>${title }</title>
<c:import url="/inc/head"></c:import>
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
function editSubmit(){
	var url = $("#applyForm").attr("action");
	var files = [];
	$("#file_ul").find(".bt_del_file").each(function(i, item){
		files.push($(item).val());
	});
	if(files.length == 0){
		alert("초록을 등록 해주세요.");
		return false;
	}
	
	var param = $("#applyForm").serialize();
	param += "&fileId="+files.join(",");
	
	if(confirm("제출하시겠습니까?")){
		$.ajax({
			url : url,
			data: param,
			type: "POST",
			dataType: 'json'
		}).done(function(json){
			if(json.result > 0){
				window.location.replace(json.move);
			}
		});
	}
}
</script>	
<script src="<c:url value="/resources/js/jquery.ui.widget.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.iframe-transport.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.fileupload.js"/>"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="container_wrap">
		<div id="container">
			<c:import url="/inc/lnb_wrap">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<c:import url="/inc/contentsTitle">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<div id="contentsPrint">
				<!-- 타이틀명 : 신청서 수정 -->
				<div class="member member_form1">
					<div class="paper">
						<form action="<c:url value="/symposium/apply/edit"/>" id="applyForm">
							<dl class="member_chk">
								<dt>참가자 구분</dt>
								<dd>
									<ul class="chk_wrap">
										<li>
											<input type="radio" name="memberType" id="member_chk1" class="radio1" value="2" <c:if test="${apply.memberType eq 2 }">checked</c:if>>
											<label for="member_chk1">일반</label>
										</li>
										<li>
											<input type="radio" name="memberType" id="member_chk2" class="radio1" value="3" <c:if test="${apply.memberType eq 3 }">checked</c:if>>
											<label for="member_chk2">기업</label>
										</li>
										<li>
											<input type="radio" name="memberType" id="member_chk3" class="radio1" value="4" <c:if test="${apply.memberType eq 4 }">checked</c:if>>
											<label for="member_chk3">학생</label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl class="member_chk">
								<dt>발표자 여부</dt>
								<dd>
									<ul class="chk_wrap">
										<li>
											<input type="radio" name="isSpeaker" id="speaker_chk1" class="radio1" value="1" <c:if test="${apply.isSpeaker eq 1 }">checked</c:if>>
											<label for="speaker_chk1">발표자입니다</label>
										</li>
										<li>
											<input type="radio" name="isSpeaker" id="speaker_chk2" class="radio1" value="2" <c:if test="${apply.isSpeaker eq 2 }">checked</c:if>>
											<label for="speaker_chk2">발표자가 아닙니다</label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl class="member_chk">
								<dt>국적</dt>
								<dd>
									<ul class="chk_wrap">
										<li>
											<input type="radio" name="national" id="national_chk1" class="radio1" value="1" <c:if test="${apply.national eq 1 }">checked</c:if>>
											<label for="national_chk1">대한민국</label>
										</li>
										<li>
											<input type="radio" name="national" id="national_chk2" class="radio1" value="2" <c:if test="${apply.national eq 2 }">checked</c:if>>
											<label for="national_chk2">중국</label>
										</li>
										<li>
											<input type="radio" name="national" id="national_chk3" class="radio1" value="3" <c:if test="${apply.national eq 3 }">checked</c:if>>
											<label for="national_chk3">일본</label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl>
								<dt>이름</dt>
								<dd>
									<input type="text" placeholder="이름 입력" class="ipt1" name="username" autocomplete="off" value="${apply.username }">
									<p class="message error">이름을 입력하세요.</p>
								</dd>
							</dl>
							<dl>
								<dt>소속</dt>
								<dd>
									<input type="text" placeholder="소속 입력" class="ipt1" name="classification" autocomplete="off" value="${apply.classification }">
									<p class="message error">소속을 입력하세요.</p>
								</dd>
							</dl>
							<dl>
								<dt>직위</dt>
								<dd>
									<input type="text" placeholder="직위 입력" class="ipt1" name="level" autocomplete="off" value="${apply.level }">
									<p class="message error">직위를 입력하세요.</p>
								</dd>
							</dl>
							<dl class="company_tel">
								<dt>연락처</dt>
								<dd>
									<input type="text" placeholder="연락처 입력" class="ipt1" name="telephone" autocomplete="off" value="${apply.telephone }">
								</dd>
							</dl>
							<dl class="email">
								<dt>이메일 주소</dt>
								<dd>
									<input type="text" placeholder="이메일 아이디 입력" class="ipt1" name="email" autocomplete="off" value="${apply.email }">
									<span>@</span>
									<input type="text" placeholder="도메인 입력" class="ipt1" name="domain" autocomplete="off" value="${apply.domain }">
									<p class="message error">이메일 아이디를 입력하세요.</p>
								</dd>
							</dl>
							<dl class="file">
								<dt>학술대회 초록</dt>
								<dd>
									<div class="board_write_file"  id="dropzone-file">
										<!-- 첨부파일 목록 -->
										<ul id = "file_ul">
											<c:if test = "${apply.fileId gt 0 }">
												<li>
													<span>${apply.filename }</span>
													<input type="button" value="${apply.fileId }" class="bt_del_file" text="삭제">
												</li>
											</c:if>
										</ul>
										<input id="fileupload" type="file" name="files[]" 
											data-url="<c:url value="/upload/file"/>">
									    <div id="progress_file">
									        <div class="progress-bar" style="width: 0%;"></div>
									    </div>
									</div>
								</dd>
							</dl>
							<div class="bt3_item2">
								<input type="button" value="수정완료" class="bt3 on" id="submit" onclick="javascript:editSubmit();">
								<a href="<c:url value="/symposium/apply/view/${apply.id }"/>" class="bt3">이전 페이지로 이동</a>
							</div>
							<input type="hidden" name="id" value="${apply.id }"/>
							<input type="hidden" name="sympId" value="${apply.sympId }"/>
						</form>
					</div>
				</div>
			
			</div>
		</div>
	</div>
</div>
</body>
</html>