function repositionContent(){
    $('#top').css({ "height": window.innerHeight/2.5});
    $('#me').css({ "height": window.innerHeight/3, "top": window.innerHeight/24 });
    $('#info').css({ "top": window.innerHeight/5 });
}

$(document).ready(function(){
    repositionContent();
});

$(window).resize(function(){
    repositionContent();
});
