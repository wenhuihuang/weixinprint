<%@page import="java.util.Map"%>
<%@page import="com.wechatprinter.vo.WCWeiXinAccount"%>
<%@page import="java.util.List"%>
<%@page import="com.pay.utils.MessageUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<title>关注公众号</title>
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
	.wrap{
		height:100%;
		width:100%;
		/* background:#B2BADE url(H5/ystz/img/a/access.png) no-repeat top center; */
		/* background:white url(H5/aloneqrcode/img/index.jpg) no-repeat top center; */
		background:white;
		background-size:100% auto;
		display:-webkit-box;
		-webkit-box-orient: vertical;
	}
	.logoImg{
		width: 100%;
		height: auto;
		position: absolute;  
	}
	.logoImg img{
		width: 100%;
		height: auto;
	}
	.fontDiv{
		position: relative;  
		margin: 5%;
	}
	
	.fontDiv span{
		font-size: 16px;
		color: white;
		margin-top: 10px;
		line-height: 30px;
		font-weight: 600;
		letter-spacing:6px;
		
	}
	.freeSpan{
		color: yellow
	}
	
	.fontCenter{
		font-size: 13px;
		margin-left: 11%;
		margin-top: -6%;
		width: 80%;
		background-color: red;
		color: white;
		/* margin-left: 11%;
		font-size: 13px;
		color: white;
		margin-top: -5%;
		position: absolute; */
	}
	.qrcodeDiv{
		width: 100%;
		height: auto;
		background-color: white;
	}
	.qrcodeContent{
		width: 100%;
		height: auto;
	}
	.qrcodeLeft{
		float: left;
		width: 50%;
		height: auto;
	}
	.qrcodeRight{
		float: left;
		width: 50%;
		height: auto;
	}
	.qrcodeTitle {
		font-size: 20px;
		color: black;
		line-height: 30px;
		font-weight: bold;
	}
	.qrcodeFree {
		font-size: 15px;
		color: #64c2ed;
		line-height: 30px;
		font-weight: bold;
	}
	.qrcodeTips {
		font-size: 13px;
		color: black;
		line-height: 30px;
		font-weight: bold;
	}
	.qrcodeRed{
		width: 40px;
	}
	.qrcodeContent hr{width: 99%}
	.bottomDiv{
		width: 100%;
		height: auto;
		bottom: 0;
		position: fixed;
		
	}
</style>
<script type="text/javascript">
	$(function(){
		$(window).scroll(function() {
			  if($(window).scrollTop()==0){
				  $(".bottomDiv").slideDown();
			  }else{
				  $(".bottomDiv").slideUp();
			  }
		});
		changePic();
	})
	
	var changeIndex = 0;
	
	function changePic(){
		if($(".bottomDiv img").length>0){
			
			var millisec = 1000;
			millisec = $($(".bottomDiv img")[changeIndex]).attr("alt");
			
			for(var i = 0;i<$(".bottomDiv img").length;i++){
				$($(".bottomDiv img")[i]).hide();
			}
			console.log($($(".bottomDiv img")[changeIndex]).attr("src"));
			$($(".bottomDiv img")[changeIndex]).show();
			
			if(changeIndex == $(".bottomDiv img").length-1){
				changeIndex = 0;
			}else{
				changeIndex++;
			}
			
			setTimeout("changePic()",millisec);
			
		}
		
	}
	
</script>
</head>
<body>
	<div class="wrap">
		<div class="logoImg" >
			<img alt="" src="H5/aloneqrcode/img/index.jpg">	
			<div class="fontCenter">您当前位于${area.areaName }</div>
			<div class="qrcodeDiv">
				<%	List<WCWeiXinAccount> accounts = (List<WCWeiXinAccount>)request.getAttribute("accounts");
					
					if(accounts!=null&&accounts.size()>0){
						
						for(int i = 0;i<accounts.size();i=i+2){
							
							WCWeiXinAccount account = i<accounts.size()? accounts.get(i):null;
							WCWeiXinAccount account2 = (i+1)<accounts.size()? accounts.get(i+1):null;
							
							Integer freeTimes1 = account==null?0:account.getFreeTimes();
							Integer freeTimes2 = account2==null?0:account.getFreeTimes();
							
							List<Map<String,Object>> aloneQRCodes = (List<Map<String,Object>>)request.getAttribute("aloneQRCodes");
							
							String accountQRCode = "";
							String account2QRCode = "";
							if(aloneQRCodes!=null&&aloneQRCodes.size()>0){

								for(Map<String,Object> maps:aloneQRCodes){
									String WeixinID = maps.get("WeixinID")+"";
									String aloneQRCodePath = "newImage/aloneQRCode/"+maps.get("aloneQRCode");
									
									if(account!=null&&account.getWeiXinId().equals(WeixinID)){
										accountQRCode = aloneQRCodePath;
									}else if(account2!=null&&account2.getWeiXinId().equals(WeixinID)){
										account2QRCode = aloneQRCodePath;
									}
								}
							}
							
							
							%>
							
								
								<div class="qrcodeContent">
									<% 
									if(account!=null){
										%>
											<div class="qrcodeLeft">
												<center>
													<span class="qrcodeTitle"><%=account.getWeiXinName() %></span>
													<br>
													<!-- <img style="width: 40%" alt="" src="H5/aloneqrcode/img/redcode.png">
													<br> -->
													<span class="qrcodeFree">免费打印<%=freeTimes1 %>次</span>
													<br>
													<img style="width: 40%" alt="" src="<%=accountQRCode %>">
													<br>
													<span class="qrcodeTips">长按识别二维码</span>					
												</center>
											</div>
										<%
										}
									%>
									
									<% 
									if(account2!=null){
										%>
											<div class="qrcodeRight">
												<center>
													<span class="qrcodeTitle"><%=account2.getWeiXinName() %></span>
													<br>
													<!-- <img style="width: 40%" alt="" src="H5/aloneqrcode/img/redcode.png">
													<br> -->
													<span class="qrcodeFree">免费打印<%=freeTimes2 %>次</span>
													<br>
													<img style="width: 40%" alt="" src="<%=account2QRCode %>">
													<br>
													<span class="qrcodeTips">长按识别二维码</span>					
												</center>
											</div>
										<%
									}
									%>
									
									<hr>				
								</div>	
							<%
						}
						
					}else{
						%>
						<br>
						<br>
						<center>抱歉，已经没有免费打印的公众号了！</center>
						<%	
					}
				%>
			</div>
			
		</div>
		<div class="fontDiv">
			<center>
				<span>关注以下公众号</span>
				<br>
				<span>您可以</span><span style="color: yellow">免费打印
				<c:choose>
					<c:when test="${totalFreeTimes != null and totalFreeTimes != '' }">${totalFreeTimes }</c:when>
					<c:otherwise>0</c:otherwise>
				</c:choose>
				 
				张</span><span>照片</span>			
			</center>
		</div>
	</div>
	<div style="height: 30%;width: 100%">
	
	</div>
	
	<div class="bottomDiv">
		<c:if test="${h5ADs != null and fn:length(h5ADs)>0 }" >
			<c:forEach items="${h5ADs }" var="h5AD">
				<img style="width: 100%;height: auto;display: none;" alt="${h5AD.StayTime }" src="newImage/AD/wechatlink/${h5AD.ResourcesPath }" onclick="location.href='${h5AD.Url }'">	
			</c:forEach>
		</c:if>		
	</div>
	
	<div id="uploading" >
		<p>请稍后</p>
	</div>
	<div id="tips">
		<span>机台号不正确，请重新输入！</span>
	</div>
</body>
</html>