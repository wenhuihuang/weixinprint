function printPhoto(pwd,successUrl){
  	$.ajax({
  		type:"POST",
  		url:"wechatprinter/imageutil/printPhoto2.do",
  		data:{pwd:pwd},
  		dataType:"json",
  		async:false,
  		success:function(data){
  			$("#uploading").hide();
  			var msg = data.msg.replace(/<br>/g,"\n");
  			showTips(msg);
  			if(data.code>0){
  				setTimeout(function(){ location.href=successUrl; }, 500);
  			}
  			
  		},error: function(XMLHttpRequest, textStatus, errorThrown) {
  			$("#uploading").hide();
  			showTips('请求网络出错，请重试，错误码：'+textStatus+'！')
  		}, complete: function(XMLHttpRequest, textStatus) {
  			$("#uploading").hide();
  		}
  	})
  	
  }