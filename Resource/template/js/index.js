gotoTop();

echo.init({
    offset: 0,
    throttle: 0
});

aside($(".leftMenu"));

var $tabNav = $('.tabNav');

//获取变量
var $itemul1 = $("#item1").find('.list'),
    $itemul2 = $("#item2").find('.list'),
    $dropDown1 = $itemul1.siblings(".dropDown").find("p"),
    $dropDown2 = $itemul2.siblings(".dropDown").find("p"),
    $doc = $(document);
//全部
var parFirst={
    page:0,
    count:4
};
$get("data/list.json",parFirst,function(data){
    if(data.status){
        //有数据时
        var dataObj = data.info;
        var str='';
        for(var i = 0; i<dataObj.length;i++){
            str += template("list1",dataObj[i]);
        }
        $itemul1.append(str);
        echo.render();
        if($(".mui-content").innerHeight() < $(window).height()){
            $(".mui-content").css("minHeight",$(window).height()+1);
        }
    }else{
        //无数据时
        $dropDown1.parent().hide();
        noData($itemul1,'暂时没有发表的内容');
    }
});
upLoad(
    $doc,
    $dropDown1,
    function(suc,err){
        if($tabNav.find(".mui-active").hasClass("first")) {
            parFirst.page++;
            $get('data/list.json', parFirst, function (data) {
                if (data.status) {
                    //有数据时
                    var dataObj = data.info;
                    var str = '';
                    for (var i = 0; i < dataObj.length; i++) {
                        str += template("list1", dataObj[i]);
                    }
                    $itemul1.append(str);
                    echo.render();
                    suc();

                } else {
                    //无数据时
                    err();
                }
            })
        }
    }
);

var parSecond={
    page:0,
    count:6
};
$get("data/list.json",parSecond,function(data){
    if(data.status){
        //有数据时
        var dataObj = data.info;
        var str='';
        for(var i = 0; i<dataObj.length;i++){
            str += template("list2",dataObj[i]);
        }
        $itemul2.append(str);
        echo.render();
        if($(".mui-content").innerHeight() < $(window).height()){
            $(".mui-content").css("minHeight",$(window).height()+1);
        }
    }else{
        //无数据时
        $dropDown2.parent().hide();
        noData($itemul2,'暂时没有发表的内容');
    }
});
upLoad(
    $doc,
    $dropDown2,
    function(suc,err){
        if($tabNav.find(".mui-active").hasClass("second")) {
            parSecond.page++;
            $get('data/list.json', parSecond, function (data) {
                if (data.status) {
                    //有数据时
                    var dataObj = data.info;
                    var str = '';
                    for (var i = 0; i < dataObj.length; i++) {
                        str += template("list2", dataObj[i]);
                    }
                    $itemul2.append(str);
                    suc();

                } else {
                    //无数据时
                    err();
                }
            })
        }
    }
);


