/**
 * Created by Administrator on 2016/3/28.
 */
$('#imgtag').click(function fn_browse()
{
    document.form1.image.click();
});

//图片上传预览  IE是用了滤镜。
$('#up_img').change(function () {
    previewImage(this,'imgdiv','imgshow','picDiv1');
});
function previewImage(file,pre,imag,imgDiv)
{
    var MAXWIDTH  = 200;
    var MAXHEIGHT = 200;
    var div = document.getElementById(pre);
    if( !file.value.match( /.jpg|.gif|.png|.bmp/i ) ){
        $('#'+pre).next('span').css({"color":"red","font-weight":"bold"}).text('图片类型无效！');
        return false;
    }else{
        $('#'+pre).next('span').css({"color":"green","font-weight":"bold"}).text('图片类型符合！');
    }
    if (file.files && file.files[0])
    {
        div.innerHTML ='<img id='+imag+'>';
        var img = document.getElementById(imag);
        var reader = new FileReader();
        reader.onload = function(evt){img.src = evt.target.result;img.style.width='32px';img.style.height='32px';img.style.borderRadius='100%';img.style.MozBorderRadius='100%'}
        reader.readAsDataURL(file.files[0]);
    }
    else //兼容IE
    {
        var sFilter='filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
        file.select();
        $("#"+imgDiv).focus();
        //file.focus();
        var src = document.selection.createRange().text;

        div.innerHTML ='<img style=" filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);width:32px;height:32px;border-radius:30px;-moz-border-radius:100%;-webkit-border-radius:100%;"  id='+imag+'>';
        var img = document.getElementById(imag);
        img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
        var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
        status =('rect:'+rect.top+','+rect.left+','+rect.width+','+rect.height);
    }
}
function clacImgZoomParam( maxWidth, maxHeight, width, height ){
    var param = {top:0, left:0, width:width, height:height};
    if( width>maxWidth || height>maxHeight )
    {
        rateWidth = width / maxWidth;
        rateHeight = height / maxHeight;

        if( rateWidth > rateHeight )
        {
            param.width =  maxWidth;
            param.height = Math.round(height / rateWidth);
        }else
        {
            param.width = Math.round(width / rateHeight);
            param.height = maxHeight;
        }
    }
    param.left = Math.round((maxWidth - param.width) / 2);
    param.top = Math.round((maxHeight - param.height) / 2);
    return param;
}

