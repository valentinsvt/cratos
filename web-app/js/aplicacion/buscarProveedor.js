$(function() {

    $(".frmBuscarPro").submit(function() {
	return false;
    });

    $("#txtBusca").bind('keyup',function(event){

	// the keycode for the key evoking the event
	var keyCode = event.which;

	// 8 Backspace, 13 Enter
	// 37 Left Arrow, 38 Up Arrow, 39 Right Arrow, 40 Down Arrow
	// 9 Tab, 16 Shift, 17 Ctrl, 18 Alt, 19 Pause Break, 20 Caps Lock
	// 27 Esc, 33 Page Up, 34 Page Down, 35 End, 36 Home
	// 37 Left Arrow, 38 Up Arrow, 39 Right Arrow, 40 Down Arrow
	// 45 Insert, 46 Forward Delete, 144 Num Lock, 145 Scroll Lock
	//
	// 48-57 Standard Keyboard Numbers
	// 96-105 Extended Keyboard Numbers (aka Keypad)

	if ( keyCode == 13) {
	    //	    alert("ENTER");
	    //$("#divWtf").html("ENTER");
	    enviar();
	}

	if($(this).val().length >= 0 && $("#error").parent().is(":visible")) {
	    $("#error").html("").parent().hide("slide");
	}
    });
 $("#btnCancelarPersona").livequery(function(){
        $(this).click(function() {
            $.ajax({
                type: "POST",
                url: "../verProveedor2",
                data: "id="+$("#id").val(),
                success: function(msg){
                    $("#datosPersonales").html(msg);
                }
            });
        });
    });


    $("#buscarProveedor").click(function() {
	var busca = $("#txtBusca").val();
	if(trim(busca) == "") {
	    $("#error").html("Escriba su b&uacute;squeda para continuar").parent().show("slide");
	} else {
	    //$("form:eq(0)").submit();
	    enviar();
	}
    });

    function enviar() {
	$.ajax({
	    type: "POST",
	    url: "buscarProveedor",
	    data: $(".frmBuscarPro").serialize(),
	    success: function(msg){
		$("#divListaProveedor").html(msg).show("slide");
		tablas();
	    }
	});
    }

    function tablas(tabla) {
	if(tabla == null)
	    tabla = ".table";
	try {
	    $(tabla).dataTable( {
		"bPaginate": true,
		"sPaginationType": "full_numbers",
		"bLengthChange": false,
		"bSort": true,
		"bFilter": false,
		"bInfo": true
	    } );


	    $('.hover tr').livequery(function() {
		$(this).hover(
		    function(){
			$(this).addClass("ui-state-hover");
		    },
		    function(){
			$(this).removeClass("ui-state-hover");
		    }
		    );
	    });
	} catch(ex) {}
    }
});
