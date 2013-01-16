function validarFechaInicioEmpresa(dateText, inst) {
    var id = inst.id;
    var parts;
    parts = dateText.split("/");
    if(id == "txtFechaInicioEmpresa") {
	$('#txtFechaFinEmpresa').datepicker('option', 'minDate', new Date(parts[2], (parts[1] - 1), (parts[0])));
    } 
}

function validarFechaCargas(dateText, inst) {
    var id = inst.id;
    var parts;
    parts = dateText.split("/");
    if(id == "fechaNacimiento") {
	$('#fechaFin').datepicker('option', 'minDate', new Date(parts[2], (parts[1] - 1), (parts[0])));
    }
}

function validarFechaBienes(dateText, inst) {
    var id = inst.id;
    var parts;
    parts = dateText.split("/");
    if(id == "fechaInicio") {
	$('#fechaFin').datepicker('option', 'minDate', new Date(parts[2], (parts[1] - 1), (parts[0])));
    }
}

function validarFechaEmpleos(dateText, inst) {
    var id = inst.id;
    var parts;
    parts = dateText.split("/");
    if(id == "fechaInicio") {
	$('#fechaFin').datepicker('option', 'minDate', new Date(parts[2], (parts[1] - 1), (parts[0])));
    }
}

$(function(){

    try {
	$(".empresa").validate({
	    rules: {
		"fechaFin": {
		    after: "fechaInicio"
		}
	    },
	    messages: {
		"fechaFin": {
		    after: "Ingrese una fecha posterior a la fecha de inicio"
		}
	    }
	});

	$(".carga").validate({
	    rules: {
		"fechaFin": {
		    after: "fechaNacimiento"
		}
	    },
	    messages: {
		"fechaFin": {
		    after: "Ingrese una fecha posterior a la fecha de nacimiento"
		}
	    }
	});

	$(".bien").validate({
	    rules: {
		"fechaFin": {
		    after: "fechaInicio"
		}
	    },
	    messages: {
		"fechaFin": {
		    after: "Ingrese una fecha posterior a la fecha de inicio"
		}
	    }
	});

	$(".empleado").validate();

	$(".persona").validate();

    } catch(e) {}

    $("#personaSiguiente").click(function(){
	$(".persona").submit();
    });
    $("#empresaSiguiente").click(function(){
	$(".empresa").submit();
    });
    $("#agregarCargas").click(function(){
	$(".carga").submit();
    });
    $("#agregarEmpleado").click(function(){
	$(".empleado").submit();
    });
    $("#agregarBienes").click(function(){
	$(".bien").submit();
    });
    $("#agregarHipoteca").click(function(){
	$(".hipoteca").submit();
    });
    $("#eliminarCargas").click(function(){
        $(".eliminar").val($(".eliminar").val()*1+1)
	$(".eliminar").submit();
    });
    $("#eliminarBienes").click(function(){
        $(".eliminar").val($(".eliminar").val()*1+1)
	$(".eliminar").submit();
    });
    $("#eliminarEmpleos").click(function(){
        $(".eliminar").val($(".eliminar").val()*1+1)
	$(".eliminar").submit();
    });
    $(".chkborrar").change(function(){

        var act = $("#num_eliminar").val()*1;
        var checked = $(this).is(":checked");
        if(checked) {
            $("#num_eliminar").val(act+0.5);
        }else{
           $("#num_eliminar").val(act-0.5);
        }
    });

    ////////////////////////////////////////////////////////////////////guardar//////////////////////////////////////////
    function editar() {
	var val, txt, id, opts;
	// Los textfields y datepickers
	$(".txt, .dp").each(function() {
	    if($(this).hasClass("dp"))
		clase = "datepicker";
	    else
		clase = "";
	    id = $(this).attr("id");
	    val = trim($(this).text());
	    if(val == "-") val = "";
	    txt = "<input type='text' class='"+clase+" span-5 ui-widget-content ui-corner-all' id='txt_"+id+"' name='txt_"+id+"' value='"+val+"' />";
	    $(this).html(txt);
	});
	// Los textareas
	$(".txa").each(function() {
	    id = $(this).attr("id");
	    val = trim($(this).text());
	    if(val == "-") val = "";
	    txt = "<textarea class='span-5 ui-widget-content ui-corner-all textarea' id='txt_"+id+"' name='txt_"+id+"'>"+val+"</textarea>";
	    $(this).html(txt);
	});
	// Los g:selects
	$(".sel").each(function() {
	    id = $(this).attr("id");
	    val = $(this).attr("value");
	    $("#"+id+"_show").hide();
	    $("#"+id+"_edit").show();
	    $("#cmb_"+id).val(val);
	});
	// Los selects
	$(".cmb").each(function() {
	    id = $(this).attr("id");
	    val = $(this).attr("value");
	    opts = $(this).attr("opts");
	    opts = opts.split(",");
	    txt = "<select id=cmb_"+id+" name=cmb_"+id+" class='span-5 ui-widget-content ui-corner-all' >";
	    for(i = 0; i < opts.length; i++) {
		opt = opts[i].split("-");
		if(val == opt[0])
		    sel = "selected";
		else
		    sel = "";
		txt+= "<option value='"+opt[0]+"' "+sel+">"+opt[1]+"</option>";
	    }
	    txt+= "</select>";
	    $(this).html(txt);
	});
	// Los checkboxes
	$(".chk").each(function() {
	    id = $(this).attr("id");
	    val = trim($(this).text());
	    opts = $(this).attr("opts");
	    parts = opts.split(",");
	    opt1 = parts[0].split("-");
	    opt2 = parts[1].split("-");
	    if(val == opt1[1])
		chk = "checked";
	    else
		chk = "";
	    txt = "<input type='checkbox' id='chk_"+id+"' name='chk_"+id+"' value='"+opt1[0]+"' "+chk+" />";
	    $(this).html(txt);
	});
	try {
	    $(".datepicker").datepicker({
		dateFormat: 'dd/mm/yy',
		changeYear: true,
		changeMonth: true,
		maxDate: "+0D",
		yearRange:"-50:+10"
	    });
	} catch(ex){}
    }

    function noEditar() {
	var val, txt, id;
	// Los textfields y datepickers
	$(".txt, .dp").each(function() {
	    id = $(this).attr("id");
	    val = trim($("#txt_"+id).val());
	    if(val == "") val = "-";
	    $(this).html(val);
	});
	//los textareas
	$(".txa").each(function() {
	    id = $(this).attr("id");
	    val = trim($("#txt_"+id).val());
	    if(val == "") val = "-";
	    $(this).html(val);
	});
	// Los g:selects
	$(".sel").each(function() {
	    id = $(this).attr("id");
	    val = $("#cmb_"+id+" option:selected").val();
	    txt = $("#cmb_"+id+" option:selected").text();

	    if(val == null)
		txt = "-";

	    $(this).attr("value",val);
	    $("#"+id+"_show").html(txt);

	    $("#"+id+"_edit").hide();
	    $("#"+id+"_show").show();
	});
	// Los selects
	$(".cmb").each(function() {
	    id = $(this).attr("id");
	    val = $("#cmb_"+id+" option:selected").val();
	    txt = $("#cmb_"+id+" option:selected").text();
	    $(this).attr("value",val);
	    $(this).html(txt);
	});
	// Los checkboxes
	$(".chk").each(function() {
	    id = $(this).attr("id");
	    val = trim($(this).text());
	    opts = $(this).attr("opts");
	    parts = opts.split(",");
	    opt1 = parts[0].split("-");
	    opt2 = parts[1].split("-");

	    sel = $("#chk_"+id).is(":checked");

	    if(sel)
		txt = opt1[1];
	    else
		txt = opt2[1];
	    $(this).html(txt);
	});
    }

    try {
	$(".ver").validate({
	    rules: {
		"nombre": {
		    required: true,
		    maxlength: 40,
		    letters: true
		},
		"apellido": {
		    required: true,
		    maxlength: 40,
		    letters: true
		},
		"ruc": {
		    required: true,
		    letters:true,
		    ruc: true
		},
		"objeto": {
		    required: false,
		    maxlength: 127,
		    noSpecial: true
		},
		"direccion": {
		    required: false,
		    maxlength: 127,
		    noSpecial: true
		},
		"telefono": {
		    required: false,
		    telefono: true
		},
		"fax": {
		    required: false,
		    telefono: true
		},
		"email": {
		    required: false,
		    email: true
		},
		"fechaInicio": {
		    required: false,
		    date: true
		}
	    }
	});

	$(".verCliente").validate({
	    rules: {
		"nombre": {
		    required: true,
		    maxlength: 40,
		    letters: true
		},
		"apellido": {
		    required: true,
		    maxlength: 40,
		    letters: true
		},
		"cedula": {
		    required: true,
		    letters:true,
		    ruc: true
		},
		"fechaNacimiento": {
		    required: false,
		    date: true
		},
		"cmb_nacionalidad": {
		    required: true,
		    requiredCmb: true
		},
		"direccion": {
		    required: false,
		    maxlength: 127,
		    noSpecial: true
		},
		"referencia": {
		    required: false,
		    maxlength: 127,
		    noSpecial: true
		},
		"barrio": {
		    required: false,
		    maxlength: 127,
		    noSpecial: true
		},
		"telefono": {
		    required: false,
		    telefono: true
		},
		"fax": {
		    required: false,
		    telefono: true
		},
		"email": {
		    required: false,
		    email: true
		}
	    }
	});
    }catch(e) {}

    $(".btnEditar").click(function() {
	var desc = $(this).attr("desc");
	var id = $(this).attr("id");

	if(desc == "Editar") {
	    $(this).attr("desc","Guardar");
	    $("#spimg_"+id).removeClass("ui-icon-pencil");
	    $("#spimg_"+id).addClass("ui-icon-disk");
	    $("#sp_"+id).html("Guardar");
	    editar();
	} else {
	    $(this).attr("desc","Editar");
	    $("#spimg_"+id).removeClass("ui-icon-disk");
	    $("#spimg_"+id).addClass("ui-icon-pencil");
	    $("#sp_"+id).html("Editar");
	    $("."+id).submit();
	}
    });
});


