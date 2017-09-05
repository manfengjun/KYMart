//gotoTop();
$(document).on('click','.zan',function(){
    if($(this).find('i').hasClass('icon-zan2')){
        $(this).find('i').removeClass('icon-zan2').addClass('icon-praise text-warnning')
    }else{
        $(this).find('i').addClass('icon-zan2').removeClass('icon-praise text-warnning')
    }
});
var $body = $('body');
$(document).on('click','.reply',function (event) {
    var uname =$(this).parents('.comBox').find('.username').html();
    event.stopPropagation();
    var offset = $(event.target).offset();
    $('.sendBox').css({ bottom: offset.bottom + $(event.target).height() + "px"});
    $('.sendBox').slideDown(200);
    $('.mui-backdrop').fadeIn(50);
    $('.textarea').attr('placeholder','@'+uname+'');
    $body.css('position','fixed');
});

$('.sendBar').click(function (event) {
    event.stopPropagation();
    var offset = $(event.target).offset();
    $('.sendBox').css({ bottom: offset.bottom + $(event.target).height() + "px"});
    $('.sendBox').slideDown(200);
    $('.mui-backdrop').fadeIn(50);
    $body.css('position','fixed');
});

$('.mui-backdrop,.cancelBtn').click(function () {
    $('.sendBox').slideUp(100);
    $('.mui-backdrop').fadeOut(200);
    $('.textarea').attr('placeholder','');
    $body.css('position','relative');
});

$('.sendBtn').click(function(){
    if($('.textarea').val()==''){
        $toast('请输入内容');
    }else{
        $('.sendBox').slideUp(100);
        $('.mui-backdrop').fadeOut(200);
        $('.textarea').val('');
        $('.textarea').attr('placeholder','');
        $toast('发表成功！');
        $body.css('position','relative');
    }
});



$('.jubBtn').click(function(){
    layer.open({
        content: '<div class="report-content">' +
        '<div class="report-option">' +
        ' <input type="radio" name="report" id="radio-forbidden" value="0">' +
        ' <label for="radio-forbidden">淫秽色情</label>' +
        ' </div>' +
        ' <div class="report-option">' +
        ' <input type="radio" name="report" id="radio-market" value="0">' +
        ' <label for="radio-market">营销广告</label>' +
        ' </div> ' +
        '<div class="report-option">' +
        ' <input type="radio" name="report" id="radio-hostile" value="0">' +
        ' <label for="radio-hostile">恶意攻击谩骂</label>' +
        ' </div> ' +
        '<div class="report-option" onclick="showText()">' +
        ' <input type="radio" name="report" id="radio-complain" value="0">' +
        ' <label for="radio-complain">我有话要说</label> ' +
        '</div> ' +
        '<textarea name="complaintext" class="complain-text mui-hidden"></textarea>'+
        ' </div> ',
        title:[
            '举报此人',
            'background:#ff635c',
            'height:50px;',
            'line-height:50px;',
            'color:#ffffff'
        ],
        btn:['确定','取消'],
        shadeClose: false,
        yes: function(){
            var c = $('.complain-text').val();
            if($('.complain-text').hasClass('mui-block')&&!c){
                $toast('请选择投诉原因！')
            }else{
                $toast('投诉成功！')
            }
        },
        no: function(){
            layer.close();
        }
    });
});

function showText(){
    if($('#radio-complain').parents('.report-option').next('.complain-text').hasClass('mui-hidden')){
        $('.complain-text').removeClass('mui-hidden').addClass('mui-block');
        $('#radio-complain').attr('checked','checked')
    }else{
        $('.complain-text').addClass('mui-hidden').removeClass('mui-block');
        $('#radio-complain').attr('checked',false)
    }
}


