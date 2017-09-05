
var $tabNav = $('.tabNav');

//获取变量
var $itemul1 = $("#item1").find('.commentUl'),
    $itemul2 = $("#item2").find('.commentUl'),
    $itemul3 = $("#item3").find('.commentUl'),
    $dropDown1 = $itemul1.siblings(".dropDown").find("p"),
    $dropDown2 = $itemul2.siblings(".dropDown").find("p"),
    $dropDown3 = $itemul3.siblings(".dropDown").find("p"),
    $doc = $(document);
//全部
var parFirst={
    page:0,
    count:4
};
$get("data/data.json",parFirst,function(data){
    if(data.status){
        //有数据时
        var dataObj = data.info;
        var str='';
        for(var i = 0; i<dataObj.length;i++){
            str += template("list1",dataObj[i]);
        }
        $itemul1.append(str);
        if($(".mui-content").innerHeight() < $(window).height()){
            $(".mui-content").css("minHeight",$(window).height()+1);
        }
    }else{
        //无数据时
        $dropDown1.parent().hide();
        noData($itemul1,'暂无评论');
    }
});
upLoad(
    $doc,
    $dropDown1,
    function(suc,err){
        if($tabNav.find(".mui-active").hasClass("first")) {
            parFirst.page++;
            $get('data/data.json', parFirst, function (data) {
                if (data.status) {
                    //有数据时
                    var dataObj = data.info;
                    var str = '';
                    for (var i = 0; i < dataObj.length; i++) {
                        str += template("list1", dataObj[i]);
                    }
                    $itemul1.append(str);
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
$get("data/data.json",parSecond,function(data){
    if(data.status){
        //有数据时
        var dataObj = data.info;
        var str='';
        for(var i = 0; i<dataObj.length;i++){
            str += template("list2",dataObj[i]);
        }
        $itemul2.append(str);
        if($(".mui-content").innerHeight() < $(window).height()){
            $(".mui-content").css("minHeight",$(window).height()+1);
        }
    }else{
        //无数据时
        $dropDown2.parent().hide();
        noData($itemul2,'暂无消息');
    }
});
upLoad(
    $doc,
    $dropDown2,
    function(suc,err){
        if($tabNav.find(".mui-active").hasClass("second")) {
            parSecond.page++;
            $get('data/data.json', parSecond, function (data) {
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

var parThird={
    page:0,
    count:6
};
$get("data/data.json",parThird,function(data){
    if(data.status){
        //有数据时
        var dataObj = data.info;
        var str='';
        for(var i = 0; i<dataObj.length;i++){
            str += template("list3",dataObj[i]);
        }
        $itemul3.append(str);
        if($(".mui-content").innerHeight() < $(window).height()){
            $(".mui-content").css("minHeight",$(window).height()+1);
        }
    }else{
        //无数据时
        $dropDown3.parent().hide();
        noData($itemul3,'暂无消息');
    }
});
upLoad(
    $doc,
    $dropDown3,
    function(suc,err){
        if($tabNav.find(".mui-active").hasClass("third")) {
            parThird.page++;
            $get('data/data.json', parThird, function (data) {
                if (data.status) {
                    //有数据时
                    var dataObj = data.info;
                    var str = '';
                    for (var i = 0; i < dataObj.length; i++) {
                        str += template("list3", dataObj[i]);
                    }
                    $itemul3.append(str);
                    suc();

                } else {
                    //无数据时
                    err();
                }
            })
        }
    }
);
