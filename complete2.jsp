<%@page import="com.wechatprinter.vo.WCWeiXinAccount"%>
<%@page import="com.pay.utils.MessageUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	WCWeiXinAccount account = new WCWeiXinAccount();
	account.setWeiXinName("星巴克");
	account.setAloneLogo("http://wx.qlogo.cn/mmopen/JcDicrZBlREhnNXZRudod9PmibRkIs5K2f1tUQ7lFjC63pYHaXGxNDgMzjGDEuvzYZbFOqtUXaxSdoZG6iane5ko9H30krIbzGv/0");
	account.setaD_Print_Title("来呀喂,");
	account.setaD_Print_Content1("星巴克");
	account.setaD_Print_Content2("星巴克2");
	//WCWeiXinAccount account = (WCWeiXinAccount)session.getAttribute("processAccount");
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
<link rel="stylesheet" href="H5/ystz/new/css/reset.css">
<link rel="stylesheet" href="H5/ystz/new/css/wait.css">
<script src="H5/ystz/assets/js/jquery.min.js"></script>
<script src="H5/ystz/new/js/resetSize.js"></script>
<title>打印反馈</title>
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
		$("#msgTitle").html("请稍候...");
		$("#msg").html("正在上传照片...");
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
	  			
	  			if(data.code>0){
	  				$("#msgTitle").html("你的照片已经成功提交了哦");
	  				$("#msg").html("耐心等待片刻  马上就好");
	  				$("#retry").html("点 击 继 续 打 印");
	  				$("#retry").click(function(){location.href=mainUrl});
	  				setTimeout(function(){location.href=mainUrl}, 1000);
	  			}else{
	  				
	  				$("#msgTitle").html("你的照片提交时出错了");
	  				$("#msg").html(data.msg);
	  				$("#retry").html("重试");
	  				$("#retry").click(function(){retry()});
	  			}
	  		},error: function(XMLHttpRequest, textStatus, errorThrown) {
	  			$("#uploading").hide();
	  			//showTips('请求网络出错，请重试，错误码：'+textStatus+'！')
	  			$("#msgTitle").html("你的照片提交时出错了");
	  			$("#msg").html('请求网络出错，请重试，错误码：'+textStatus+'！');
	  			
	  			$("#retry").show();
	  			$("#retry").html("返回");
	  			$("#retry").click(function(){location.href=mainUrl});
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
    <div class="ad-list">
        <div class="top-wrap">
            <div class="top">
                <img src="<%=account==null?"":account.getAloneLogo() %>" alt="">
                <p><%=account==null?"":account.getWeiXinName() %></p>
            </div>
            <div class="bottom">
                <p class="h"><%=account==null?"":account.getaD_Print_Title() %></p>
                <p class="h1"><%=account==null?"":account.getaD_Print_Content1() %></p>
                <p class="h2"><%=account==null?"":account.getaD_Print_Content2() %></p>
            </div>
        </div>
    </div>
    
    <div class="print-wrapper">
        <div class="tips-text" style="width: 80%;">
            <p class="b"><strong id="msgTitle">请稍候...</strong></p>
            <p class="s" id="msg"></p>
        </div>
        <div class="arrows"></div>
        <div>
            <a href="javascript:;" class="print-btn" id="retry"></a>
        </div>
    </div>
    <div class="line"></div>
    <div class="issue">
        <a href="javascript:;" onclick="findstaff()">打印有问题？点击这里反馈吧！</a>
    </div>
    <div id="uploading" >
		<p>请稍后...</p>
	</div>
</body>
<script type="text/javascript">
	function findstaff(){
		alert("请联络工作人员进行处理。");
	}
	  $(function(){
          var top_wrap = $('.top-wrap');
          var scale = 414/330;
          var height = top_wrap.width()/scale;
          var top_bottom = 182/305;
          top_wrap.css({"height":height});
      })
</script>
</html>