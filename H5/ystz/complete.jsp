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
<title></title>
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
	    height: 60px;
	    line-height:60px;
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
		height:50%;
		display:-webkit-box;
		-webkit-box-align:center;
		-webkit-box-pack:center;
		color:#fff;
		font-weight: bold;
		text-align:center;
		font-size:16px;
		-webkit-box-orient:vertical;
		background:#807876 url(H5/ystz/img/a/passwordTop_bg.png) no-repeat top center;
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
<script type="text/javascript">
	//显示提示
	function showTips(){
		$('#uploading').show();
		$("#msg").html("提示");
		$("#retry").html("返回");
	}
	var mainUrl =  '<%=MessageUtil.DEFAULT_IP%>'+"wechatprinter/oauth/oauth.do?func=redirect&areaid=${sessionScope.area.areaID}&processid=${sessionScope.processid}";
	
	
	  function printPhoto(){
	  	$.ajax({
	  		type:"POST",
	  		url:"wechatprinter/imageutil/printPhoto2.do",
	  		dataType:"json",
	  		async:false,
	  		success:function(data){
	  			$("#uploading").hide();
	  			$("#retry").show();
	  			$("#msg").html(data.msg);
	  			if(data.code>0){
	  				$("#retry").html("返回");
	  				$("#retryDiv").click(function(){location.href=mainUrl});
	  				setTimeout(function(){location.href=mainUrl}, 1000);
	  			}else{
	  				$("#retry").html("重试");
	  				$("#retryDiv").click(function(){retry()});
	  			}
	  		},error: function(XMLHttpRequest, textStatus, errorThrown) {
	  			$("#uploading").hide();
	  			showTips('请求网络出错，请重试，错误码：'+textStatus+'！')
	  			$("#msg").html('请求网络出错，请重试，错误码：'+textStatus+'！');
	  			
	  			$("#retry").show();
	  			$("#retry").html("返回");
	  			$("#retryDiv").click(function(){location.href=mainUrl});
	  		}, complete: function(XMLHttpRequest, textStatus) {
	  			$("#uploading").hide();
	  		}
	  	})
	  	
	  }
	
	
	$(function(){
		if('${sessionScope.accesstype}'=="aloneqrcode"){
			mainUrl =  '<%=MessageUtil.DEFAULT_IP%>'+"wechatprinter/oauth/oauth.do?func=redirectAlone&areaid=${sessionScope.area.areaID}";
		}
		
		retry();
	})
	
	
	function retry(){
		showTips();
		setTimeout(function(){
			//$('#uploading').hide();
			printPhoto();
		}, 1000);
	}
</script>
</head>
<body>
	<div class="wrap">
		<div class="tips-wrap"  >
			<p style="padding:0 8px;" id="msg">提示</p>
		</div>
		<div class="input-wrap" style="font-size:16px;font-weight: bold;color:#fff;" id="retryDiv" >
			<a href="javascript:;" class="sub-btn" id="retry" style="display: none" >返回</a>
		</div>
	</div>
	<div id="uploading" >
		<p>请稍后...</p>
	</div>
	<div id="tips">
		<span></span>
	</div>
</body>
</html>