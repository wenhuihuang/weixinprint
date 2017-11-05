var load ='  <div class="row "><div class="text-center"><img src="img/load3.gif"><h3 class="text-center">读取中……</h3></div></div>';
var movieinfo= load;
var commovieinfo = load;
var movieid ;
var firstgetComing = true;

window.onload=function () {

    var navheight =$("#topnav").height();


    $("#movieinfoWin"). css("margin-top",navheight);
 //   $("#detailWin"). css("margin-top",navheight);

   // 热映电影GET
    $.ajax({
        url: 'https://api.douban.com/v2/movie/in_theaters',
        //  url:'https://api.douban.com/v2/movie/subject/25777636',
        type: 'GET',
        dataType: 'jsonp',
        cache: false,

        error: erryFunction,  //错误执行方法
        success: succFunction //成功执行方法
    });


    $("#turnback").on("click",function () {

        $("#turnback").hide();
        $("#more").off();
        $("#more").hide();
        $("#detailWin").hide();
        $("#topnav").fadeIn();
        $("#movieinfoWin").fadeIn();

        location.hash="#"+movieid;



    });

}





function erryFunction() {
    alert("ERROR");

}

function  succFunction(data) {


    
    
    $("#movieinfoWin").html("");
    var infostr="";

    var movienum = parseInt(data.total);
    if(movienum>=18){movienum=18}
    for(var i=0;i<movienum;i++)
    {
        var mimg=data.subjects[i].images["medium"];
        var type =data.subjects[i].genres;
        var name = data.subjects[i].title;
        try{
            var yan1 =data.subjects[i].casts[0].name;
            var yan2 =data.subjects[i].casts[1].name;
        }
        catch (e){
            yan1="";yan2=" ";
        }
        var score =data.subjects[i].rating["average"];
        infostr+='<div class="row movieinfo" id="'+data.subjects[i].id+'">  <div class="col-xs-5 "><img src="'+mimg+'" id="img" class="center-block text-center img-responsive "></div> <div class="col-xs-7 mtextinfo"> <p id="title" class="lead">'+name+'</p> ' +
            '<p >类型：<span id="type">'+type+'</span></p> <p >主演：<span id="yan1_'+i+'">'+yan1+'</span>&nbsp;<span id="yan2_'+i+'">'+yan2+'</span></p> <p id="score" >'+score+'</p> </div> </div>';
        
    }



    $("#movieinfoWin").html(infostr);

    movieinfo =infostr;

    $(".movieinfo").on("click",function () {

      movieid=  $(this).attr("id");
        $.ajax({

        url:'https://api.douban.com/v2/movie/subject/'+movieid,
           // url:'https://api.douban.com/v2/movie/subject/25777636',
            type: 'GET',
            dataType: 'jsonp',
            cache: false,

            error: getDetailError,  //错误执行方法
            success: getDetailOK //成功执行方法
        });


    });

}
function getDetailError() {
    alert("获取详细信息失败");

}

function getDetailOK(data) {
    $("#topnav").hide();
    $("#movieinfoWin").hide();
    $("#turnback").fadeIn();
    $("#more").fadeIn();
    $("#detailWin").slideDown("slow");
    $("#detailimg").prop("src",data.images["medium"]);

    $("#etitle").html(data.original_title);
    $("#countries").html(data.countries);
    $("#mtype").html(data.genres);

    try{
        $("#yan1").html(data.casts[0].name);
        $("#yan2").html(data.casts[1].name);
        $("#yan3").html(data.casts[2].name);
    }
    catch (e){
        $("#yan1").html("");
        $("#yan2").html("");
        $("#yan3").html("");
    }

    var snum= (parseInt( data.rating["stars"])/10);
   var score= data.rating["average"];
    addStars(snum,score);
   $("#wishcount").html( data.wish_count);
  $("#summary").html(data.summary);
    $("#detailtitle").html(data.title);
    var doubanurl=data.mobile_url;
    $("#more").on("click",function () {

        window.open(doubanurl);

    });


}

function addStars(starnum,score) {

    var star ='<span class="glyphicon glyphicon-star stars" aria-hidden="true"></span>';

    var addstar="";
    for(var i=0;i<starnum;i++)
    {
        addstar+=star;
  
    }
    $("#stars").html("推荐指数："+addstar);
    $("#scores").html(score+"/10");
}


