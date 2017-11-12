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
	
	photo = new WCPhoto();
	photo.setPhotoFileName("http://www.baidu.com/img/bd_logo1.png");
	request.setAttribute("photo", photo);
	
	//
	/*if(photo!=null&&!ToolsUtils.checkIsNull(photo.getPhotoFileName())){
		String filePath = new ServletUtils().getLocalPath()+"oriImage/"+photo.getPhotoFileName();
		//System.out.println(filePath);
		File file = new File(filePath);
		if(!file.exists()){
			photo.setPhotoFileName("");
			request.setAttribute("photo", photo);
		}
	}*/
	
%>
<!DOCTYPE html>
<html lang="en">

<head>

	<base href="<%=basePath %>" />
	<script type="text/javascript">
		var aspectRatio = parseFloat('${printer.cutWidth }') /parseFloat('${printer.cutHeight }');
		var cutWidth = parseFloat('${printer.cutWidth }');
		var cutHeight = parseFloat('${printer.cutHeight }');
		var uploadUrl = '<%=basePath %>wechatprinter/imageutil/testuploadNewImage2.do';
		var checkIsPrintPhotoUrl = '<%=basePath %>wechatprinter/imageutil/testcheckIsPrintPhoto2.do';
		var mainUrl =  '<%=MessageUtil.DEFAULT_IP %>'+"wechatprinter/oauth/oauth.do?func=redirect&areaid=${sessionScope.area.areaID}&processid=${sessionScope.processid}";
		
	</script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name=renderer content=webkit>
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <link rel="stylesheet" href="H5/ystz/new/css/reset.css">
    <link rel="stylesheet" href="H5/ystz/new/css/print.css">
    <title>打印照片</title>
    <style type="text/css">
    .payment-methods-wrap{
  		position:fixed;
  		z-index: 99999999;
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
    <script type="text/javascript">
    	$(function(){
    		console.log($('.photo-clip-rotateLayer img'));
    	})
    </script>
</head>

<body>
    <!--加载资源-->
    <div class="lazy_tip" id="lazy_tip">
        <span>1%</span>
        <br> 加载中......
    </div>
    <div class="lazy_cover"></div>
    <div class="resource_lazy hide"></div>

    <div class="pic_edit">

        <div id="clipArea"></div>
        <!-- 广告区域 -->
        <img src="H5/ystz/new/photo/images/ad/ad_1.jpg" alt="" class="ad-img">
        <c:if test="${sessionScope.area.isCannotScanPhotoText}!=1"></c:if>
        
        <div class="" id="photoTextRow" style="display: none;">
			<center>
    			<textarea rows="2" cols="" placeholder="这里输入心情文字" id="phototext" name="phototext" ></textarea>
    		</center>
		</div>       
        
        <!-- 广告区域结束 -->
        <div class="frame-type">
            <div class="top-tips">
                <span>点击</span>
                <span class="min-add-icon"></span>
                <span>上传照片，图片可以旋转缩放，调整后点击</span>
                <span class="min-yes-icon"></span>
                <span>
                	<%--<c:if test="${photo != null and photo.photoFileName != null and photo.photoFileName != ''}">
                		${photo.photoFileName }
                	</c:if>--%>
                </span>
                
            </div>
            <div class="type-item">
                <div class="type-item-inner clearfix">
                    <div onclick="showTxt(0)" class="item active">
                        <img src="H5/ystz/new/photo/images/type_blank.png" alt="" class="frame-icon">
                        <span class="text">广告</span>
                    </div>
                    <div onclick="showTxt(1)" class="item">
                        <img  src="H5/ystz/new/photo/images/type_blank.png" alt="" class="frame-icon">
                        <span class="text">文字</span>
                    </div>
                    <div onclick="showTxt(0)" class="item">
                        <img  src="H5/ystz/new/photo/frame/min/1.png" data-src="H5/ystz/new/photo/frame//1.png" alt="" class="frame-icon">
                        <span class="text">照片</span>
                    </div>
                    <div onclick="showTxt(0)" class="item">
                        <img src="H5/ystz/new/photo/frame/min/2.png" data-src="H5/ystz/new/photo/frame//2.png" alt="" class="frame-icon">
                        <span class="text">照片</span>
                    </div>
                    <div onclick="showTxt(0)" class="item">
                        <img src="H5/ystz/new/photo/frame/min/3.png" data-src="H5/ystz/new/photo/frame//3.png" alt="" class="frame-icon">
                        <span class="text">照片</span>
                    </div>
                    <div onclick="showTxt(0)" class="item">
                        <img src="H5/ystz/new/photo/frame/min/4.png" data-src="H5/ystz/new/photo/frame//4.png" alt="" class="frame-icon">
                        <span class="text">照片</span>
                    </div>
                    <div onclick="showTxt(0)" class="item">
                        <img src="H5/ystz/new/photo/frame/min/5.png" data-src="H5/ystz/new/photo/frame//5.png" alt="" class="frame-icon">
                        <span class="text">照片</span>
                    </div>
                    <div onclick="showTxt(0)" class="item">
                        <img src="H5/ystz/new/photo/frame/min/6.png" data-src="H5/ystz/new/photo/frame//6.png" alt="" class="frame-icon">
                        <span class="text">照片</span>
                    </div>
                    <div onclick="showTxt(0)" class="item">
                        <img src="H5/ystz/new/photo/frame/min/7.png" data-src="H5/ystz/new/photo/frame//7.png" alt="" class="frame-icon">
                        <span class="text">照片</span>
                    </div>
                    <div onclick="showTxt(0)" class="item">
                        <img src="H5/ystz/new/photo/frame/min/8.png" data-src="H5/ystz/new/photo/frame//8.png" alt="" class="frame-icon">
                        <span class="text">照片</span>
                    </div>
                    <div onclick="showTxt(0)" class="item">
                        <img src="H5/ystz/new/photo/frame/min/9.png" data-src="H5/ystz/new/photo/frame//9.png" alt="" class="frame-icon">
                        <span class="text">照片</span>
                    </div>
                    <div onclick="showTxt(0)" class="item">
                        <img src="H5/ystz/new/photo/frame/min/10.png" data-src="H5/ystz/new/photo/frame//10.png" alt="" class="frame-icon">
                        <span class="text">照片</span>
                    </div>
                    <div onclick="showTxt(0)" class="item">
                        <img src="H5/ystz/new/photo/frame/min/11.png" data-src="H5/ystz/new/photo/frame//11.png" alt="" class="frame-icon">
                        <span class="text">照片</span>
                    </div>
                    <div onclick="showTxt(0)" class="item">
                        <img src="H5/ystz/new/photo/frame/min/12.png" data-src="H5/ystz/new/H5/ystz/new/photo/frame//12.png" alt="" class="frame-icon">
                        <span class="text">照片</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="bottom">
            <div class="left-info">
                <span class="address-icon"></span>
                <span>机台号：</span>
                <span>${printer.printerNo }</span>
            </div>
            <a href="javascript:;" class="right-btn" id="clipBtn">
                <span class="min-yes-icon"></span>
                <span>提交</span>
            </a>
        </div>

        <input type="file" id="file" style="opacity: 0;position: fixed;bottom: -100px">
        
        
        <div class="payment-methods-wrap"  style="display: none;">
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
    </div>
    <img src="" title="upload.jpg" fileName="" id="hit" style="display:none;z-index: 9">
    <canvas id="canvas1" style="display:none;"></canvas>
    <script src="H5/ystz/new/photo/js/jquery-2.1.0.min.js"></script>
    <script src="H5/ystz/new/js/resetSize.js"></script>
    <script src="H5/ystz/new/js/layer_mobile/layer.js"></script>
    <script src="H5/ystz/new/photo/js/compressImg/lrz.bundle.js"></script>
    <script src="H5/ystz/new/photo/js/sonic.js"></script>
    <script src="H5/ystz/new/photo/js/comm.js"></script>
    <script src="H5/ystz/new/photo/js/hammer.js"></script>
    <script src="H5/ystz/new/photo/js/iscroll-zoom.js"></script>
    <script src="H5/ystz/new/photo/js/jquery.photoClip.js"></script>
    <script type="text/javascript">
    	function showTxt(type){
    		$("#phototext").val("");
    		if(type==1){
                $('.ad-img').hide();
    			$("#photoTextRow").show();	
    		}else{
                $("#photoTextRow").hide();
                $('.ad-img').show();
    		}
    		
    	}
    </script>
    <script>
        var photo_width = 414; //打印出来的相片宽度

        var scale = 593 / 670; //打印比例 -> 根据宽度可以计算出高度

        //判断是不是手机端
        var is_mobile = !!navigator.userAgent.match(/mobile/i);

        var hammer = '';
        var currentIndex = 0;
        var body_width = $('body').width();
        var body_height = $('body').height();



        //图片上传
        function saveImageInfo() {
            var filename = $('#hit').attr('fileName');
            var img_data = $('#hit').attr('src');

            $.post("这里填写图片获取的网址", { image: img_data }, function (data) {
                if (data != '') {
                    //			console.info(data);
                    //data 为返回文件名；
                    alert('提交成功');
                }
            });
        }

        /*获取文件拓展名*/
        function getFileExt(str) {
            var d = /\.[^\.]+$/.exec(str);
            return d;
        }

        function showLoading(){
        	 $('.lazy_tip span').text("");
             $('.lazy_cover,.lazy_tip').show();
        }
        
        function hideTips(){
        	$('.lazy_cover,.lazy_tip').hide();
       }
        function showTips(msg){
        	layer.open({
                content: msg
                , skin: 'msg'
                , time: 2 //2秒后自动关闭
            });
        }
        //图片上传结束
        $(function () {
            $('<i class="clear-img"></i>').appendTo($('#clipArea'));


            $("#clipArea").photoClip({
                width: body_width * 0.8036,
                height: (body_width * 0.8036) / scale,
                file: "#file",
                view: "#hit",
                ok: "#clipBtn",
                clear: ".clear-img",
                loadStart: function () {
                    //console.log("照片读取中");
                    $('.lazy_tip span').text('');
                    $('.lazy_cover,.lazy_tip').show();
                },
                loadComplete: function (data) {
                    //console.log("照片读取完成");
                    console.log(data)
                    $('.lazy_cover,.lazy_tip').hide();
                },
                clipFinish: function (dataURL) {
                    $('#hit').attr('src', dataURL);
                    
                    showLoading("");
                    $.ajax({
                  		type:"POST",
                  		url:checkIsPrintPhotoUrl,
                  		dataType:"json",
                  		async:false,
                  		success:function(data){
                  			hideTips();
                  			if(data.code<0){
                  				
                  				console.log("data.msg == "+data.msg);
                  				showTips(data.msg);
                  			}else{
                  				var printCode = data.code;
                  				//0、没有足够金币
                  				//1、有足够打印次数
                  				//2、免费打印
                  				//drawImageFrame(imgResult,'upload',printCode);
                  				drawImageFrame(dataURL,printCode);
                  			}
                  			
                  		},error: function(XMLHttpRequest, textStatus, errorThrown) {
                  			$("#uploading").hide();
                  			showTips('请求网络出错，请重试，错误码：'+textStatus+'！')
                  		}, complete: function(XMLHttpRequest, textStatus) {
                  			//$("#uploading").hide();
                  		}
                  	})
                    
                    
                    //saveImageInfo();
                }
            });

            $('.ad-img').css('width', body_width * 0.8036);
            $('#photoTextRow').css('width', body_width * 0.8036);
            $('#phototext').on('focus',function(){
                $(this).css({
                    position:"fixed",
                    bottom:0,
                    left:0,
                    right:0,
                    'z-index':'1000'
                })
            }).on('blur',function(){
                $(this).css({
                    position:"static"
                })
            })

            $('#upload2').on('touchstart', function () {
                //图片上传按钮
                $('#file').click();
            })
            $('#upload2').on('click', function () {
                //图片上传按钮
                $('#file').click();
            })
        })

    </script>
    <script>
        function drawImageFrame(result,printCode) {
            $('.lazy_cover,.lazy_tip').show();
            var canvas = document.getElementById('canvas1');
            var ctx = canvas.getContext("2d");
            var hit = $('#hit')//生成的图片
            var canvasWidth = photo_width;//打印出来相片宽度
            var canvasHeight = photo_width / scale; //打印出来相片高度
            canvas.width = canvasWidth;
            canvas.height = canvasHeight;
            var img = new Image();
            img.width = canvasWidth;
            img.height = canvasHeight;
            img.src = result;
            img.onload = function () {
                ctx.drawImage(img, 0, 0, canvasWidth, canvasHeight);//相片
                //相框
                var frameBg = $('.frame-bg').attr('data-src'); //'photo/frame/3.png' //$('.frame-bg').attr('url'); 
                if (frameBg != '' && frameBg != null && frameBg != undefined) {
                    var frame = new Image();
                    frame.width = canvasWidth;
                    frame.height = canvasHeight;
                    frame.src = frameBg;//相框路径
                    frame.onload = function () {

                        ctx.drawImage(frame, 0, 0, canvasWidth, canvasHeight);//相片
                        var base64 = canvas.toDataURL();
                        printPhoto(base64,printCode);

                    }
                } else {
                    var base64 = canvas.toDataURL();
                    printPhoto(base64,printCode);
                }
            }
        }

        function printPhoto(base64,printCode) {
        	showLoading("");
            lrz(base64)
                .then(function (rst) {
                    $('.lazy_cover,.lazy_tip').hide();
                    layer.open({
                        title: [
                            '是否打印？',
                            'background-color:#F0607B; color:#fff;'
                        ]
                        , anim: 'scale'
                        , content: '<img src="' + rst.base64 + '" style="display:block;width:100%;margin:auto;">'
                        , btn: ['确认', '取消']
                        ,
                        yes: function () {
                            // 处理成功会执行
                            base64 = rst.base64.split(",")[1];
                            //console.log(base64)

                            //printCode 打印方式
                            //0、没有足够金币
                            //1、有足够打印次数
                            //2、免费打印
                            //var printCode = 0;
                            uploadImageToServer(base64, printCode);
                        }
                    });


                }).catch(function (err) {
                    // 处理失败会执行
                    $('.lazy_cover,.lazy_tip').hide();
                    layer.open({
                        content: '处理图片失败！请重试'
                        , skin: 'msg'
                        , time: 2 //2秒后自动关闭
                    });
                })
        }

        //printCode 打印方式
        //0、没有足够金币
        //1、有足够打印次数
        //2、免费打印

        function uploadImageToServer(database, printCode) {

        	showLoading("");
            var fd = new FormData();
            fd.append('file', database);//用作ajax请求的数据
            $.ajax({
                url: uploadUrl + "?phototext=" + $("#phototext").val() + "&" + Math.random(),
                type: "POST",
                data: fd,
                processData: false,
                contentType: false,
                cache: false,
                dataType: "json",
                success: function (data) {
                	hideTips();
                    if (data.code > 0) {

                        if (printCode != 0 && printCode != 1 && printCode != 2) {
                            showTips("未能正确判断打印方式，请重新点击下一步确认！");
                            return;
                        }

                        if (printCode == 0) {
                            showPayment();
                        } else {
                            location.href = "H5/ystz/complete2.jsp";
                        }

                    } else {
                        showTips(data.msg);
                    }
                },
                error: function (msg) {
                	hideTips();
                    showTips("上传照片失败，请重试！");
                }, complete: function (XMLHttpRequest, textStatus) {
                    //$("#uploading").hide();
                }

            })

        }

        $(function () {
            var $clip_view = $('.photo-clip-view');

            /*自定义扩展图片裁剪*/
            //添加相框显示
            $('<dv class="frame-bg"></div>').css({
                "position": "absolute",
                "left": "0",
                "top": "0",
                "right": "0",
                "bottom": "0",
                "z-index": "1",
                "pointer-events": "none",
                //"background": 'url("photo/frame/3.png") center center / 100% 100% no-repeat'
            }).appendTo($clip_view);
            
            $('.clear-img').css({
                "right": $clip_view.offset().left - 13
            }).click(function () {
                $('#file').val("");
                $('.photo-clip-rotateLayer img').remove();
                console.log($('#file').val())
            })
            /*自定义扩展图片裁剪结束*/

            /*计算相片裁剪西区域大小*/
            $("#clipArea").css({
                "min-height": $clip_view.height()
            })


            //点击添加图片事件
            if (is_mobile) {
                $clip_view.on('touchstart', function () {
                    var file = $('#file');
                    if (!$.trim(file.val())) {
                        $('#file').click();
                    }
                })
            } else {
                $clip_view.on('click', function () {
                    var file = $('#file');
                    if (!$.trim(file.val())) {
                        $('#file').click();
                    }
                })
            }
            //计算相框宽度
            var $frame_item = $('.item'),
                $frame_item_size = $frame_item.length;
                $frame_item_width = $frame_item.width(),
                $frame_item_margin_right = parseFloat($frame_item.css("margin-right"))+1;

            var bg_j = 0
            for (var i = 0; i < $frame_item_size; i++) {
                if (bg_j++ >= 5) {
                    bg_j = 0;
                }
                $($frame_item[i]).addClass('item' + bg_j);

            }

            $('.type-item-inner').css({ 'width': $frame_item_size * ($frame_item_width + $frame_item_margin_right) + "px" })

            //切换背景
            $('.item').on('click', function () {
                $(this).addClass('active').siblings('.item').removeClass('active')
                var src = $(this).find("img").attr("data-src");
                src && $('.frame-bg').css({ "background": 'url("' + src + '") center center / 100% 100% no-repeat' }).attr("data-src", src);
            })


        })
        
        function showPayment(){
			$('.payment-methods-wrap').show();
		}
		function hidePayment(){
			$('.payment-methods-wrap').hide();
		}
    </script>
    <div id="cover"></div>
</body>

</html>