
function setuplazy(){
    trylazy();
    $(window).scroll(function(){
        trylazy();

    });


};

function trylazy(){
    $(".lazy-partial:not(.loading)").each(function(){
        var el = $(this);
        var top = this.getBoundingClientRect().top;

        if(top <= $(window).height()+200) {
            el.addClass("loading");
            $.ajax(el.data("lazy-url"),
                {
                    success: function (html) {
                        h = $(html);
                        var newel = el.replaceWith(h);

                        $("img.deferred_img").removeClass("deferred_img").lazyload();


                    }
                });
        }
    });
}