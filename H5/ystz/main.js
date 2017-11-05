$(function () {
	


  var console = window.console || { log: function () {} };
  var $image = $('#image');
  var $download = $('#download');
  var $dataX = $('#dataX');
  var $dataY = $('#dataY');
  var $dataHeight = $('#dataHeight');
  var $dataWidth = $('#dataWidth');
  var $dataRotate = $('#dataRotate');
  var $dataScaleX = $('#dataScaleX');
  var $dataScaleY = $('#dataScaleY');
  var options = {
		viewMode: 3,
        aspectRatio: aspectRatio,
        dragMode: 'move',
        autoCropArea: 1,
        restore: false,
        modal: false,
        guides: false,
        highlight: false,
        cropBoxMovable: false,
        cropBoxResizable: false,
        preview: '.img-preview',
        crop: function (e) {
        }
      };




  // Cropper
  $image.on({
  }).cropper(options);


  // Buttons
  if (!$.isFunction(document.createElement('canvas').getContext)) {
    $('button[data-method="getCroppedCanvas"]').prop('disabled', true);
  }

  if (typeof document.createElement('cropper').style.transition === 'undefined') {
/*    $('button[data-method="rotate"]').prop('disabled', true);
    $('button[data-method="scale"]').prop('disabled', true);*/
  }


  // Download
  if (typeof $download[0].download === 'undefined') {
    $download.addClass('disabled');
  }
  //加相框
  //var canvas = $("#canvas")[0];
  var base64="";
  function drawImageFrame(result,type,printCode){
	  $('#canvas1').show();
	  $('#uploading').show();
      var canvasWidth = $(result).attr('width');
      var canvasHeight = $(result).attr('height');
     var canvas = document.getElementById('canvas1');
    var ctx = canvas.getContext("2d");
      canvas.width=canvasWidth;
      canvas.height=canvasHeight;
      //console.log(result.toDataURL())
      var img=new Image(); 
 			img.width=canvasWidth;
 			img.height=canvasHeight;
 			img.src=result.toDataURL();
 			img.onload=function(){
     		ctx.drawImage(img,0,0,canvasWidth,canvasHeight);//相片
     		//相框
     		var frameBg = $('.frame-bg').attr('url');
     		if(frameBg != '' && frameBg != null && frameBg != undefined){
     			var frame = new Image();
     			frame.width=canvasWidth;
     			frame.height=canvasHeight;
     			console.log(frameBg)
     			frame.src=frameBg;//相框路径
     			frame.onload=function(){
     				if(type=='upload'){
     					ctx.drawImage(frame,0,0,canvasWidth,canvasHeight);//相片
     					base64 = canvas.toDataURL();
     					lrz(base64)
    					.then(function(rst) {
    						// 处理成功会执行
    						base64=rst.base64.split(",")[1];
    						$('#canvas1').hide();
    						//console.log(base64)
    						uploadImageToServer(base64,printCode);
    					})
    					.catch(function (err) {
				            // 处理失败会执行
    						alert("压缩图片失败,请重试,提示:"+err);
    						$('#uploading').hide();
				        })
     				}else if(type=='get'){
     					ctx.drawImage(frame,0,0,canvasWidth,canvasHeight);//相片
         				$('#getCroppedCanvasModal').modal().find('.modal-body').html(canvas);
         				$('#uploading').hide();
     				}
     			}
     		}else{
     			if(type == 'upload'){
     				base64=canvas.toDataURL();
     				lrz(base64)
					.then(function(rst) {
						// 处理成功会执行
						base64=rst.base64.split(",")[1];
						$('#canvas1').hide();
						//console.log(base64)
						uploadImageToServer(base64,printCode);
					})
					.catch(function (err) {
			            // 处理失败会执行
						alert("压缩图片失败,请重试,提示:"+err);
						$('#uploading').hide();
			        })
     			}else if(type == 'get'){
     				$('#getCroppedCanvasModal').modal().find('.modal-body').html(canvas);
         			$('#uploading').hide();
     			}
     		}
     	}
  }
  
  // Methods
  $('.docs-buttons').on('click', '[data-method]', function () {
    var $this = $(this);
    var data = $this.data();
    var $target;
    var result;
    var canvas = document.getElementById('canvas1');
    var ctx = document.getElementById('canvas1').getContext("2d");

    if ($this.prop('disabled') || $this.hasClass('disabled')) {
      return;
    }

    if ($image.data('cropper') && data.method) {
      data = $.extend({}, data); // Clone a new one

      if (typeof data.target !== 'undefined') {
        $target = $(data.target);

        if (typeof data.option === 'undefined') {
          try {
            data.option = JSON.parse($target.val());
          } catch (e) {
            console.log(e.message);
          }
        }
      }
      
      var methodName = data.method;
      if("uploadCroppedCanvas"==methodName){
    	  data.method = "getCroppedCanvas";
      }
    	  
      
      result = $image.cropper(data.method, data.option, data.secondOption);

      if("uploadCroppedCanvas"==methodName){
    	  data.method = "uploadCroppedCanvas"
      }
      
      switch (data.method) {
        case 'scaleX':
        case 'scaleY':
          $(this).data('option', -data.option);
          break;

        case 'getCroppedCanvas':
          if (result) {
        	  drawImageFrame(result,'get',0)
              if (!$download.hasClass('disabled')) {
                $download.attr('href', result.toDataURL());
              }
          }

          break;
          
        case 'uploadCroppedCanvas':
        	 if (result) {
	        		 var imgPath = $("#image").attr("src");
        		 	if($("#isSelect").val()==""||$("#isSelect").val()==null||imgPath=="H5/ystz/img/a/default_img.png"){
        		 		showTips('请先上传图片！')
        		 		return;
        		 	}
        		 	//drawImageFrame(result,'upload');
        		 	$("#uploading").show();
        		 	setTimeout(function(){
        		 		checkIsPrintPhoto(result);	
        			}, 1000);
        		 	
				  	return false;
				  	/*var pwd = $("#pwd").val();
				  	pwd = (pwd==null||pwd=="")&&pwd!=undefined?"":pwd;
				  	
				  	if(pwd==""){
				  		$("#uploading").hide();
				  		alert("请输入密码！");
				  		return;
				  	}
				  	
				  	pwd = pwd==undefined?"":pwd;
				  	
				  	
                 	var fd = new FormData();
				  	fd.append('file',data);//用作ajax请求的数据
		            $.ajax({
				  		url:uploadUrl+"?pwd="+pwd+"&phototext="+$("#phototext").val()+"&"+Math.random(),
				  		type:"POST",
				  		data:fd,
				  		processData:false,
				  		contentType:false,
				  		cache:false,
				  		//csync:false,
				  		success:function(msg){
				  			$("#uploading").hide();
				  			alert(msg);
				  			if(msg.indexOf("制作中")>-1){
				  				location.href = mainUrl;
				  			}
				  			
				  		},
				  		error:function(msg){
				  			$("#uploading").hide();
				  			alert("上传照片失败，请重试！");
				  		}
				  		
				  	})*/
				  	
				  	
				  	
        	 }
          break;
      }

      if ($.isPlainObject(result) && $target) {
        try {
          $target.val(JSON.stringify(result));
        } catch (e) {
          console.log(e.message);
        }
      }

    }
  });




  // Import image
  var $inputImage = $('#inputImage');
  var URL = window.URL || window.webkitURL;
  var blobURL;

  if (URL) {
    $inputImage.change(function () {
      var files = this.files;
      var file;

      if (!$image.data('cropper')) {
        return;
      }

      if (files && files.length) {
        file = files[0];

        $('#uploading').show();
        lrz(file)
        .then(function(rst) {
			// 处理成功会执行
			$image.one('built.cropper', function () {

           // Revoke when load complete
          //URL.revokeObjectURL(blobURL);
         }).cropper('reset').cropper('replace', rst.base64);
         $inputImage.val('');
         $('#uploading').hide();
		})
        
        /*if (/^image\/\w+$/.test(file.type)) {
         // blobURL = URL.createObjectURL(file);
          $('#uploading').show();
         lrz(file)
         .then(function(rst) {
			// 处理成功会执行
			$image.one('built.cropper', function () {

            // Revoke when load complete
           //URL.revokeObjectURL(blobURL);
          }).cropper('reset').cropper('replace', rst.base64);
          $inputImage.val('');
          $('#uploading').hide();
		})
          
        } else {
          window.alert('Please choose an image file.');
        }*/
      }
    });
  } else {
    $inputImage.prop('disabled', true).parent().addClass('disabled');
  }

  
  
  
  
  
  
  
  
  
  
  
  
//检测是支付还是直接打印照片
  function checkIsPrintPhoto(imgResult){
  	$("#uploading").show();
  	
  	$.ajax({
  		type:"POST",
  		url:checkIsPrintPhotoUrl,
  		dataType:"json",
  		async:false,
  		success:function(data){
  			if(data.code<0){
  				$("#uploading").hide();
  				showTips(data.msg);
  			}else{
  				var printCode = data.code;
  				//0、没有足够金币
  				//1、有足够打印次数
  				//2、免费打印
  				drawImageFrame(imgResult,'upload',printCode);
  				
  			}
  			
  		},error: function(XMLHttpRequest, textStatus, errorThrown) {
  			$("#uploading").hide();
  			showTips('请求网络出错，请重试，错误码：'+textStatus+'！')
  		}, complete: function(XMLHttpRequest, textStatus) {
  			//$("#uploading").hide();
  		}
  	})
  }


  //printCode 打印方式
  //0、没有足够金币
  //1、有足够打印次数
  //2、免费打印

  function uploadImageToServer(database,printCode){
  	
  	$("#uploading").show();
  	var fd = new FormData();
  	fd.append('file',base64);//用作ajax请求的数据
  	$.ajax({
    		url:uploadUrl+"?phototext="+$("#phototext").val()+"&"+Math.random(),
    		type:"POST",
    		data:fd,
    		processData:false,
    		contentType:false,
    		cache:false,
    		dataType:"json",
    		success:function(data){
    			$("#uploading").hide();
    			if(data.code>0){
    				
    				if(printCode!=0&&printCode!=1&&printCode!=2){
    					showTips("未能正确判断打印方式，请重新点击下一步确认！");
    					return;
    				}
    				
    				if(printCode==0){
    					showPayment();
    				}else{
    					location.href = "H5/ystz/complete.jsp";
    				}
    				
    			}else{
    				showTips(data.msg);
    			}
    		},
    		error:function(msg){
    			$("#uploading").hide();
    			showTips("上传照片失败，请重试！");
    		}, complete: function(XMLHttpRequest, textStatus) {
  			//$("#uploading").hide();
  		}
    		
    	})
    	
  }


  
});