$("#topbtn1").on("click",function () {
    $("#topbtn2").removeClass("topactive");
    $("#topbtn1").addClass("topactive");


    $("#movieinfoWin").html(movieinfo);
    $(".movieinfo").on("click",function () {


        var movieid=  $(this).attr("id");
        $.ajax({

            url:'https://api.douban.com/v2/movie/subject/'+movieid,
            // url:'https://api.douban.com/v2/movie/subject/25777636',
            type: 'GET',
            dataType: 'jsonp',
            cache: false,

            error: getDetailError,  //错误执行方法
            success: getDetailOK //成功执行方法
        });


    });

});

$("#topbtn2").on("click",function () {
    $("#topbtn1").removeClass("topactive");
    $("#topbtn2").addClass("topactive");
    $("#movieinfoWin").html(load);

   if(firstgetComing){
       $.ajax({
           url: 'https://api.douban.com/v2/movie/coming_soon',
           //  url:'https://api.douban.com/v2/movie/subject/25777636',
           type: 'GET',
           dataType: 'jsonp',
           cache: false,

           error: erryFunction,  //错误执行方法
           success: comingsoonMovie//成功执行方法
       });
   }
    else {
       $("#movieinfoWin").html(commovieinfo);
       $(".movieinfo").on("click",function () {

           movieid=  $(this).attr("id");
           $.ajax({

               url:'https://api.douban.com/v2/movie/subject/'+movieid,
               // url:'https://api.douban.com/v2/movie/subject/25777636',
               type: 'GET',
               dataType: 'jsonp',
               cache: false,

               error: getDetailError,  //错误执行方法
               success: getComingDetail //成功执行方法
           });


       });
   }
});

function comingsoonMovie(data) {
    firstgetComing =false;
    var infostr="";

    var movienum = parseInt(data.total);
    if(movienum>=15){movienum=15}
    for(var i=0;i<movienum;i++)
    {
        var mimg=data.subjects[i].images["medium"];
        var type =data.subjects[i].genres;
        var name = data.subjects[i].title;
       try{
           var yan1 =data.subjects[i].casts[0].name;
           var yan2 =data.subjects[i].casts[1].name;
       }
        catch (e){
            yan1="";yan2=" ";
        }
        infostr+='<div class="row movieinfo" id="'+data.subjects[i].id+'">  <div class="col-xs-5 "><img src="'+mimg+'" id="img" class="center-block text-center img-responsive "></div> <div class="col-xs-7 mtextinfo"> <p id="title" class="lead">'+name+'</p> ' +
            '<p >类型：<span id="type">'+type+'</span></p> <p >主演：<span id="yan1_'+i+'">'+yan1+'</span>&nbsp;<span id="yan2_'+i+'">'+yan2+'</span></p> </div> </div>';

    }

    commovieinfo=infostr;

    $("#movieinfoWin").html(infostr);

    $(".movieinfo").on("click",function () {

         movieid=  $(this).attr("id");
        $.ajax({

            url:'https://api.douban.com/v2/movie/subject/'+movieid,
            // url:'https://api.douban.com/v2/movie/subject/25777636',
            type: 'GET',
            dataType: 'jsonp',
            cache: false,

            error: getDetailError,  //错误执行方法
            success: getComingDetail //成功执行方法
        });


    });

}

function getComingDetail(data) {
    $("#topnav").hide();
    $("#movieinfoWin").hide();
    $("#turnback").fadeIn();
    $("#more").fadeIn();
    $("#detailWin").slideDown("slow");
    $("#detailimg").prop("src",data.images["medium"]);

    $("#etitle").html(data.original_title);
    $("#countries").html(data.countries);
    $("#mtype").html(data.genres);

    try{
        $("#yan1").html(data.casts[0].name);
        $("#yan2").html(data.casts[1].name);
        $("#yan3").html(data.casts[2].name);
    }
    catch (e){
        $("#yan1").html("");
        $("#yan2").html("");
        $("#yan3").html("");
    }

    $("#stars").html(" ");
    $("#scores").html("");
    $("#wishcount").html( data.wish_count);
    $("#summary").html(data.summary);
    $("#detailtitle").html(data.title);
    var doubanurl=data.mobile_url;
    $("#more").on("click",function () {

        window.open(doubanurl);

    });
}