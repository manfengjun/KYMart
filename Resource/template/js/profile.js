$('.mui-bar-tab').on('tap','a',function(){
    window.location.href=this.href;
});

function showBox(el){
    $('.'+el).click(function (event) {
        var text = $(this).find('span').text();
        event.stopPropagation();
        var offset = $(event.target).offset();
        $('#'+el).css({ bottom: offset.bottom + $(event.target).height() + "px"});
        $('#'+el).find('.textarea').val(text);
        $('#'+el).slideDown(100);
        $('.mui-backdrop').fadeIn(50);
    });
}

$('.mui-backdrop,.cancelBtn').click(function () {
    $('.sendBox').slideUp(50);
    $('.mui-backdrop').fadeOut(200);
});

function send(el){
    $('#'+el).on('click','.sendBtn',function(){
        var $this = $(this);
        var text = $this.parents('.sendBox').find('.textarea').val();
        if(text==''){
            $toast('<span class="text-sm">请输入内容</span>')
        }else{
            $this.parents('.sendBox').slideUp(50);
            $('.'+el).find('span').html(text);
            $('.mui-backdrop').fadeOut(200);
            $toast('<span class="text-sm">已保存</span>')
        }
    });
}

showBox('nickname');
showBox('intro');
send('nickname');
send('intro');

$('#nickname .words').text($(".nickname span").text().length);
$('#intro .words').text($(".intro span").text().length);

$("#nickname .textarea").keyup(function(){
    var len = $(this).val().length;
    if(len > 0){
        $(this).val($(this).val().substring(15,0));
    }
    var num = 0 + len;
    $(this).next('.btnGroup').find(".words").text(num);
});
$("#intro .textarea").keyup(function(){
    var len = $(this).val().length;
    if(len > 0){
        $(this).val($(this).val().substring(40,0));
    }
    var num = 0 + len;
    $(this).next('.btnGroup').find(".words").text(num);
});