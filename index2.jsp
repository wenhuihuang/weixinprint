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
<link rel="stylesheet" href="H5/ystz/new/css/reset.css"> 
<link rel="stylesheet" href="H5/ystz/new/css/free.css?v=20171203">
<script src="H5/ystz/assets/js/jquery.min.js"></script>
<script src="H5/ystz/new/js/resetSize.js"></script>
<link rel="stylesheet" href="H5/aloneqrcode/progress/css/style.css">
<style type="text/css">
.bottomDiv{
		width: 100%;
		height: auto;
		bottom: 0;
		position: fixed;
		
	}
</style>
<title>关注公众号</title>
</head>
<body>
 <div class="top-info">
        <!-- <img class="bg" src="H5/ystz/new/images//free_top_bg.png"> -->
        <div class="top-tips">
            <strong class="label">操作步骤：</strong>
            <span class="text">长按识别公众号,记得输入"66"哦!带飞带放大发发给发给。</span>
        </div>
        <div class="top-content clearfix">
            <div class="left-content">
                <div class="user-info">
                    <div class="head" >
                    	<!-- style="margin-left: -2px;margin-top: -2px;border-radius: 40px;width: 70px;" -->
                        <img  src="${headimgurl }" alt="">
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
    <div class="ad-list-content" style="margin-bottom: 50px">
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
							<div id="qrCode<%=account.getWeiXinAccountId() %>" class="progress-bar-wrap">
								<div class="progress" style="width: 75%"><span id="progress<%=account.getWeiXinAccountId() %>" class="orange" style="width: 0%;"><!-- <span>30%</span> --></span></div>
								<img alt="" src="<%=accountQRCode %>">
							</div>
							<img src="H5/ystz/new/images/fingerprint_icon.png" id='<%=account.getWeiXinAccountId() %>' class="fingerprint-btn" name="distinguish" />
							<p>长按识别</p>
			            </div>
			        </div>				
				<%
			}
		}
       	%>
    </div>

	<div class="bottomDiv">
		<c:if test="${h5ADs != null and fn:length(h5ADs)>0 }" >
			<c:forEach items="${h5ADs }" var="h5AD">
				<img style="width: 100%;height: auto;display: none;" alt="${h5AD.StayTime }" src="newImage/AD/wechatlink/${h5AD.ResourcesPath }" onclick="location.href='${h5AD.Url }'">
			</c:forEach>
		</c:if>		
	</div>
	<script src="H5/ystz/new/js/QRCode.js"></script>
</body>
</html>