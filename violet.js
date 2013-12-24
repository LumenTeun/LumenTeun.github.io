function repositionContent(){
    $('h1').css({"margin-top": window.innerHeight/3});
}
$(document).ready(function(){
    repositionContent();
});

$(window).resize(function(){
    repositionContent();
});
