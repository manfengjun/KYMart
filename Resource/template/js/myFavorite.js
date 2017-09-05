gotoTop();
echo.init({
    offset: 0,
    throttle: 0
});

//获取变量
var $list = $(".list"),
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
        noDataPs('.mui-content','<span class="mui-block iconfont icon-scj"></span>暂无收藏的文章');
        $('.mui-btn-link').remove()
    }
});
//upLoad(
//    $doc,
//    $dropDown,
//    function(suc,err){
//        par.page++;
//        $get('data/list.json', par, function (data) {
//            if (data.status) {
//                //有数据时
//                var dataObj = data.info;
//                var str = '';
//                for (var i = 0; i < dataObj.length; i++) {
//                    str += template("list", dataObj[i]);
//                }
//                $list.append(str);
//                echo.render();
//                delShow();
//                suc();
//
//            } else {
//                //无数据时
//                err();
//            }
//        })
//    }
//);

$('.mui-btn-link').on('click',function(){
    $list.find('.favDel').show();
});
$doc.on('click','.favDel',function(){
    var $this = $(this);
    confirm('确定要删除吗？',function(){
        $get('data/data.json',function(data){
            if(data.status){
                $this.parents('section').remove();
                $toast('已删除');
                if($('section').length<=0){
                    noDataPs('.mui-content','<span class="mui-block iconfont icon-scj"></span>暂无收藏的文章');
                    $('.mui-btn-link').remove()
                }
            }
        })
    },function(){})
});


