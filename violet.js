function repositionContent(){
    $('#content').css({"margin-top": window.innerHeight/2.5});
}

$(document).ready(function(){
    repositionContent();
});

$(window).resize(function(){
    repositionContent();
});
