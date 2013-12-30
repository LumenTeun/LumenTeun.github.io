function repositionContent(){
    $('#content').css({"top": window.innerHeight/2 - $('#content').height() / 2});
}

$(document).ready(function(){
    repositionContent();
});

$(window).resize(function(){
    repositionContent();
});
