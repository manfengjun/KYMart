gotoTop();

//$get("data/data.json",function(data){
//    if(data.status){
//        $('.loading').remove();
//        $('.mui-content').removeClass('mui-hidden').addClass('mui-block');
//    }
//});
aside($("#siderBtn"));
echo.init({
    offset: 0,
    throttle: 0
});
//获取变量
var $list = $(".list-content"),
    $dropDown =$(".dropDown").find("p"),
    $doc = $(document);

var par={
    page:0,
    count:4
};
$get("data/list.json",par,function(data){
    if(data.status){
        //有数据时
        var dataObj = data.info;
        var str='';
        for(var i = 0; i<dataObj.length;i++){
            str += template("list",dataObj[i]);
        }
        $list.append(str);
        echo.render();
        if($(".mui-content").innerHeight() < $(window).height()){
            $(".mui-content").css("minHeight",$(window).height()+1);
        }
    }else{
        //无数据时
        $dropDown.parent().hide();
        $list.html('暂时没有的数据');
    }
});
upLoad(
    $doc,
    $dropDown,
    function(suc,err){
        par.page++;
        $get('data/list.json', par, function (data) {
            if (data.status) {
                //有数据时
                var dataObj = data.info;
                var str = '';
                for (var i = 0; i < dataObj.length; i++) {
                    str += template("list", dataObj[i]);
                }
                $list.append(str);
                echo.render();
                suc();

            } else {
                //无数据时
                err();
            }
        })
    }
);

var $body = $('body');

var h = $body.height();
$(".content").css({'height':h*2/5,'overflow':'hidden'});

$('.unfold-btn').on('click',function(){
    $(".content").css('height','auto');
    $(this).hide()
});

$('.fbBtn').click(function (event) {
    event.stopPropagation();
    var offset = $(event.target).offset();
    $('.sendBox').css({ bottom: offset.bottom + $(event.target).height() + "px"});
    $('.sendBox').slideDown(200);
    $('.mui-backdrop').fadeIn(50);
    $body.css('position','fixed')
});
$('.mui-backdrop,.cancelBtn,.cancelShare').click(function () {
    $('.sendBox').slideUp(100);
    $('#shareBox').slideUp(100);
    $('.mui-backdrop').fadeOut(200);
    $body.css('position','relative')
});

$('.sendBtn').click(function(){
    if($('.textarea').val()==''){
        $toast('请输入内容');
    }else{
        $body.css('position','relative');
        $('.sendBox').slideUp(100);
        $('.mui-backdrop').fadeOut(200);
        $('.textarea').val('');
        $toast('发表成功')
    }
});

$('.addIcon').click(function(){
    var $this = $(this);
    if($this.find('i').hasClass('icon-favorite')){
        $this.find('i').removeClass('icon-favorite').addClass('icon-noFav1 text-warnning')
    }else{
        $this.find('i').addClass('icon-favorite').removeClass('icon-noFav1 text-warnning')
    }

});

$('.shareIcon').click(function(event){
    event.stopPropagation();
    var offset = $(event.target).offset();
    $('#shareBox').css({ bottom: offset.bottom + $(event.target).height() + "px"});
    $('#shareBox').slideDown(200);
    $('.mui-backdrop').fadeIn(50);
    $body.css('position','fixed')
});

