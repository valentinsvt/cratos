(function(){
    //all hover and click logic for buttons
    $(".fg-button:not(.ui-state-disabled)").livequery(function() {
	$(this).hover(
	    function(){
		$(this).addClass("ui-state-hover");
	    },
	    function(){
		$(this).removeClass("ui-state-hover");
	    })
	.mousedown(function(){
	    $(this).parents('.fg-buttonset-single:first').find(".fg-button.ui-state-active").removeClass("ui-state-active");
	    if( $(this).is('.ui-state-active.fg-button-toggleable, .fg-buttonset-multi .ui-state-active') ){
		$(this).removeClass("ui-state-active");
	    }
	    else {
		$(this).addClass("ui-state-active");
	    }
	})
	.mouseup(function(){
	    if(! $(this).is('.fg-button-toggleable, .fg-buttonset-single .fg-button,  .fg-buttonset-multi .fg-button') ){
		$(this).removeClass("ui-state-active");
	    }
	});
    });

    $(".hover").livequery(function() {
	$(".hover tr").hover(
	    function(){
		$(this).addClass("ui-state-hover");
	    },
	    function(){
		$(this).removeClass("ui-state-hover");
	    });
    });

//    $(".cedula").mask("9999999999");
//    $(".ruc").mask("9999999999999");
//    $(".date").mask("99/99/9999");
//    $(".telefono").mask("99-9999999");

  
});
