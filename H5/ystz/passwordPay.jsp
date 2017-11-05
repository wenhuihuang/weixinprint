<%@page import="com.pay.utils.MessageUtil"%>
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
<base href="<%=basePath %>" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0" name="viewport"> 
<meta name="format-detection" content="" telephone="no">
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">  
<script src="H5/ystz/assets/js/jquery.min.js"></script>
<title>密码支付</title>
<style>
	#uploading,#tips{
		position:fixed;
		top:0;
		bottom:0;
		left:0;
		width:100%;
		height:100%;
		background:rgba(0, 0, 0, 0.26);
		display:none;
		margin:auto;
		z-index:9999999999999;
		text-align:center;
	}
	#tips{
		background:rgba(0, 0, 0, 0);
		display:-webkit-box;
		display:none;
		-webkit-box-align:center;
		-webkit-box-pack:center;
	}
	#uploading p{
		text-align: center;
	    color: #fff;
	    background: #383636;
	    width: 120px;
	    height: 60px;
	    line-height:60px;
	    position:fixed;
	    border-radius: 3px;
	    margin:auto;
	    top:0;
	    left:0;
	    bottom:0;
	    right:0;
	}
	#tips span{
		text-align: center;
	    color: #fff;
	    background: #383636;
	    height: auto;
	    line-height:30px;
	    border-radius: 3px;
	    margin:auto;
	    display:block;
	    padding:0 10px;
	}
	body,p{
		padding:0;
		margin:0;
	}
	html,body{
		height:100%;
	}
	.wrap{
		height:100%;
		width:100%;
		/* background:#807876 url(H5/ystz/img/a/passwordPay_bg.png) no-repeat center left;
		background-size: auto 100%; */
		display:-webkit-box;
		-webkit-box-orient: vertical;
	}
	.tips-wrap{
		height:40%;
		display:-webkit-box;
		-webkit-box-align:center;
		-webkit-box-pack:center;
		color:#fff;
		font-weight: bold;
		text-align:center;
		font-size:16px;
		-webkit-box-orient:vertical;
		background:#807876 url(H5/ystz/img/a/passwordTop_bg.png) no-repeat center center;
		background-size: 100% auto;
	}
	.tips-wrap p{
		margin:8px 0;
	}
	.input-wrap{
		/* position:absolute; */
		width:100%;
		height:50px;
		-webkit-box-flex:1.0;
		display:-webkit-box;
		-webkit-box-align:center;
		-webkit-box-pack:start;
		-webkit-box-orient: vertical;
		padding-top:20px;
		background:#807876 url(H5/ystz/img/a/passwordBottom_bg.png) no-repeat center center;
		background-size: 100% auto;
	}
	.input-wrap input{
		padding:8px;
		font-size:14px;
		font-weight:bold;
		border-radius:5px;
		outline:none;
		border:none;
		color:#fff;
		height:20px;
		line-height:20px;
		display:block;
		width:60%;
		text-align:center;
		border:1px solid #9AADD9;
		background:rgba(255, 255, 255, 0);
	}
	a.sub-btn{
		display:block;
		height:36px;
		line-height:36px;
		background:rgba(255, 255, 255, 0);
		border-radius:5px;
		text-decoration: none;
		color:#fff;
		width:40%;
		text-align:center;
		letter-spacing: 20px;
		font-weight: bold;
		border:1px solid #FCD4D5;
		margin-top:50px;
	}
	::-webkit-input-placeholder{
		color: #FFFFFF;
		text-align:center;
		font-size:18px;
		font-weight:bold;
	}
	::-ms-input-placeholder{
		color: #FFFFFF;
	}
	::-moz-placeholder{
		color: #FFFFFF;
	}
</style>
<script type="text/javascript" src="H5/ystz/printphoto.js"></script>
<script type="text/javascript">
	//显示提示
	function showTips(text){
		$('#tips').children('span').text(text);
		$('#tips').css({'display':'-webkit-box'});
		setTimeout(function(){
			$('#tips').hide();	
		}, 3000);
	}
	$(function(){
		
	})
	
	
	var mainUrl =  '<%=MessageUtil.DEFAULT_IP %>'+"wechatprinter/oauth/oauth.do?func=redirect&areaid=${sessionScope.area.areaID}&processid=${sessionScope.processid}";
	
	function printPhotoByPwd(){
		var pwd = $("#pwd").val();
		pwd = pwd==undefined ?"":pwd;
		if(pwd==null||pwd==""){
			showTips("请输入密码！");
			return;
		}
		
		
		$("#uploading").show();
		setTimeout(function(){ printPhoto(pwd,mainUrl); }, 1000);
	}
	
</script>
</head>
<body>
	<div class="wrap">
		<div class="tips-wrap">
			<p>请投币购买密码小票，输入密码</p>
			<p>please buy password，enter the password</p>
		</div>
		<div class="input-wrap">
			<input type="text" name="pwd" id="pwd" placeholder="请输入密码">
			<a href="javascript:;" class="sub-btn" onclick="printPhotoByPwd()">提交</a>
		</div>
	</div>
	<div id="uploading" >
		<p>请稍后</p>
	</div>
	<div id="tips">
		<span>请上传图片</span>
	</div>
</body>
</html>