
    function $back(){
        history.go(-1);
    }

    //获取验证码
    function time(el){
        var wait=60;
        document.getElementById(el).disabled = false;
        function time(o) {
            if (wait == 0) {
                o.removeAttribute("disabled");
                o.innerHTML="获取验证码";
                wait = 60;
            } else {
                o.setAttribute("disabled", true);
                o.innerHTML="重新发送(" + wait + "s)";
                wait--;
                setTimeout(function() {
                    time(o);
                },1000);
            }
        }
        document.getElementById(el).onclick=function(){time(this);};
    }

    /**
     * 吐丝
     * @param str string 提示的内容
     */
    function $toast(str) {
        layer.open({
            content: str,
            time: 2,
            skin: 'msg',
            style:'padding:5px 30px!important;'
        });
    }

    /**
     * 成功加对号吐丝效果
     */
    function successToast(str){
        layer.open({
            content: '<i class="iconfont icon-chenggong text-ll-lg m-b-sm"></i><span class="m-t mui-block">'+str+'</span>',
            style:'background-color:rgba(30,30,30,0.8); width:auto; color:#fff!important; border:none;',
            shade:false,
            time: 2
        });
    }

    /**
     * 询问对话框
     * @param title string 提示内容
     * @param func1 function 第二个按钮的回调函数
     * @param func2 function 第一个个按钮的回调函数
     * @param btn array 按钮文字
     */
    function confirm(title,func1,func2,btn) {
        btn=btn||['确认', '取消'];
        func2=func2|| function () { };
        layer.open({
            content: title,
            title:[
                '提示',
                'background:#f85959',
                'height:50px;',
                'line-height:50px;',
                'color:#ffffff'
            ],
            btn:btn,
            shadeClose: false,
            yes: func1,
            no: function(){
                func2();
                layer.close();
            }
        });
    }

    function noData(el,str){
        var $div = '<div class="noData">'+str+'</div>';
        $(el).html($div);
    }

    function noDataPs(el,str){
        var $div = '<div class="noDataPs">'+str+'</div>';
        $(el).html($div);
    }

    function $post(url,param,success){
        $.post(url, param,function(data){
            success(data);
        },'json');
    }

    function $get(url,param,success){
        //var surl=url.replace(/^(\/)|(\/)$/g,'');
        $.get(url,param,function(data){
            success(data);
        },'json');
    }


    /**
     * 上拉加载
     */
    function upLoad(obj,dropDown,callback){
        var $doc = $(document);
        dropDown.html('上拉加载更多');
        //执行上拉加载
        obj.scroll(function(){
            var tag=true;
            //加载完成
            var suc=function(){
                dropDown.html('加载完成');
            };
            //没有数据了
            var err=function(){
                tag=false;
                dropDown.html('已经到底了');
            };
            //加载中
            var loading= function () {
                dropDown.html('正在加载中...');
            };
            if($doc.scrollTop() + $(window).height() >= $doc.height() && tag){
                //正在加载
                loading();
                //回调函数
                callback(suc,err);
            }
        })
    }


    //回到顶部
    function gotoTop(min_height){
        //预定义返回顶部的html代码，它的css样式默认为不显示
        var gotoTop_html = '<div id="gotoTop"><a href="javascript:;"><i class="mui-icon mui-icon-arrowup mui-block"></i>顶部</a> </div>';
        //将返回顶部的html代码插入页面上id为page的元素的末尾
        $("body").append(gotoTop_html);
        $("#gotoTop").click(//定义返回顶部点击向上滚动的动画
            function(){$('html,body').animate({scrollTop:0},700);
            }).hover(//为返回顶部增加鼠标进入的反馈效果，用添加删除css类实现
            function(){$(this).addClass("hover");},
            function(){$(this).removeClass("hover");
            });
        //获取页面的最小高度，无传入值则默认为600像素
        min_height = $(window).height();
        //为窗口的scroll事件绑定处理函数
        $(window).scroll(function(){
            //获取窗口的滚动条的垂直位置
            var s = $(window).scrollTop();
            //当窗口的滚动条的垂直位置大于页面的最小高度时，让返回顶部元素渐现，否则渐隐
            if( s > min_height){
                $("#gotoTop").fadeIn(100);
            }else{
                $("#gotoTop").fadeOut(200);
            }
        });
    }

    /**
     * 侧边栏
     * obj  object 触发侧边栏的按钮
     */
    function aside(obj){
        //变量选取
        var $aside = $("aside"),
            $sidebar = $(".sidebar"),
            $muiWrap = $(".mui-inner-wrap"),
            $muiBar = $(".mui-bar"),
            $muiBarTab = $(".mui-bar-tab"),
            $menu = $(".leftMenu"),
            $wrapper = $(".wrapper");

        //侧边栏
        obj.click(function(){
            $sidebar.show('fast');
            $aside.addClass("active");
            $muiWrap.removeClass("back").addClass("go");
            $muiBarTab.removeClass("back").addClass("go");
            $muiBar.addClass("go");
            $menu.addClass("go");
            $wrapper.addClass("active");
        });
        $sidebar.click(function(){
            $muiWrap.removeClass("go").addClass("back");
            $muiBarTab.removeClass("go").addClass("back");
            $sidebar.hide();
            setTimeout(function(){
                $aside.removeClass("active");
                $wrapper.removeClass("active");
                $muiBar.removeClass("go");
                $menu.removeClass("go");
                $muiWrap.css({"min-height":$(window).height(),"background":'#efeff4'});
            },500)
        })
    }

    $('.myLeftMenu .mui-collapse').on('tap','a',function(){
        location.href=this.getAttribute('href');
    });