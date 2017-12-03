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