<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0"
	name="viewport">
<meta name="format-detection" content="" telephone="no">
<META HTTP-EQUIV="pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<script type="text/javascript" src="H5/jquery.min.js"></script>
	<style>
		body{
			padding:0;
			margin: 0;
		}
		html,body,.bg{
			height: 100%;
		}
		input {-webkit-appearance:none;}
		.bg{
			background: url(H5/img/main_bg.jpg) no-repeat center center;
			background-size: 100% 100%;
		}
	 	.bg .form-wrap div{
			position: fixed;
			width: 100%;
			top: 50%;
			left:0;
			right:0;
		} 
		.bg .form-wrap  input{
			display: block;
			margin: 0 auto;
		}
		.bg .form-wrap input[type=text]{
			outline: none;
			border: none;
			padding: 8px 4px;
			color: #fff;
			width: 70%;
			font-weight: bold;
			font-size: 14px;
			background: url(H5/img/no_input2.png) no-repeat center center;
			background-size:100% 100%;
			margin-bottom: 40%;
			height:30px;
			line-height:30px;
			padding:0 8px;
		}
		.bg .form-wrap .submit{
			outline: none;
			border: none;
			/* padding: 8px 4px; */
			color: #fff;
			width: 72%;
			font-weight: bold;
			font-size: 18px;
			background: url(H5/img/access.png) no-repeat center center;
			background-size:100% 100%;
			height:30px;
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
		.tips{
			background: #fff;
		    display: block;
		    width: 90%;
		    margin: 0 auto;
		    text-align: center;
		    padding: 10px 4px;
		    margin-bottom: 5px;
		    border-radius: 3px;
		    color: red;
		}
	</style>
<title>微信打印机 - 入口</title>
<script type="text/javascript">
	function checkPrinter(){
		var printerno = $("#printerno").val();
		
		if(printerno==null||""==printerno){
			$("#tips").text("请先输入机台号！");
			$("#tips").show();
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
					$("#tips").text(data.msg.replace("<br>","\n"));
					$("#tips").show();	
				}
			},error: function(XMLHttpRequest, textStatus, errorThrown) {
				$("#tips").text("网络繁忙，请重试！");
				$("#tips").show();
       		}
		});
		
	}
</script>
</head>
<body>
	
	<div class="bg">
				<div style="padding-top:10px;">
					<span class="tips" id="tips" style="display: none;">输入的机台号有误，请重新输入。</span>
				</div>
			<div class="form-wrap">
			
				
				<div>
					<input type="text" id="printerno" placeholder="请输入机台号" name="printerno"/>
					<input class="submit" type="button" value="确         认" onclick="checkPrinter()"/>
				</div>

			</div>
		</div>
	
</body>
</html>