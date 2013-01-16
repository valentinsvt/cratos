$(function() {
	
	var accnNombre = $("#buscar_accion_nombre"), control = $("#buscar_control"), allFields = $(
			[]).add(accnNombre).add(control), tips = $(".validateTips");
	
	function updateTips(t) {
		tips.text(t).addClass('ui-state-highlight');
		setTimeout(function() {
			tips.removeClass('ui-state-highlight', 1500);
		}, 500);
	}

	function checkLength(o, n, min, max) {
		
		if (o.val().length > max || o.val().length < min) {
			o.addClass('ui-state-error');
			updateTips("Length of " + n + " must be between " + min + " and "
					+ max + ".");
			return false;
		} else {
			return true;
		}

	}

	function checkRegexp(o, regexp, n) {
		if (trim(o.val()) == "") {
			return true;
		}
		if (!(regexp.test(o.val()))) {
			o.addClass('ui-state-error');
			updateTips(n);
			return false;
		} else {
			return true;
		}

	}

	$(".agregar").livequery(function() {
		$(this).hover(function() {
			$(this).addClass("ui-state-hover");
		}, function() {
			$(this).removeClass("ui-state-hover");
		});

		$(this).click(function() {
			var trId = $(this).attr("id");

			var id = trId.split("_");
			id = id[1];
			var cod = $("#" + trId + " > td:eq(0)").text();
			var nom = $("#" + trId + " > td:eq(1)").text();

			var txt = cod + ": " + nom;

			$("#txtBuscar").val(txt);
			//$("#txtIdCuenta").val(id);
			//$("#dialogBuscar").dialog("close");
		});
		
	});
	

	$("#dialogBuscar").livequery(function() {
		$(this).dialog( {
			autoOpen : false,
			modal : true,
			width : 500,
			position : 'top',

			close : function() {
				allFields.val('').removeClass('ui-state-error');				
				$("#buscar_resultados").html("").hide();
				$("#dialogBuscar").dialog("option", "height", "auto");
				tips.text("Buscar una cuenta");
			}
		});

	});

	$("#buscar_accion_nombre, #buscar_control").livequery(function() {
		$(this).bind('keyup', function(event) {
			var keyCode = event.which;

			if (keyCode == 13) {
				buscar();
			}
		});
	});

	$("#btnCancelar").livequery(function() {
		$(this).click(function() {
			$("#dialogBuscar").dialog('close');
		});
	});
	
	$("#btnAgregarSel").livequery(function() {
		$(this).click(function() {
			
			var a = "";
			$("[name=prms__id]").each(function(){
				if($(this).is(":checked"))
					a+=$(this).val() + ",";
			});
			
			a=$("#formPermisos").serialize();
			
			$.ajax( {
				type : "POST",
				url : "../agregarSeleccion",
				data : a +"&prfl__id=" + $("#txtPrflId").val(),
				
				success : function(msg) {
				
				$("#dialogBuscar").dialog('close');
				$("#lista-permisos").html(msg).show();
				}
			});
			
			
		});
	});


	$("#btnBuscar").livequery(function() {
		$(this).click(function() {
			buscar();
		});
	});

	$("#btnAgregar").livequery(function() {
		
		$(this).click(function() {
			
			$("#dialogBuscar").dialog("open");
		});
	});

	function buscar() {
		var bValid = true;
		allFields.removeClass('ui-state-error');

		bValid = bValid && checkLength(accnNombre, "Accion", 0, 16);
		//bValid = bValid && checkLength(control, "Controlador", 0, 80);

		/*bValid = bValid
				&& checkRegexp(nombre, /^([a-z _])+$/i,
						"El nombre debe sólo contener a-z o guión bajo.");
		bValid = bValid
				&& checkRegexp(codigo, /^([0-9.-])+$/,
						"El código debe contener sólo numeros, puntos o guiones.");*/

		if (bValid) {
			tips.text("Buscar un permiso");
			$.ajax( {
				type : "POST",
				url : "../agregarPermisos",
				data : "accnNombre=" + accnNombre.val() + "&control=" + control.val() ,
				success : function(msg) {
					$("#buscar_resultados").html(msg).show();
				}
			});
		}
	}

});
