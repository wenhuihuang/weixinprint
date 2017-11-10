<%@page import="com.wechatprinter.fg.utils.ToolsUtils"%>
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
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<meta name=renderer content=webkit>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<title>全民免费打印中心</title>
<link rel="stylesheet" href="H5/ystz/new/css/reset.css"> 
<link rel="stylesheet" href="H5/ystz/new/css/free.css">
<script src="H5/ystz/assets/js/jquery.min.js"></script>
<script src="H5/ystz/new/js/resetSize.js"></script>
<title>关注公众号</title>
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
 <div class="top-info">
        <div class="top-tips">
            <strong class="label">操作步骤：</strong>
            <span class="text">长按识别公众号,记得输入"66"哦!带飞带放大发发给发给。</span>
        </div>
        <div class="top-content clearfix">
            <div class="left-content">
                <div class="user-info">
                    <div class="head" >
                        <img src="${headimgurl }" alt="">
                    </div>
                    <div class="user-name">${nickname }</div>
                </div>
                <div class="bottom-tips">
                <%	List<WCWeiXinAccount> accounts = (List<WCWeiXinAccount>)request.getAttribute("accounts");
					if(accounts!=null&&accounts.size()>0){
						for(int i = 0;i<accounts.size();i++){
							WCWeiXinAccount account = i<accounts.size()? accounts.get(i):null;
							Integer freeTimes1 = account==null?0:account.getFreeTimes();
							totalFreeTimes+=freeTimes1;
						}
					}
				%>
					
                    	关注以下公众号，可免费打印<%=totalFreeTimes %>次
                </div>
            </div>
            <div class="right-content">
                <div class="right-content-inner">
                    <div class="min-logo"></div>
                    <a href="http://www.happylomo.com/WeixinPrinter/wechatprinter/oauth/oauth.do?func=access&processid=0001000000000000010Z" class="pay-print-btn">付费打印相片</a>
                </div>

            </div>
        </div>
    </div>
    <div class="content-tips">
        <strong>温馨提示：</strong>
        <span>长按识别关注公众号，记得输入"66"哦！</span>
    </div>
    <div class="ad-list-content">
    	<%
		if(accounts!=null&&accounts.size()>0){
			for(int i = 0;i<accounts.size();i++){
				WCWeiXinAccount account = i<accounts.size()? accounts.get(i):null;
				
				List<Map<String,Object>> aloneQRCodes = (List<Map<String,Object>>)request.getAttribute("aloneQRCodes");
				
				String accountQRCode = "";
				String accountLogo = "";
				if(aloneQRCodes!=null&&aloneQRCodes.size()>0){

					for(Map<String,Object> maps:aloneQRCodes){
						String WeixinID = maps.get("WeixinID")+"";
						String aloneQRCodePath = "newImage/aloneQRCode/"+maps.get("aloneQRCode");
						String aloneLogoPath = "newImage/aloneLogo/"+maps.get("aloneLogo");
						
						if(account!=null&&account.getWeiXinId().equals(WeixinID)){
							accountQRCode = aloneQRCodePath;
							accountLogo = aloneLogoPath;
						}
					}
				}
				
				%>
					<div class="list">
			            <div class="left">
			                <div class="app-icon">
			                    <img src="<%=accountLogo %>" alt="">
			                </div>
			            </div>
			            <div class="middle">
			                <p class="name"><%=account.getWeiXinName() %></p>
			                <p class="desc"><%=ToolsUtils.checkIsNull(account.getaD_Home())?"":account.getaD_Home() %></p>
			            </div>
			            <div class="right">
			                <a href="javascript:;" class="fingerprint-btn">
			                    <img src="<%=accountQRCode %>" alt="">
			                </a>
			                <p>长按识别</p>
			            </div>
			        </div>				
				<%
			}
		}
       	%>
    </div>

</body>
</html>