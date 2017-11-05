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
<title>裁剪图片</title>
<script type="text/javascript">
	var aspectRatio = parseFloat('${printer.cutWidth }') /parseFloat('${printer.cutHeight }');
</script>

<link rel="stylesheet" href="H5/yushang/assets/css/font-awesome.min.css">
  <link rel="stylesheet" href="H5/yushang/assets/css/bootstrap.min.css">
  <link rel="stylesheet" href="H5/yushang/dist/cropper.css">
  <link rel="stylesheet" href="H5/yushang/tools/css/main.css">
  <!-- <link rel="stylesheet" href="OAuth/wechatpay/css/phone.css" /> -->
  <link rel="stylesheet" href="H5/yushang/index.css" />

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

</head>
<body>
  <!--[if lt IE 8]>
    <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
  <![endif]-->
<div class="top-number">机器号码：<span>${printer.printerNo } </span></div>
  <!-- Content -->
  <div class="container">
  <div class="min-con">
  	 <div class="img-wrap">
      <div class="img-bg">
        <!-- <h3 class="page-header">Demo:</h3> -->
        <div class="img-container">
        	<!-- H5/demo//assets/img/picture.jpg -->
        	<!-- H5/demo/index.jpg -->
          <img id="image" src="H5/yushang/img/pic.png" alt="Picture" >
        </div>
      </div>
    </div>
    
    
    <div class="" id="photoTextRow">
    	<div class="">
    		<center>
    			<input type="text" placeholder="这里输入心情文字" id="phototext" name="phototext" style="width: 80%;">
    		</center>
    		<br>
    		<c:if test="${showtype == 'pwd'}">
    			<center>
	    			<input type="text" placeholder="这里输入密码" id="pwd" name="pwd" style="width: 80%;">
	    		</center>
	    		<br>
    		</c:if>
    	</div>
    </div>
     <div class="docs-buttons two-btn-wrap">
     	<p>
    		  <button type="button" class="right-btn" data-method="rotate" data-option="90" title="Rotate Right" >
            <span class="docs-tooltip" data-toggle="tooltip">
             <!--  <span class="fa fa-rotate-right"></span> -->
             <!-- 右转 -->
            </span>
          </button>
    	</p>
         <p>
          <button type="button" class="refresh" data-method="reset" title="Reset" >
            <span class="docs-tooltip" data-toggle="tooltip">
              <!-- <span class="fa fa-refresh">刷新</span> -->
            <!--   刷新 -->
            </span>
          </button>
          </p>
      <p>
          <button type="button" class="preview" data-method="getCroppedCanvas"  data-option="{ &quot;width&quot;: ${printer.cutWidth }, &quot;height&quot;: ${printer.cutHeight } }">
            <span class="docs-tooltip" data-toggle="tooltip">
              <!-- 预览图片 -->
            </span>
          </button>
          </p>
   
    	 	<p>
     		   	<button type="button" class="left-btn" data-method="rotate" data-option="-90" title="Rotate Left">
            	<span class="docs-tooltip" data-toggle="tooltip">
	              <!-- <span class="fa fa-rotate-left"></span> -->
	              <!-- 左转 -->
	            </span>
	          </button>
     	</p>
        
          
        
       </div>
       
  </div>
    
    
    <div class="btn-wrap row">
      <div class="" style="text-align:center;">
        <!-- <h3 class="page-header">Toolbar:</h3> -->


       <!--  <div class="btn-group"> -->
      
          

       <!--  </div> -->



        <div class="btn-group-crop docs-buttons">
      		<input type="hidden" id="isSelect">
     
          <p>
          <button type="button" class="print" data-method="uploadCroppedCanvas"  data-option="{ &quot;width&quot;: ${printer.cutWidth }, &quot;height&quot;: ${printer.cutHeight } }">
            <span class="docs-tooltip" data-toggle="tooltip">
              <!-- 打印图片 -->
            </span>
          </button>
          </p>
          <p>
          	<input type="file" class="sr-only" id="inputImage" name="file" accept="image/*" onchange="selectedPic()">
           <button class="uploading" id="inputImageBtn" title="Upload image file" >
            <span class="docs-tooltip" data-toggle="tooltip">
              <!-- <span class="fa fa-upload"></span> -->
              <!-- 上传 -->
            </span>
          </button>
          </p>
        </div>

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
<!-- 	
	<div class="bottom-wrap">
		<a href="wechatprinter/paycenter/list.do"></a>
		<a href="wechatprinter/imageutil/show.do"></a>
		
	</div> -->
	
	<div id="uploading" style="position:fixed;top:0;bottom:0;left:0;width:100%;height:100%;background:rgba(0, 0, 0, 0.43);display:none;z-index:9999999999999;">
		<p>请稍后</p>
	</div>
 

  <!-- Scripts -->
  <script src="H5/yushang/assets/js/jquery.min.js"></script>
  <script src="H5/yushang/assets/js/bootstrap.min.js"></script>
  <script src="H5/yushang/dist/cropper.js"></script>
  <script src="H5/yushang/tools/js/main.js"></script>
</body>
<script type="text/javascript">
	var cutWidth = parseFloat('${printer.cutWidth }');
	var cutHeight = parseFloat('${printer.cutHeight }');
	var uploadUrl = '<%=basePath %>wechatprinter/imageutil/uploadNewImage.do';
	var mainUrl =  '<%=MessageUtil.DEFAULT_IP%>'+"wechatprinter/oauth/oauth.do?func=redirect&areaid=${sessionScope.area.areaID}&processid=${sessionScope.processid}";
	
	$(function(){
		
		
		$("#inputImageBtn").click(function(){
			$("#inputImage").click();
		})
		
		var divWidth = parseFloat($(".img-container").css("width"));
		var divHeight  =  divWidth*cutHeight/cutWidth;
		
		$(".img-container").css({"height":divHeight,"min-height":divHeight});
		
		if('${sessionScope.area.isCannotScanPhotoText}'=='1'){
			$("#phototext").hide();
		}
	})
	
	
	function selectedPic(){
		$("#isSelect").val("1");
	}
</script>


</html>
