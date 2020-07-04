<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="baseUrl" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>${title }</title>
	<c:import url="/inc/head"></c:import>
	<link href="<c:url value="/resources/css/dropzone.css"/>" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value="/resources/js/service/HuskyEZCreator.js"/>" charset="utf-8"></script>
	<script type="text/javascript">
		function replaceAll(str, searchStr, replaceStr){
			var arr = str.split(searchStr);
			return str.split(searchStr).join(replaceStr);
		}
		$(document).ready(function(){
			var url = $("#clearUrl").val();
			
			var isLoginUrl = $("input[name='isLoginUrl']").val();
			var loginUrl = $("input[name='loginUrl']").val();
			var redirectUrl = $("input[name='currentUrl']").val();
			$.ajax({
				url : isLoginUrl,
				type: "GET",
				dataType: 'json'
			}).done(function(json){
				if(json.result){
					
				}else{
					alert("로그인해주세요.");
					window.location.replace(loginUrl +"?loginRedirect=" + redirectUrl);
				}
			});
			
			$("#pwd-input").on("keyup", function(){
				$(this).val($(this).val().replace(/[^0-9]/g, ""));
			})
		});
		
		function delButtonClick(button){
			var id = $(button).val();
			$(".bt_del_img").each(function(index, item){
				if(id == $(item).val()){
					$(item).parent().remove();
					return;
				}
			});
		}
		function delFileClick(button){
			var id = $(button).val();
			$(".bt_del_file").each(function(index, item){
				if(id == $(item).val()){
					$(item).parent().remove();
					return;
				}
			});
		}
		function insertBoard(boardType){
			oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
			
			var textContent = document.getElementById("ir1").value;
			
			textContent = replaceAll(textContent, "'", "&apos;");
			textContent = replaceAll(textContent, "\"", "&quot;");
			textContent = replaceAll(textContent, "&nbsp;", " ");
			textContent = replaceAll(textContent, "&", "%26");
			
			var url = $("form").attr("action");
			
			var title = $("input[name='title']").val();
			title = replaceAll(title, "'", "&apos;");
			title = replaceAll(title, "\"", "&quot;");
			title = replaceAll(title, "&nbsp;", " ");
			title = replaceAll(title, "&", "%26");
			
			var content = textContent;
			var pictures = [];
			var files = [];
			$("#picture_ul").find(".bt_del_img").each(function(i, item){
				pictures.push($(item).val());
			});
			$("#file_ul").find(".bt_del_file").each(function(i, item){
				files.push($(item).val());
			});
			
			var param = $("form").serialize(); 
			param += "&pictures="+pictures.join(",");
			param += "&files="+files.join(",");
			param += "&content="+content;
			
			if(confirm("글을 등록시키겠습니까?")){
				$.ajax({
					url : url,
					data: param,
					type: "POST",
					dataType : "json"
				}).done(function(json){
					if(json.result > 0){
						alert("글 등록이 완료되었습니다.");
						window.location.replace(json.listUrl);
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
	<div id="containerWrap">
		<div id="container">
			<div id="contentsPrint">
				<!-- 상세 페이지 상단 -->
				<div id="contentsTitle">
					<h2>${boardName }</h2>
				</div>
				<c:choose>
					<c:when test="${board.id gt 0 }">
						<c:set value="/board/edit" var="action"/>
					</c:when>
					<c:otherwise>
						<c:set value="/board/write" var="action"/>
					</c:otherwise>
				</c:choose>
				<form action="${action }" method="post">
					<input type="hidden" name="boardType" value="${boardType }"/>
					<input type="hidden" name="isLoginUrl" value="<c:url value="${authUrl }"/>"/>
					<input type="hidden" name="loginUrl" value="<c:url value="/member/login"/>"/>
					<input type="hidden" name="currentUrl" value="${current }"/>
					<input type="hidden" name="listUrl" value="${listUrl }"/>
					<div class="board_write_wrap">
						<div class="board_write" style="margin-top:60px;">
							<div class="board_write_title">
								<div class="title"><spring:message code="board.title" text="board.title"></spring:message></div>
								<div class="title_ipt">
									<input type="text" placeholder="<spring:message code="board.title" text="board.title"></spring:message>" name="title" autocomplete="off" 
										value="${board.title }">
								</div>
								
								<c:choose>
									<c:when test="${boardType eq 17 }">
										<div class="writer">
											<spring:message code="board.user" text="board.user"></spring:message>
										</div>
										<div class="writer_ipt">
											<c:if test="${board.id gt 0 }">
												<input type="hidden" name="id" value="${board.id }"/>
											</c:if>
											<input type="text" placeholder="<spring:message code="board.user" text="board.user"></spring:message>" name="writerName"/>
										</div>
									</c:when>
									<c:otherwise>
										<div class="writer">
											<spring:message code="board.user" text="board.user"></spring:message>
										</div>
										<div class="writer_ipt">
											<c:choose>
												<c:when test="${board.writer gt 0 }">
													<input type="hidden" name="writer" value="${board.writer}"/>
													<c:if test="${board.id gt 0 }">
														<input type="hidden" name="id" value="${board.id }"/>
													</c:if>
													<input type="text" placeholder="<spring:message code="board.user" text="board.user"></spring:message>" readonly autocomplete="off"
														value="${board.writerName }" >
												</c:when>
												<c:otherwise>
													<input type="hidden" name="writer" value="${user.kakaoId}"/>
													<input type="text" placeholder="<spring:message code="board.user" text="board.user"></spring:message>" readonly autocomplete="off"
														value="${user.nickname }" >
												</c:otherwise>
											</c:choose>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="board_write_cont">
								<textarea id="ir1" rows="10" style="width:100%; height:412px; display:none;"></textarea>	                        
							</div>
							<c:if test="${boardType eq 17 }">
								<div class="board_write_password">
									<dl>
										<dt>비밀번호</dt>
										<dd><input id="pwd-input" type="password" placeholder="비밀번호(숫자 4자리)" name="pwd" maxlength="4"></dd>
									</dl>
								</div>
							</c:if>
							<div class="board_write_img" id="dropzone-img">
								<dl>
									<dt><spring:message code="board.image" text="board.image"></spring:message></dt>
									<dd>
										<!-- 사진 목록 -->
										<ul id="picture_ul">
											<c:forEach items="${photos }" var="item">
												<li style="background-image:url('${item.url}')" id="${item.id }">
													<input type="button" title="삭제" class="bt_del_img" onclick="delButtonClick(this);" value="${item.id }"/>
												</li>
											</c:forEach>
										</ul>
										<!-- 첨부하기 버튼 -->
										<input id="imageupload" type="file" name="files[]" 
											accept="image/*" data-url="<c:url value="/upload/sized/image"/>" multiple>
									    <div id="progress_img" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
									        <div class="progress-bar" style="width: 0%;" ></div>
									    </div>
									</dd>
								</dl>
							</div>
							<div class="board_write_file" id="dropzone-file">
								<dl>
									<dt><spring:message code="board.attachment" text="board.attachment"></spring:message></dt>
									<dd>
										<!-- 첨부파일 목록 -->
										<ul id = "file_ul">
											<c:forEach items="${files }" var="item">
												<li id="${item.id }">
													<span>
														${item.name }
													</span>
													<input type="button" title="삭제" class="bt_del_file" onclick="delFileClick(this);" value="${item.id }"/>
												</li>
											</c:forEach>
										</ul>
										<input id="fileupload" type="file" name="files[]" 
											data-url="<c:url value="/upload/file"/>" multiple>
									    <div id="progress_file">
									        <div class="progress-bar" style="width: 0%;"></div>
									    </div>
									</dd>
								</dl>
							</div>
							<div class="bt_wrap">
								<a href="javascript:insertBoard();" class="bt1 on">등록</a>
								<a href="${listUrl }"  class="bt1">취소</a>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
<script type="text/javascript">
	var oEditors = [];
	
	var sLang = "ko_KR";	// 언어 (ko_KR/ en_US/ ja_JP/ zh_CN/ zh_TW), default = ko_KR
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "ir1",
		sSkinURI: "/seSkin",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,		// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//bSkipXssFilter : true,		// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			},
			I18N_LOCALE : sLang
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			oEditors.getById["ir1"].exec("PASTE_HTML", ['${board.content}']);
		},
		fCreator: "createSEditor2"		
	});
	
	$(document).ready(function(){
	    $('#imageupload').fileupload({
	    	imageCrop: true,
	        dataType: 'json',
	        done: function (e, data) {
	        	var file = data.result.file;
	        	$("#picture_ul").append(
	       			$("<li>").attr("style", "background-image: url(" + file.url + ");")
	       				.append(
	       						$("<input>").attr("type","button").attr("title","삭제").addClass("bt_del_img")
	       						.attr("onclick", "delButtonClick(this);").val(file.id)
	       				)
	       			);
	
	        },
	        progressall: function (e, data) {
	            var progress = parseInt(data.loaded / data.total * 100, 10);
	            
	            $('#progress_img .progress-bar').css(
	                'width',
	                progress + '%'
	            );
	            if(progress == 100){
	            	$('#progress_img .progress-bar').css('width','0%');
	            }
	        },
	 
	        dropZone: $('#dropzone-img')
	    });
	    $('#fileupload').fileupload({
	    	imageCrop: true,
	        dataType: 'json',
	        done: function (e, data) {
	        	
	        	var file = data.result.file;
	            
	           	$("#file_ul").append(
	           		$("<li>").append(
	           			$("<span>").text(file.name)
	           		).append(
	           			$("<input>").attr("type","button").addClass("bt_del_file").attr("title","삭제")
	           				.attr("onclick", "delFileClick(this);").val(file.id)
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