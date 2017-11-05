<%@page import="com.wechatprinter.vo.WCPrinter"%>
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
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>欢迎页</title>
</head>
<body>
	<h1>Hello</h1>
	<center><h5>公众号：${account.weiXinName }</h5></center>
	<center><h5>机台号：${printer.printerName }</h5></center>
	<center><h5>您的金币数AAA：${subscribe.totalPrice }</h5></center>
	<%-- <center><a href="wechatprinter/paycenter/list.do?areaid=${sessionScope.area.areaID }">点击购买密码</a></center> --%>
	
	<c:if test="${areaAccount.recevieID != null and areaAccount.recevieID != '' }">
			<center><a href="wechatprinter/paycenter/list.do">点击购买密码</a></center>
	</c:if>
	<br>
	<center><a href="wechatprinter/imageutil/show.do">点击照片处理</a></center>
	
	
	<%-- 
	<br>
	<div style="width: 100%;height: 100%;margin-left: auto;margin-right: auto;">
		<jsp:include page="picture.jsp"></jsp:include>
	</div> --%>

</body>
</html>