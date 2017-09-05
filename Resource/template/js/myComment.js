
//获取变量
var $list = $('.commentUl'),
    $dropDown = $(".dropDown").find("p"),
    $doc = $(document);
//全部
var par={
    page:0,
    count:4
};
$get("data/data.json",par,function(data){
    if(data.status){
        //有数据时
        var dataObj = data.info;
        var str='';
        for(var i = 0; i<dataObj.length;i++){
            str += template("list",dataObj[i]);
        }
        $list.append(str);
        if($(".mui-content").innerHeight() < $(window).height()){
            $(".mui-content").css("minHeight",$(window).height()+1);
        }
    }else{
        //无数据时
        $dropDown.parent().hide();
        noDataPs('.mui-content','暂无评论');
    }
});
upLoad(
    $doc,
    $dropDown,
    function(suc,err){
        par.page++;
        $get('data/data.json', par, function (data) {
            if (data.status) {
                //有数据时
                var dataObj = data.info;
                var str = '';
                for (var i = 0; i < dataObj.length; i++) {
                    str += template("list", dataObj[i]);
                }
                $list.append(str);
                suc();

            } else {
                //无数据时
                err();
            }
        })
    }
);

$doc.on('click','.icon-shanchu1',function(){
    var $this = $(this);
    $this.parents('li').next('.line').addClass('delLine');
    confirm('确定删除此评论吗？',function(){
        $this.parents('li').remove();
        $('.delLine').remove();
        $toast('已删除');
        if($('li').length<=0){
            noDataPs('.mui-content','<i class="iconfont icon-anzhuo mui-block"></i>暂无评论');
        }
    })
});