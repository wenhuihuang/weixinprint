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
<title>机台号</title>
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
		text-align: left;
	    color: #fff;
	    background: #383636;
	    height: auto;
	    line-height:24px;
	    border-radius: 3px;
	    margin:auto;
	    display:block;
	    padding:8px 10px;
	}
	body{
		padding:0;
		margin:0;
	}
	html,body{
		height:100%;
	}
	.logo-wrap{
		text-align:right;
		padding:20px;
		height:120px;
	}
	.logo-wrap img{
		width:80px;
		height:80px;
	}
	.wrap{
		height:100%;
		width:100%;
		/* background:#B2BADE url(H5/ystz/img/a/access.png) no-repeat top center; */
		background:#B2BADE url(H5/ystz/img/a/access.jpg) no-repeat top center; 
		background-size:100% auto;
		display:-webkit-box;
		-webkit-box-orient: vertical;
	}
	.input-wrap{
		position:absolute; 
		width:100%;
		height:50px;
		-webkit-box-flex:1.0;
		display:-webkit-box;
		/*-webkit-box-align:center;*/
		-webkit-box-pack:center;
		/* -webkit-box-orient: vertical; */ 
		min-height:60px;
		margin-top: 7%
		
	}
	.input-wrap input{
		padding:8px;
		font-size:16px;
		font-weight:bold;
		border-radius:7px;
		/* outline:none; */
		border:10px;
		border-color:black;
		color:black;
		height:30px;
		line-height:30px;
		display:block;
		text-align:center;
		/* background:rgba(69, 103, 227, 0.4); */
	}
	.btn-wrap{
		height:80px;
		/* text-align: center;
		 */
	}
	a.confirm-btn{
		display:inline-block;
		height:46px;
		line-height:46px;
		background:#87b3ff;
		border-radius:6px;
		text-decoration: none;
		color:#fff;
		text-align:center;
		letter-spacing: 3px;
		font-weight: bold;
		margin-left: 10px;
		width: 100%;
		
	}
	::-webkit-input-placeholder{
		color: #e9e1e6;
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
	function showTips(text){
		$('#tips').children('span').text(text);
		$('#tips').css({'display':'-webkit-box'});
		setTimeout(function(){
			$('#tips').hide();	
		}, 1000);
	}
	$(function(){
		$('.confirm-btn').click(function(){
			
			var printerno = $("#printerno").val();
			
			if(printerno==null||""==printerno){
				showTips('请先输入机台号！');
				return;
			}
			var processid = '${processid }';
			
			
			$.ajax({
				type:"POST",
				url:"wechatprinter/oauth/oauth.do?func=checkPrinter",
				data:{printerNo:printerno,processid:processid},
				dataType:"json",
				async:true,
				success:function(data){
					if(data.code>0){
						var areaID = data.jsonData.areaID;
						location.href="wechatprinter/oauth/oauth.do?func=redirect&areaid="+areaID+"&processid=${processid}";
					}else{
						showTips(data.msg.replace("<br>","\n"));
					}
				},error: function(XMLHttpRequest, textStatus, errorThrown) {
					showTips('网络繁忙，请重试！');
	       		}
			});
			
			//showTips('机台号不正确，请重新输入！');
		})
	})
</script>
</head>
<body>
	<div class="wrap">
		<div class="logo-wrap" style="display: none">
			<img src="H5/ystz/img/a/logo.png">
		</div>
		<div class="input-wrap">
			<div style="display: inline;width: 50%">
				<input type="text" id="printerno" name="printerno" placeholder="请在此输入机台号">
			</div>
			<div style="display: inline;width:45%;">
				<a href="javascript:;" class="confirm-btn">下一步</a>
			</div>
		</div>
	</div>
	<div id="uploading" >
		<p>请稍后</p>
	</div>
	<div id="tips">
		<span>机台号不正确，请重新输入！</span>
	</div>
</body>
</html>