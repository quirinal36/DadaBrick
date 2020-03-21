<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<meta charset="utf-8">
<meta name="Referrer" content="origin">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=1300">
<meta name="apple-mobile-web-app-title" content="NAVER" />
<meta name="robots" content="index,nofollow"/>
<meta name="description" content="한국효소공학연구회입니다."/>
<meta property="og:title" content="한국효소공학연구회">
<meta property="og:url" content="//www.dadabrick.com/">
<meta property="og:image" content="/resources/img/comm/og.jpg">
<meta property="og:description" content="한국효소공학연구회입니다."/>
<meta name="twitter:card" content="summary">
<meta name="twitter:title" content="한국효소공학연구회">
<meta name="twitter:url" content="//www.dadabrick.com/">
<meta name="twitter:image" content="/resources/img/comm/og.jpg">
<meta name="twitter:description" content="한국효소공학연구회입니다."/>
	
<link rel="shortcut icon" href="<c:url value="/resources/img/comm/favicon.ico"/>">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.bxslider.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/common.js"/>"></script>
<script src="<c:url value="/resources/js/sweetalert2.all.min.js"><c:param name="dt" value="${nowDate }"/></c:url>"></script>
<script src="<c:url value="/resources/js/clientDetective.js"><c:param name="dt" value="${nowDate }"/></c:url>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/jquery.bxslider.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/fonts/NotoSans.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/reset.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/common.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/board.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/admin.css"/>">

<script type="text/javascript">
const toast = swal.mixin({
	toast : true,
	position : 'center',
	showConfirmButton : false,
	timer : 1500
});
</script>