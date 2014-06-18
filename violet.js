function repositionContent(){
    //$('#content').css({"top": window.innerHeight/2 - $('#info').height() / 2 - $('h1').height()});
    $('#top').css({ "height": window.innerHeight/2 });
    $('#me').css({ "height": window.innerHeight/3, "margin-top": window.innerHeight/12 });
    $('#info').css({ "margin-top": window.innerHeight/12 });
}

$(document).ready(function(){
    repositionContent();
});

$(window).resize(function(){
    repositionContent();
});
