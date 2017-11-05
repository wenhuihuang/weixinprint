<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0" name="viewport"> 
<meta name="format-detection" content="" telephone="no">
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">  
<title>欢迎页</title>
<link rel="stylesheet" href="H5/yushang/index.css" />
</head>
<body>
	<div class="top-number">公众号：<span>${account.weiXinName }</span>&nbsp;机器号码：<span>${printer.printerNo }</span></div>
	<div class="min-wrap">
		<div class="con-wrap">
			<div>
				<p class="number-bg">
				<span>
					<!-- <a href="wechatprinter/paycenter/checkH5History.do">我的账单</a><br>
					<a href="wechatprinter/imageutil/show.do?showtype=pwd">密码打印</a><br> -->
				</span>
				<span>${subscribe.totalPrice }</span>
				</p>	
			</div>
		</div>
	</div>/a>
	
	<div class="bottom-wrap">
	
		 
		
		<a class="printPwd" href="wechatprinter/imageutil/show.do?showtype=pwd"></a>
		<a class="history" href="wechatprinter/paycenter/checkH5History.do"></a>
		<c:choose>
			<c:when test="${areaAccount.recevieID != null and areaAccount.recevieID != '' }">
				<a class="buy" href="wechatprinter/paycenter/list.do"></a>
				
			</c:when>
			<c:otherwise>
				<a class="buy" href="wechatprinter/paycenter/list.do" style="display: none"></a>	
			</c:otherwise>
		</c:choose>
		<a class="printH5" href="wechatprinter/imageutil/show.do?showtype=h5"></a>
		
	</div>
	
	
	<%-- 
	<br>
	<div style="width: 100%;height: 100%;margin-left: auto;margin-right: auto;">
		<jsp:include page="picture.jsp"></jsp:include>
	</div> --%>

</body>
</html>