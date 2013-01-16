$(function() {
	var codigo = $("#buscar_codigo"), nombre = $("#buscar_nombre"), allFields = $(
			[]).add(codigo).add(nombre), tips = $(".validateTips");

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
			$("#txtIdCuenta").val(id);
			$("#dialogBuscar").dialog("close");
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

	$("#buscar_codigo, #buscar_nombre").livequery(function() {
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

	$("#btnBuscar").livequery(function() {
		$(this).click(function() {
			buscar();
		});
	});

	$("#ico_txtBuscar").livequery(function() {
		$(this).click(function() {
			$("#dialogBuscar").dialog("open");
		});
	});

	function buscar() {
		var bValid = true;
		allFields.removeClass('ui-state-error');

		bValid = bValid && checkLength(codigo, "código", 0, 16);
		bValid = bValid && checkLength(nombre, "nombre", 0, 80);

		bValid = bValid
				&& checkRegexp(nombre, /^([a-z _])+$/i,
						"El nombre debe sólo contener a-z o guión bajo.");
		// From jquery.validate.js (by joern), contributed by Scott Gonzalez:
		// http://projects.scottsplayground.com/nombre_address_validation/
		bValid = bValid
				&& checkRegexp(codigo, /^([0-9.-])+$/,
						"El código debe contener sólo numeros, puntos o guiones.");

		if (bValid) {
			tips.text("Buscar una cuenta");
			$.ajax( {
				type : "POST",
				url : "../buscarCuentas",
				data : "nombre=" + nombre.val() + "&codigo=" + codigo.val(),
				success : function(msg) {
					$("#buscar_resultados").html(msg).show();
				}
			});
		}
	}

});
