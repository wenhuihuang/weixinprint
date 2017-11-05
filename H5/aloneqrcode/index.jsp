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
	int totalFreeTimes = 0;
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
<link rel="stylesheet" href="H5/aloneqrcode/progress/css/style.css">
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
		color: black;
		margin-top: 10px;
		line-height: 30px;
		font-weight: bold;
		/* letter-spacing:1px; */
		
	}
	.freeSpan{
		color: red;
	}
	
	.qrcodeDiv{
		width: 100%;
		height: auto;
		background-color: white;
	}
	.qrcodeContent{
		width: 100%;
		height: auto;
		margin-top: 2%;
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
	
	.qrcodeFree {
		font-size: 13px;
		color: #06bd9d;
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
	
	*{
	moz-user-select: -moz-none;
	-moz-user-select: none;
	-o-user-select:none;
	-khtml-user-select:none;
	-webkit-user-select:none;
	-ms-user-select:none;
	user-select:none;
	}
 	
</style>
<script type="text/javascript">
	$(function(){
		
		try{
			$(window).scroll(function() {
				  if($(window).scrollTop()==0){
					  $(".bottomDiv").slideDown();
				  }else{
					  $(".bottomDiv").slideUp();
				  }
			});
			
			
			changePic();
			setTouchEvent();
			setTouchEventByLogo();

		}catch(err){
			alert("抱歉未能正确加载网页，如不能识别二维码，请尝试重新进入网页！"+err.message);	
		}
		
		
	})
	
	function setTouchEvent(){
		var objs = document.getElementsByName('distinguish');
		if(objs!=null){
			for(var i = 0;i<objs.length;i++){
				var obj = objs[i];
				
				//和下面的方法一样，有些手机不能
				/*obj.addEventListener('click', function(event) {
					var childQRCode = document.getElementById("qrCode"+this.id);
					childQRCode.style.display='block';
					var progress1 = document.getElementById("progress"+this.id);
					progress1.style.width = "0%";
					isProgress = true;
					setTimeout("goProgress('"+this.id+"')",0);
					setTimeout("hideQRCode('"+this.id+"')",2100);
				});*/
				
				obj.addEventListener('touchstart', function(event) {
					var childQRCode = document.getElementById("qrCode"+this.id);
					childQRCode.style.display='block';
					var progress1 = document.getElementById("progress"+this.id);
					progress1.style.width = "0%";
					isProgress = true;
					setTimeout("goProgress('"+this.id+"')",0);
					setTimeout("hideQRCode('"+this.id+"')",2100);
				}, false);
				
				obj.addEventListener('touchend', function(event) {
					event.preventDefault();
					var childQRCode = document.getElementById("qrCode"+this.id);
					childQRCode.style.display='none';
					var progress1 = document.getElementById("progress"+this.id);
					progress1.style.width="0%";
					isProgress = false;
				}, false);
				
			}
		}
	}
	
	
	function setTouchEventByLogo(){
		var objs = document.getElementsByName('logos');
		if(objs!=null){
			for(var i = 0;i<objs.length;i++){
				var obj = objs[i];
				//和下面是一样,因为有部分手机不能触发下面事件
				/*obj.addEventListener('click', function(event) {
					var tempID = this.id.replace("logo","");
					
					var childQRCode = document.getElementById("qrCode"+tempID);
					childQRCode.style.display='block';
					var progress1 = document.getElementById("progress"+tempID);
					progress1.style.width = "0%";
					isProgress = true;
					setTimeout("goProgress('"+tempID+"')",0);
					setTimeout("hideQRCode('"+tempID+"')",2100);
				});*/
				
				
				obj.addEventListener('touchstart', function(event) {
					var tempID = this.id.replace("logo","");
					
					var childQRCode = document.getElementById("qrCode"+tempID);
					childQRCode.style.display='block';
					var progress1 = document.getElementById("progress"+tempID);
					progress1.style.width = "0%";
					isProgress = true;
					setTimeout("goProgress('"+tempID+"')",0);
					setTimeout("hideQRCode('"+tempID+"')",2100);
				}, false);
				
				obj.addEventListener('touchend', function(event) {
					var tempID = this.id.replace("logo","");
					
					event.preventDefault();
					var childQRCode = document.getElementById("qrCode"+tempID);
					childQRCode.style.display='none';
					var progress1 = document.getElementById("progress"+tempID);
					progress1.style.width="0%";
					isProgress = false;
				}, false);
				
			}
		}
	}
	
	
	
	var isProgress = false;
	function goProgress(id){
		var progress1 = document.getElementById("progress"+id);
		var pg = progress1.style.width;
		if(isProgress==true){
			pg = pg.replace("%","");
			if((parseInt(pg)+10)==100){
				isProgress = false;
			}
			progress1.style.width = (parseInt(pg)+10)+"%";
			
			if(isProgress==true){
				setTimeout("goProgress('"+id+"')",70);				
			}
		}
	}
	
	function hideQRCode(qrCodeID){
		var childQRCode = document.getElementById("qrCode"+qrCodeID);
		childQRCode.style.display='none';
		
		isProgress = false;
		var progress1 = document.getElementById("progress"+qrCodeID);
		progress1.style.width="0%";
	}
	
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
			<div class="qrcodeDiv">
			<%	List<WCWeiXinAccount> accounts = (List<WCWeiXinAccount>)request.getAttribute("accounts");
				if(accounts!=null&&accounts.size()>0){
					for(int i = 0;i<accounts.size();i=i+2){
						
						WCWeiXinAccount account = i<accounts.size()? accounts.get(i):null;
						WCWeiXinAccount account2 = (i+1)<accounts.size()? accounts.get(i+1):null;
						
						Integer freeTimes1 = account==null?0:account.getFreeTimes();
						Integer freeTimes2 = account2==null?0:account2.getFreeTimes();
						
						List<Map<String,Object>> aloneQRCodes = (List<Map<String,Object>>)request.getAttribute("aloneQRCodes");
						
						String accountQRCode = "";
						String account2QRCode = "";
						String accountLogo = "";
						String account2Logo = "";
						if(aloneQRCodes!=null&&aloneQRCodes.size()>0){

							for(Map<String,Object> maps:aloneQRCodes){
								String WeixinID = maps.get("WeixinID")+"";
								String aloneQRCodePath = "newImage/aloneQRCode/"+maps.get("aloneQRCode");
								String aloneLogoPath = "newImage/aloneLogo/"+maps.get("aloneLogo");
								
								if(account!=null&&account.getWeiXinId().equals(WeixinID)){
									accountQRCode = aloneQRCodePath;
									accountLogo = aloneLogoPath;
								}else if(account2!=null&&account2.getWeiXinId().equals(WeixinID)){
									account2QRCode = aloneQRCodePath;
									account2Logo = aloneLogoPath;
								}
							}
						}
						
						%>
							<div class="qrcodeContent">
								<% if(account!=null){ 
									totalFreeTimes += freeTimes1;
								%>
								<div class="qrcodeLeft">
									<center>
										<div id="qrCode<%=account.getWeiXinAccountId() %>" style="position: absolute;display:none; width: 50%">
											<div class="progress" style="width: 75%"><span id="progress<%=account.getWeiXinAccountId() %>" class="orange" style="width: 0%;"><!-- <span>30%</span> --></span></div>
											<img style="width: 80%;" alt="" src="<%=accountQRCode %>">
										</div>
										
										<img id="logo<%=account.getWeiXinAccountId() %>" style="width: 50%" alt="" src="<%=accountLogo %>" name="logos">
										<br>
										<span class="qrcodeFree">免费<%=freeTimes1 %>次</span>
										<br>
										<img id="<%=account.getWeiXinAccountId() %>" style="width: 73%" alt="" src="H5/aloneqrcode/img/click.png" name="distinguish">
									</center>
								</div>
								<%}%>
								
								<% if(account2!=null){
									totalFreeTimes += freeTimes2;
								%>
								<div class="qrcodeRight" >
									<center>
										<div id="qrCode<%=account2.getWeiXinAccountId() %>" style="position: absolute;display:none; width: 50%">
											<div class="progress" style="width: 75%"><span id="progress<%=account2.getWeiXinAccountId() %>" class="orange" style="width: 0%;"><!-- <span>30%</span> --></span></div>
											<img style="width: 80%;" alt="" src="<%=account2QRCode %>">
										</div>
										
										<img id="logo<%=account2.getWeiXinAccountId() %>"  style="width: 50%" alt="" src="<%=account2Logo %>" name="logos" >
										<br>
										<span class="qrcodeFree">免费<%=freeTimes2 %>次</span>
										<br>
										<img id="<%=account2.getWeiXinAccountId() %>" style="width: 73%" alt="" src="H5/aloneqrcode/img/click.png"  name="distinguish" >					
									</center>
								</div>
								<%}%>
								<hr>
							</div>
						<%
					}
				}else{
					%>
					<br>
					<br>
					<br>
					<center>抱歉，已经没有免费打印的公众号了！</center>
					
					<%-- <div class="qrcodeContent">
								<div class="qrcodeLeft"  >
									<center>
										<div id="qrCode1" style="position: absolute;display:none;width: 50%">
											<div class="progress" style="width: 75%"><span id="progress1" class="orange" style="width: 0%;"><!-- <span>30%</span> --></span></div>
											<img style="width: 80%;" alt="" src="H5/aloneqrcode/img/qrcode.jpg">
										</div>
										<img style="width: 50%" alt="" src="H5/aloneqrcode/img/logo.jpg">
										<br>
										<span  class="qrcodeFree">免费1次</span>
										<br>
										<img name="distinguish" id="1" style="width: 73%" alt="" src="H5/aloneqrcode/img/click.png" >
									</center>
								</div>
								<div class="qrcodeRight" >
									<center>
										<div id="qrCode2" style="position: absolute;display:none; width: 50%">
											<div class="progress" style="width: 75%"><span id="progress2" class="orange" style="width: 0%;"><!-- <span>30%</span> --></span></div>
											<img style="width: 80%;" alt="" src="H5/aloneqrcode/img/qrcode.jpg">
										</div>
										<img style="width: 50%" alt="" src="H5/aloneqrcode/img/logo.jpg">
										<br>
										<span class="qrcodeFree">免费1次</span>
										<br>
										<img name="distinguish" id="2" style="width: 73%" alt="" src="H5/aloneqrcode/img/click.png" >					
									</center>
								</div>
					</div> --%>
					
					<%	
				}
			%>
				
			</div>
		</div>
		<div class="fontDiv">
			<center>
				<span style='font-weight: 1000;font-size: 18px;font-family: "Microsoft YaHei" ! important;'><b>关注以下公众号</b></span>
				<br>
				<span>您可以</span><span style="color: red">免费打印
				<% if(totalFreeTimes>0){
					%>
					<%=totalFreeTimes %>
					<%
				}else{
					%>0<%
				}%>
				张</span>
				<span>照片</span>			
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
	
	<div style="margin: 5px; ">
		<center>
		<hr style="width:98%;color: gray; ">
			谢谢您的关注与支持!<br>如果无法识别二维码，可以关注对应公众号进行免费打印！<br>
			或<a href="http://www.happylomo.com/WeixinPrinter/wechatprinter/oauth/oauth.do?func=access&processid=0001000000000000010Z">点击此处</a>进行收费打印！
		</center>
		<br>
	</div>
	
	<div id="uploading" >
		<p>请稍后</p>
	</div>
	<div id="tips">
		<span>机台号不正确，请重新输入！</span>
	</div>
</body>
</html>