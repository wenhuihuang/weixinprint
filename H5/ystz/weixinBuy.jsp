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
<title>购买</title>
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
	body,p,ul,li{
		padding:0;
		margin:0;
	}
	ul,li{
		list-style: none;
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
	.list-wrap{
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
		overflow:auto;
	}
	.top-icon span{
		display:inline-block;
		width:50px;
		height:50px;
		background:url(H5/ystz/img/a/weixin_top_icon.png) no-repeat center center;
		background-size:100% 100%;
	}
	.list-wrap ul{
		width:100%;
		text-align:center;
	}
	.list-wrap ul li{
		border-radius: 5px;
	    border: 1px solid #fff;
	    color: #fff;
	    font-weight: bold;
	    padding: 8px;
	    display:inline-block;
	    margin: 8px 2px;
	    width: 81px;
	    height: 110px;
	    text-align: center;
	}
	.list-icon-wrap{
		position:relative;
		height:80px;
		margin:0 auto;
		width:44px;
	}
	.list-wrap ul li .list-icon{
		width:40px;
		height:40px;
		display:inline-block;
		position:absolute;
		background:#fff;
		border:2px solid rgb(126, 119, 118);
	}
	/* .list-wrap ul li:nth-child(1){
		border:1px solid #FFDDDF;
	}
	.list-wrap ul li:nth-child(3){
		border:1px solid #9BAEDB;
	} */
	.list-wrap ul li .list-icon:nth-child(1){
		top:0;
		left:0;
	}
	.list-wrap ul li .list-icon:nth-child(2){
		top:4px;
		left:4px;
	}
	.list-wrap ul li .list-icon:nth-child(3){
		top:8px;
		left:8px;
	}
</style>

<script type="text/javascript">
	//显示提示
	function showTips(text){
		$('#tips').children('span').text(text);
		$('#tips').css({'display':'-webkit-box'});
		setTimeout(function(){
			$('#tips').hide();	
		}, 1500);
	}
	$(function(){
	})
</script>
</head>
<body>
	<div class="wrap">
		<div class="tips-wrap">
			<div class="top-icon">
				<span></span>
			</div>
			<p>请选择您要购买的套餐</p>
			<p>please choose one for print</p>
			<p style="font-size:13px;">打印机会仅限“誉尚”公众号有限</p>
			<p style="font-size:13px;">just can be used for this wechat public account</p>
		</div>
		<div class="list-wrap">
			<ul>
				
				<li onclick="payByPrice('${pricePlan.price }','${pricePlan.qty }')">
					<div class="list-icon-wrap">
						<span class="list-icon"></span>
					</div>
					<div><span style="font-size:14px;">￥${pricePlan.price }元/</span><span style="font-size:12px;">${pricePlan.qty }张</span></div>
				</li>
				
				<c:forEach items="${salesPlans }" var="salesPlan">
					<li onclick="payByPrice('${salesPlan.price }','${salesPlan.qty }')">
						<div class="list-icon-wrap">
							<span class="list-icon"></span>
							<span class="list-icon"></span>
						</div>
						<div><span style="font-size:14px;">￥${salesPlan.price }元/</span><span style="font-size:12px;">${salesPlan.qty }张</span></div>
					</li>
						
				</c:forEach>	

			</ul>
		</div>
	</div>
	<div id="uploading" >
		<p>请稍后</p>
	</div>
	<div id="tips">
		<span>请上传图片</span>
	</div>
	
	<script type="text/javascript">
		function payByPrice(price,amount){
			location.href = "wechatprinter/paycenter/redirect.do?price="+price+"&amount="+amount;
		}
	</script>
	
</body>
</html>