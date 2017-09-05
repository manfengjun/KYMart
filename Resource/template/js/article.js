var bridge

// 图片点击事件
function didTappedImage(index, url) {
    var image = document.getElementById(url);
    var width = image.width;
    var height = image.height;
    var x = image.getBoundingClientRect().left;
    var y = image.getBoundingClientRect().top;
    x = x + document.documentElement.scrollLeft;
    y = y + document.documentElement.scrollTop;
    
    bridge.send({
                'index': index,
                'x': x,
                'y': y,
                'width': width,
                'height': height,
                'url': url
                });
}

// 设置字体
function setFontName(name) {
    var content = document.getElementById('content');
    content.style.fontFamily = name;
}

// 设置字体大小
function setFontSize(size) {
    var content = document.getElementById('content');
    content.style.fontSize = size + "px";
}

// 获取网页高度
function getHtmlHeight() {
    return document.body.offsetHeight;
}

function setupWebViewJavascriptBridge(callback) {
    if(window.WebViewJavascriptBridge) {
        return callback(WebViewJavascriptBridge);
    }
    if(window.WVJBCallbacks) {
        return window.WVJBCallbacks.push(callback);
    }
    window.WVJBCallbacks = [callback];
    var WVJBIframe = document.createElement('iframe');
    WVJBIframe.style.display = 'none';
    WVJBIframe.src = 'https://__bridge_loaded__';
    document.documentElement.appendChild(WVJBIframe);
    setTimeout(function() {
               document.documentElement.removeChild(WVJBIframe)
               }, 0)
}
setupWebViewJavascriptBridge(function(bridge) {
                             
                             /* Initialize your app here */
                             
                             bridge.registerHandler('ReplaceImage', function(data, responseCallback) {
                                                    if(data.match("replaceimage")) {
                                                    
                                                    var index = data.indexOf("~");
                                                    // 截取占位标识
                                                    var messagereplace = data.substring(0, index);
                                                    // 截取到图片路径
                                                    var messagepath = data.substring(index + 1);
                                                    messagereplace = messagereplace.replace(/replaceimage/, "");
                                                    
                                                    element = document.getElementById(messagereplace);
                                                    
                                                    // 保证只替换一次
                                                    if(element.src.match("load")) {
                                                    element.src = messagepath;
                                                    }
                                                    }
                                                    responseCallback(element.src)
                                                    })
                             
                             })
