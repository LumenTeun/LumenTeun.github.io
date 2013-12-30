function repositionContent(){
    $('#content').css({"top": window.innerHeight/2 - $('#info').height() / 2 - $('h1').height()});
}

$(document).ready(function(){
    repositionContent();
});

$(window).resize(function(){
    repositionContent();
});
