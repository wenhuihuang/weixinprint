<%@page import="com.wechatprinter.fg.utils.ServletUtils"%>
<%@page import="com.wechatprinter.vo.WCPhoto"%>
<%@page import="com.wechatprinter.fg.utils.ToolsUtils"%>
<%@page import="java.io.File"%>
<%@page import="com.pay.utils.MessageUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	
	WCPhoto photo = (WCPhoto)request.getAttribute("photo");
	System.out.println("photo == "+photo);
	//
	if(photo!=null&&!ToolsUtils.checkIsNull(photo.getPhotoFileName())){
		String filePath = new ServletUtils().getLocalPath()+"oriImage/"+photo.getPhotoFileName();
		//System.out.println(filePath);
		File file = new File(filePath);
		if(!file.exists()){
			photo.setPhotoFileName("");
			request.setAttribute("photo", photo);
		}
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath %>" />
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0" name="viewport">
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" /> 
<script type="text/javascript" src="H5/ystz/compressImg/lrz.bundle.js"></script>
<title>裁剪图片</title>
<script type="text/javascript">
	
	var aspectRatio = parseFloat('${printer.cutWidth }') /parseFloat('${printer.cutHeight }');
</script>

<link rel="stylesheet" href="H5/ystz/assets/css/font-awesome.min.css">
  <link rel="stylesheet" href="H5/ystz/assets/css/bootstrap.min.css">
  <link rel="stylesheet" href="H5/ystz/dist/cropper.css">
  <link rel="stylesheet" href="H5/ystz/tools/css/main.css">
  <!-- <link rel="stylesheet" href="OAuth/wechatpay/css/phone.css" /> -->
  <link rel="stylesheet" href="H5/ystz/index.css?v=2017924" />
  <style>
  	.payment-methods-wrap{
  		position:fixed;
  		z-index:10000;
  		width:100%;
  		top:0;
  		bottom:0;
  		left:0;
  		right:0;
  		background: rgba(66, 66, 66, 0.32);
  		display:-webkit-box;
  		-webkit-box-align:center;
  	}
  	.payment-methods-con{
  		width:80%;
  		margin:0 auto;
  		background:#fff;
  		border-radius:6px;
  		padding-bottom:16px;
  		padding-top:8px;
  	}
  	.close-btn{
  		display:block;
  		width:26px;
  		height:26px;
  		background:url(H5/ystz/img/a/close_icon.png) no-repeat center center;
  		background-size:100% 100%;
  		margin: 0 auto;
  	}
  	.title-top{
  		display:-webkit-box;
  		-webkit-box-align:center;
  		height:43px;
  	}
  	.title-text{
  		-webkit-box-flex:1.0;
  		text-align:center;
  		font-size:16px;
  		font-weight:blod;
  	}
  	.close-wrap{
  		width:48px;
  		-webkit-box-align:center;
  		-webkit-box-pack:center;
  	}
  	.methods-list p{
  		width:80%;
  		margin:8px auto;
  		text-align:center;
  		padding:15px 0;
  		color:#fff;
  		border-radius:4px;
  		font-size:14px;
  		font-weight: bold;
  	}
  	.methods-list p:nth-child(1){
  		background:#FCD4D5;
  	}
  	.methods-list p:nth-child(2){
  		background:#9AACDA;
  	}
  	.docs-tooltip{
  		display:inline-block;
  		padding:0;
  	}
  	.two-btn-wrap button{
  		width: 42px;
    	height: 36px;
  	}
  </style>
</head>
<body>
  <!-- Content -->
  <div class="container">
  <div class="min-con">
  	<div class="min-top">
  		<div class="tips">
  			<p class="tips-btn"><i></i><span class="tips-text">x${printTimes }</span></p>
  		</div>
  		<div class="logo">
  			<img src="H5/ystz/img/a/logo.png">
  		</div>
  	</div>
  	 <div class="img-wrap">
  	 	<div class="white-bg">
  	 		<div class="img-bg">
		        <!-- <h3 class="page-header">Demo:</h3> -->
		        <div class="img-container">
		        	<!-- H5/demo//assets/img/picture.jpg -->
		        	<!-- H5/demo/index.jpg -->
		          <c:choose>
		          	<c:when test="${photo != null and photo.photoFileName != null and photo.photoFileName != ''  }"><img id="image" src="oriImage/${photo.photoFileName }" alt="Picture" ></c:when>
		          	<c:otherwise><img id="image" src="H5/ystz/img/a/default_img.png" alt="Picture" ></c:otherwise>
		          </c:choose>
		          
		          <div class="frame-bg"></div>
		        </div>
	      	</div>
	      	<div class="upImage"></div> 
	      	<span class="del-btn"></span>
  	 	</div>
      <!-- 左边功能按钮 -->
        <div class="docs-buttons two-btn-wrap">
     	<p>
    		  <button type="button" class="right-btn" data-method="rotate" data-option="90" title="Rotate Right" >
            <span class="docs-tooltip" data-toggle="tooltip">
             <!--  <span class="fa fa-rotate-right"></span> -->
             <!-- 右转 -->
            	 旋转
            </span>
          </button>
    	</p>
         <p>
          <button type="button" class="refresh" data-method="reset" title="Reset" >
            <span class="docs-tooltip" data-toggle="tooltip">
              <!-- <span class="fa fa-refresh">刷新</span> -->
            <!--   刷新 -->
            	重置
            </span>
          </button>
          </p>
      <p>
          <button type="button" class="preview" data-method="getCroppedCanvas"  data-option="{ &quot;width&quot;: ${printer.cutWidth }, &quot;height&quot;: ${printer.cutHeight } }">
            <span class="docs-tooltip" data-toggle="tooltip">
              	预览
            </span>
          </button>
          </p>
   
    	 	<!-- <p>
     		   	<button type="button" class="left-btn" data-method="rotate" data-option="-90" title="Rotate Left">
            	<span class="docs-tooltip" data-toggle="tooltip">
	              <span class="fa fa-rotate-left"></span>
	              左转
	            </span>
	          </button>
     	</p> -->
       </div>
       
    </div>
    
    
    <div class="" id="photoTextRow" style="display: block;">
    	<div class=""> 
    		<center>
    			<textarea rows="1" cols="" placeholder="这里输入心情文字" id="phototext" name="phototext" ></textarea>
    		</center>
    	</div>
    </div>
       
  </div>
    
    <!-- 底部 -->
    <div class="footer-wrap row">
    	<div class="frame-wrap">
    		<div class="frame-text">
				<span class="template-btn" style="display: none">模板</span>
    			<span class="frame-btn">相框</span>
    		</div>
    		<div class="frame-content">
    			<ul style="margin-right:10px;" class="clearfix">
    				
    				<li id="frame-default" class="frame-item"><img img-src="H5/ystz/frame/7.png" src="H5/ystz/frame/min/7.png"></li>
    				<li class="frame-item"><img img-src="H5/ystz/frame/1.png" src="H5/ystz/frame/min/1.png"></li>
    				<li class="frame-item"><img img-src="H5/ystz/frame/2.png" src="H5/ystz/frame/min/2.png"></li>
	    			<li class="frame-item"><img img-src="H5/ystz/frame/3.png" src="H5/ystz/frame/min/3.png"></li>
	    			<li class="frame-item"><img img-src="H5/ystz/frame/4.png" src="H5/ystz/frame/min/4.png"></li>
	    			<li class="frame-item"><img img-src="H5/ystz/frame/5.png" src="H5/ystz/frame/min/5.png"></li>
	    			<li class="frame-item"><img img-src="H5/ystz/frame/6.png" src="H5/ystz/frame/min/6.png"></li>
	    			<li class="frame-item"><img></li>
                    <li class="frame-item"><img img-src="H5/ystz/frame/8.png" src="H5/ystz/frame/min/8.png"></li>
                    <li class="frame-item"><img img-src="H5/ystz/frame/9.png" src="H5/ystz/frame/min/9.png"></li>
                    <li class="frame-item"><img img-src="H5/ystz/frame/10.png" src="H5/ystz/frame/min/10.png"></li>
                    <li class="frame-item"><img img-src="H5/ystz/frame/11.png" src="H5/ystz/frame/min/11.png"></li>
                    <li class="frame-item"><img img-src="H5/ystz/frame/12.png" src="H5/ystz/frame/min/12.png"></li>
    			</ul>
    		</div>
    	</div>
    	<div class="btn-group-crop docs-buttons" style="position:relative;">
      		<input type="hidden" id="isSelect">
     
          <div style="position:absolute;width:100%;height:100%;top:0;left:0;right:0;bottom:0;background:#c2beea;z-index:10;">
         <input style="display:block;" type="button" class="print button" data-method="uploadCroppedCanvas"  data-option="{ &quot;width&quot;: ${printer.cutWidth }, &quot;height&quot;: ${printer.cutHeight } }" value="下一步" />
            <!-- <span class="docs-tooltip" data-toggle="tooltip"> -->
            <!-- </span> -->
          <!-- </button>   -->
          
          </div>
          <p class="up-file-wrap">
          	<input type="file" class="sr-only" id="inputImage" name="file" accept="image/*" onchange="selectedPic()">
          <!--  <button class="uploading" id="inputImageBtn" title="Upload image file" >
            <span class="docs-tooltip" data-toggle="tooltip">
              <span class="fa fa-upload"></span>
              上传
            </span>
          </button> -->
          </p>
        </div>
    </div>
    
    <!-- 打印和上传图片 -->
     <div class="aaa row">
      <div class="" style="text-align:center;">
        <!-- <h3 class="page-header">Toolbar:</h3> -->


       <!--  <div class="btn-group"> -->
      
          

       <!--  </div> -->




        <!-- Show the cropped image in modal -->
        <div class="modal fade docs-cropped" id="getCroppedCanvasModal" aria-hidden="true" aria-labelledby="getCroppedCanvasTitle" role="dialog" tabindex="-1">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="getCroppedCanvasTitle">图片预览</h4>
              </div>
              <div class="modal-body"></div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <a class="btn btn-primary" id="download" href="javascript:void(0);" download="cropped.png" style="display: none">下载</a>
              </div>
            </div>
          </div>
        </div><!-- /.modal -->


      </div><!-- /.docs-buttons -->
		
    </div>
    
  
  </div>
	<div class="payment-methods-wrap" style="display:none;" >
		<div class="payment-methods-con">
			<div class="title-top">
				<div class="title-text">选择支付方式</div>
				<div class="close-wrap"><i class="close-btn" onclick="hidePayment()"></i></div>
			</div>
			<div class="methods-list">
				<p onclick="location.href='wechatprinter/imageutil/showWeixinPay.do'">微信支付</p>
				<p onclick="location.href='H5/${sessionScope.area.templateCoinUrl}'">密码支付</p>
			</div>
		</div>
	</div>
	<div id="uploading" >
		<p>请稍后</p>
	</div>
	<div id="tips">
		<span>请上传图片</span>
	</div>
 
	<canvas id="canvas1"></canvas>
  <!-- Scripts -->
  <script src="H5/ystz/assets/js/jquery.min.js"></script>
  <script src="H5/ystz/assets/js/bootstrap.min.js"></script>
  <script src="H5/ystz/dist/cropper.min.js"></script>
  <!-- <script src="H5/yushang/tools/js/main.js"></script> -->
  <script id="main_js" src="H5/ystz/main.js"></script>
</body>
<script type="text/javascript">
	//显示提示
	function showTips(text){
		$('#tips').children('span').text(text);
		$('#tips').css({'display':'-webkit-box'});
		setTimeout(function(){
			$('#tips').hide();	
		}, 2000);
	}

	var cutWidth = parseFloat('${printer.cutWidth }');
	var cutHeight = parseFloat('${printer.cutHeight }');
	var uploadUrl = '<%=basePath %>wechatprinter/imageutil/uploadNewImage2.do';
	var checkIsPrintPhotoUrl = '<%=basePath %>wechatprinter/imageutil/checkIsPrintPhoto2.do';
	var mainUrl =  '<%=MessageUtil.DEFAULT_IP %>'+"wechatprinter/oauth/oauth.do?func=redirect&areaid=${sessionScope.area.areaID}&processid=${sessionScope.processid}";
	
	$(function(){
		
		
		//var existPhoto = '${existPhoto}';
		var existPhoto = $("#image").attr("src");
		if(existPhoto!="H5/ystz/img/a/default_img.png"){
			//不等于默认图，则表示有上传图片
			$('.upImage').hide();
			$('.del-btn').show();
			$("#isSelect").val("1");
		}
		
		
		//====================
		
		//=======================
		
		
		
		
		$('.two-btn-wrap').css({"left":$('.white-bg').offset().left + $('.white-bg').width() + 16})
		var frames = ['1.png','2.png','3.png','4.png','5.png','6.png','7.png'];
		resetFrameWidth();
		/*切换成模板*/
		$('.template-btn').click(function(){
			var html = '<li class="mood-text"><span>心情文字</span></li>'
			$('.frame-content ul').html(html);
			resetFrameWidth();
		})
		//$('.template-btn').click();
		/*切换成相框*/
		$('.frame-btn').click(function(){
			$('#photoTextRow').hide();
			var html = "<li  class='frame-item'><img></li>";
			for(var i = 0; i < frames.length; i++ ){
				html+="<li  class='frame-item'><img img-src='H5/ystz/frame/"+frames[i]+"' src='H5/ystz/frame/min/"+frames[i]+"' ></li>"
			}
			$('.frame-content ul').html(html);
			resetFrameWidth();
		})
		$('.frame-content').delegate('.frame-item','click',function(e){
		    var src = $(this).children('img').attr('img-src');
		    if(src == undefined || src == '' || src == null){
		    	$('.frame-bg').attr('url',"");
			    $('.frame-bg').css({'background':""})
		    }else{
		    	$('.frame-bg').attr('url',src);
			    $('.frame-bg').css({'background':'url('+src+') no-repeat center center','background-size':'100% 100%'})
		    }
		    
		})
		
		$('.frame-content').delegate('#frame-default','click',function(e){
		    var src = $(this).children('img').attr('img-src');
		    if(src == undefined || src == '' || src == null){
		    	$('.frame-bg').attr('url',"");
			    $('.frame-bg').css({'background':""})
		    }else{
		    	$('.frame-bg').attr('url',src);
			    $('.frame-bg').css({'background':'url('+src+') no-repeat center center','background-size':'100% 100%'})
		    }
		    
		})
		
		/*显示心情文字*/
		$('body').delegate('.mood-text','click',function(){
			$('#photoTextRow').show();
			$("#phototext").focus();
		})
		/*点击上传图片*/
		$('.upImage').click(function(){
			$("#inputImage").click();
		})
		/*删除图片*/
		$('.del-btn').click(function(){
			
			
			$('#image').attr('src','H5/ystz/img/a/default_img.png');
			$("#isSelect").val("");
			$('.upImage').show();
			$('.del-btn').hide();
			$('.cropper-bg').find('img').attr('src',"H5/ystz/img/a/default_img.png").addClass('img-default');
			$('.refresh').click();
			$('.frame-bg').attr('url',"");
		    $('.frame-bg').css({'background':""})
		})
		/*提示剩下多少*/
		var count=$('.tips-text').text().replace(/[^0-9]/g,"");
		$('.tips-btn').click(function(){
			if(!$(this).hasClass('open')){
				$(this).addClass('open');
				$('.tips-text').text('你还可以打印'+count+'张')
			}else{
				$(this).removeClass('open');
				$('.tips-text').text('x'+count);
			}
			
		})
		/*旋转*/
		$('.right-btn').click(function(){
			var isS = $("#isSelect").val();
			var imgPath = $("#image").attr("src");
			if(isS == null || isS == ""|| imgPath=="H5/ystz/img/a/default_img.png"){
				showTips('请上传相片！');
				//alert('请上传相片！');
				return false;
			}
		})
		/*图片预览*/
		$('.preview').click(function(){
			var isS = $("#isSelect").val();
			var imgPath = $("#image").attr("src");
			if(isS == null || isS == "" || imgPath=="H5/ystz/img/a/default_img.png"){
				showTips('请上传相片！');
				//alert('请上传相片！');
				return false;
			}
		})
		/*下一步*/
		$('.next-wrap').click(function(){
			var isS = $("#isSelect").val();
			var imgPath = $("#image").attr("src");
			if(isS == null || isS == ""|| imgPath=="H5/ystz/img/a/default_img.png"){
				showTips('请上传相片！');
				//alert('请上传相片！');
				return false;
			}
			//$('.print').click();
		})
		
		
		$("#inputImageBtn").click(function(){
			$("#inputImage").click();
		})
		
		var divWidth = parseFloat($(".img-container").css("width"));
		var divHeight  =  divWidth*cutHeight/cutWidth;
		
		
		if('${sessionScope.area.isCannotScanPhotoText}'=='1'){
			$("#photoTextRow").hide();
		}else{
			divHeight = divHeight - parseInt($("#photoTextRow").css("height"));
		}
		
		
		$(".img-container").css({"height":divHeight,"min-height":divHeight});
		
		$("#frame-default").click();
	})
	
	
	function selectedPic(){
		$("#isSelect").val("1");
		/*选择图片后隐藏上传图片按钮层 并显示删除按钮*/
		$('.upImage').hide();
		$('.del-btn').show();
	}
	function showPayment(){
		$('.payment-methods-wrap').show();
	}
	function hidePayment(){
		$('.payment-methods-wrap').hide();
	}
	//调节底部相框大小
	function resetFrameWidth(){
		var frameImg = $('.frame-content').find('img');
		var frameLi = $('.frame-content').find('li');
		var frameImgMargin = frameLi.css('marginLeft');
		var frameImgWidth = frameImg.width();
		var frameImgLength = frameImg.length;
		if(frameImgLength < 0 || frameImgLength == 0){
			var frameSpan = $('.frame-content').find('span');	
			frameImgWidth = frameSpan.length;
			frameImgLength=frameSpan.length;
		}
		$('.frame-content ul').css({'width':( parseInt(frameImgWidth) + parseInt(frameImgMargin) ) * frameImgLength + 10})
	}
</script>


</html>
