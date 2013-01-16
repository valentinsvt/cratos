
function validarFechaCargas(dateText, inst) {
    var parts;

    parts = dateText.split("/");

    $('#txtFechaFinCarga').datepicker('option', 'minDate', new Date(parts[2], (parts[1] - 1), (parts[0])));
}


function validarFechaEmpleo(dateText, inst) {
    var id = inst.id;
    var parts;
    parts = dateText.split("/");
    if(id == "txtFechaInicioEmpleo") {
        $('#txtFechaFinEmpleo').datepicker('option', 'minDate', new Date(parts[2], (parts[1] - 1), (parts[0])));
    }
}

function validarFechaBien(dateText, inst) {
    var id = inst.id;
    var parts;
    parts = dateText.split("/");
    if(id == "fechaInicioBien") {
        $('#fechaFinBien').datepicker('option', 'minDate', new Date(parts[2], (parts[1] - 1), (parts[0])));
    }
}


function tablas(tabla) {
    if(tabla == null)
        tabla = ".table";
    try {
        $(tabla).livequery(function() {
            $(this).dataTable( {
                "bPaginate": true,
                "sPaginationType": "full_numbers",
                "bLengthChange": false,
                "bSort": true,
                "bFilter": false,
                "bInfo": true
            } );
        });

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

$(function() {

    $("#editar").livequery(function(){
        $(this).click(function(){
            $.ajax({
                type: "POST",
                url: "../editarCliente",
                data: "id="+$("#txtIdCliente").val(),
                success: function(msg){
                    $("#datosPersonales").html(msg);
                }
            });
        })
    });
    var arr = new Array();
  
    function validarFechaPersona(dateText, inst) {
        var id = inst.id;
        var parts;
        parts = dateText.split("/");
        if(id == "txt_fechaNacimiento") {
            $('#txt_fechaDefuncion').datepicker('option', 'minDate', new Date(parts[2], (parts[1] - 1), (parts[0])));
        }
        else if(id == "txt_fechaInicio") {
            $('#txt_fechaFin').datepicker('option', 'minDate', new Date(parts[2], (parts[1] - 1), (parts[0])));
        }
    }

    $("#btnEditar").click(function() {
        $.ajax({
            type: "POST",
            url: "../editarCliente",
            data: "id="+$("#id").val(),
            success: function(msg){
                $("#datosPersonales").html(msg);
            }
        });
    });

    $("#btnCancelarPersona").livequery(function(){
        $(this).click(function() {
            $.ajax({
                type: "POST",
                url: "../verCliente2",
                data: "id="+$("#id").val(),
                success: function(msg){
                    $("#datosPersonales").html(msg);
                }
            });
        });
    });

    $("#btnGuardar").click(function() {
        $.ajax({
            type: "POST",
            url: "../modificarCliente",
            data: $("#frmCliente").serialize(),
            success: function(msg){
                $("#datosPersonales").html(msg);
            }
        });
    });


    $("#cmb_pais").livequery(function(){
        $(this).change(function() {
            padre = $(this).val();
            name = $(this).attr("name");
            cambia = $(this).attr("cambia");
            //alert(padre+"\n"+name+"\n"+cambia);
            $.ajax({
                type: "POST",
                url: "../cargarComboBoxLugar",
                data: "padre="+padre+"&cambia="+cambia+"&name="+name,
                success: function(msg){
                    $("#"+cambia+"_edit").html(msg);
                //alert(msg);
                }
            });
        });
    });

    $("#cmbTipo").change(function() {
        $("#txtBusca").val("");

        if($("#divListaClientes").is(":visible"))
            $("#divListaClientes").hide("slide");

        if($(this).val() == "p.prsnfcna") {
            $("#txtBusca").addClass("datepicker");
            $("#txtBusca").attr("readonly",true);

            $("#txtBusca").datepicker({
                dateFormat: 'dd/mm/yy',
                changeYear: true,
                changeMonth: true,
                maxDate: "+0D",
                yearRange:"-50:+10"
            });
        } else {
            $("#txtBusca").datepicker('destroy');
            $("#txtBusca").removeClass("datepicker");
            $("#txtBusca").attr("readonly",false);
        }
    });

    $("#btnCancelarCargas").livequery(function() {
        $(this).click(function() {
            reloadCargas();
        });
    });

    function reloadCargas() {
        var idPer = $("#txtIdPersona").val();
        var idCli = $("#txtIdCliente").val();
        //	    alert(src+" "+idPer);

        $("#cargas").addClass("loading_bg");
        //esta abierto por primera vez: cargar con ajax el contenido
        $.ajax({
            type: "POST",
            url: "../cargarCargasCliente",
            data: "id="+idPer+"&cli="+idCli,
            success: function(msg){
                $("#cargas").removeClass("loading_bg");
                $("#cargas").html(msg);
            //tablas("#tblcargas");
            }
        });
    }
    $("#btnGuardarCargas").livequery(function() {
        $(this).click(function() {
            var b = $("#agregarCargas").valid();
            if(b) {
                guardarCarga();
            }
        });
    });
    $("#btnAgregarCargas").livequery(function() {
        $(this).click(function() {
		
            var idPer = $("#txtIdPersona").val();
            var idCli = $("#txtIdCliente").val();

            $.ajax({
                type: "POST",
                url: "../agregarCargasCliente",
                data: "cli="+idCli,
                success: function(msg){
                    $("#cargas").html(msg);
                }
            });

        });
    });
    $(".editarCargas").livequery(function() {
        $(this).click(function() {
            var id = $(this).attr("id");
            $.ajax({
                type: "POST",
                url: "../agregarCargasCliente",
                data: "id="+id,
                success: function(msg){
                    $("#cargas").html(msg);
                }
            });

        });
    });

    $("#agregarCargas").submit(function() {
        return false;
    });

    function guardarCarga() {
        $("#cargas").addClass("loading_bg");
        $.ajax({
            type: "POST",
            url: "../guardarCargasCliente",
            data: $("#agregarCargas").serialize(),
            success: function(msg){
                $("#cargas").removeClass("loading_bg");

                reloadCargas();
            }
        });
    }
    
    $("#btnAgregarBien").livequery(function() {
        $(this).click(function() {

            var idPer = $("#txtIdPersona").val();
            var idCli = $("#txtIdCliente").val();

            $.ajax({
                type: "POST",
                url: "../nuevoBien",
                data: "cli="+idCli+"&per="+idPer,
    		    
                success: function(msg) {
    				
                    $("#bienes").html(msg);
	    			
                    $(".datepicker").datepicker({
                        dateFormat: 'dd/mm/yy',
                        changeYear: true,
                        changeMonth: true,
                        maxDate: "+0D",
                        yearRange:"-50:+50",
                        onSelect: validarFechaBien
                    });
                }
            });
    	    

        });
    });

    $("#btnCancelarBien").livequery(function() {
        $(this).click(function() {

            var idPer = $("#txtIdPersona").val();
            var idCli = $("#txtIdCliente").val();

            $.ajax({
                type: "POST",
                url: "../listaBienesCliente",
                data: "cli="+idCli,
    		    
                success: function(msg) {
    				
                    $("#bienes").html(msg);
	    			
	    		
                }
            });
        });
    });
    $("#btnBorrarBien").livequery(function() {
        $(this).click(function() {
            var id = $(this).attr("idBien");
            var idCli = $("#idCliente").val();
            $.ajax({
                type: "POST",
                url: "../borrarBien",
                data: "cli="+idCli+"&id="+id,

                success: function(msg) {

                    $("#bienes").html(msg);


                }
            });
        });
    });
    
    
    $("#btnGuardarBien").livequery(function() {
        $(this).click(function() {
            $("#bienes").addClass("loading_bg");
    		
    		
            $.ajax({
                type: "POST",
                url: "../guardarBien",
                data: $(".formBien").serialize(),
                success: function(msg){
        		
                    $("#bienes").removeClass("loading_bg");
                    $("#bienes").html(msg)
                //reloadCargas();
                }
            });
        });
    });


    $(".editarBienes").livequery(function() {
        $(this).click(function() {
            var id = $(this).attr("id");
            $.ajax({
                type: "POST",
                url: "../editarBien",
                data: "id="+id,
                success: function(msg){
                    $("#bienes").html(msg);
                }
            });

        });
    });
    
    /*******************************************************************************************************************************/
    $("#btnCancelarEmpleos").livequery(function() {
        $(this).click(function() {
            reloadEmpleos();
        });
    });

    function reloadEmpleos() {
        var idPer = $("#txtIdPersona").val();
        var idCli = $("#txtIdCliente").val();
        //	    alert(src+" "+idPer);

        $("#empleos").addClass("loading_bg");
        //esta abierto por primera vez: cargar con ajax el contenido
        $.ajax({
            type: "POST",
            url: "../listaTrabajosCliente",
            data: "id="+idPer+"&cli="+idCli,
            success: function(msg){
                $("#empleos").removeClass("loading_bg");
                $("#empleos").html(msg);
            //tablas("#tblempleos");
            }
        });
    }

    $("#btnGuardarEmpleos").livequery(function() {
        $(this).click(function() {
            guardarEmpleo();
        });
    });

    $(".borrarEmpleo").livequery(function() {
        $(this).click(function() {
            var id = $(this).attr("id");
            var idCli = $("#idCliente").val();
            $.ajax({
                type: "POST",
                url: "../eliminarTrabajoCliente",
                data: "cli="+idCli+"&id="+id,

                success: function(msg) {

                    reloadEmpleos();


                }
            });
        });
    });

    $("#btnAgregarEmpleos").livequery(function() {
        $(this).click(function() {
            var idPer = $("#txtIdPersona").val();
            var idCli = $("#txtIdCliente").val();

            $.ajax({
                type: "POST",
                url: "../agregarTrabajosCliente",
                data: "cli="+idCli,
                success: function(msg){
                    $("#empleos").html(msg);

                    $(".datepicker").datepicker({
                        dateFormat: 'dd/mm/yy',
                        changeYear: true,
                        changeMonth: true,
                        maxDate: "+0D",
                        yearRange:"-50:+50",
                        onSelect: validarFechaEmpleo
                    });

                }
            });
        });
    });

    $(".editarTrabajos").livequery(function() {
        $(this).click(function() {
            var id = $(this).attr("id");
            $.ajax({
                type: "POST",
                url: "../agregarTrabajosCliente",
                data: "id="+id,
                success: function(msg){
                    $("#empleos").html(msg);
                }
            });

        });
    });

    $("#agregarEmpleos").submit(function() {
        return false;
    });

    function guardarEmpleo() {
        $("#empleos").addClass("loading_bg");
        $.ajax({
            type: "POST",
            url: "../guardarEmpleosCliente",
            data: $("#agregarEmpleos").serialize(),
            success: function(msg){
                $("#empleos").removeClass("loading_bg");

                reloadEmpleos();
            }
        });
    }

    /*************************** buscarClientes2 ************************************************************************/

    $(".editar").livequery(function() {
        $(this).click(function() {
            var clase = $(this).attr("clase");
            var clas = ucfirst(clase);
            var cont = $(this).attr("id");

            var url = $(this).attr("href");

            var idPer = $("#txtIdPersona").val();
            var idCli = $("#txtIdCliente").val();

            $.ajax({
                type: "POST",
                url: url,
                data: "cli="+idCli+"&dato="+cont,
                success: function(msg){
                    $("#"+clase).html(msg);
                    try {
                        $(".datepicker").datepicker({
                            dateFormat: 'dd/mm/yy',
                            changeYear: true,
                            changeMonth: true,
                            maxDate: "+0D",
                            yearRange:"-50:+50",
                            onSelect: function(dateText, inst) {
                                var id = inst.id;
                                var parts;
                                parts = dateText.split("/");
                                if(id == "txtFechaInicio"+clas) {
                                    $('#txtFechaFin'+clas).datepicker('option', 'minDate', new Date(parts[2], (parts[1] - 1), (parts[0])));
                                }
                            }
                        }); //datepicker
                    }catch(e) {}
                } //success
            }); //ajax
            return false;
        }); //click
    }); //livequery
        /*************************** buscarClientes2 ************************************************************************/
        /***************************Empresa**********************************************************************************/

        $("#editarEmpresa").livequery(function() {
            $(this).click(function() {
                $.ajax({
                    type: "POST",
                    url: "../editEmpresa",
                    data: "id="+$(this).attr("idCli"),
                    success: function(msg){
                        $("#datosEmpresa").html(msg);
                    }
                });
            });
        });

    $("#cancelarEmpresa").livequery(function() {
        $(this).click(function() {
            $.ajax({
                type: "POST",
                url: "../showEmpresa2",
                data: "id="+$(this).attr("idCli"),
                success: function(msg){
                    $("#datosEmpresa").html(msg);
                }
            });
        });
    });

    $("#guardarEmpresa").livequery(function() {
        $(this).click(function() {
            $.ajax({
                type: "POST",
                url: "../saveEmpresa",
                data: $(".frmEmpresa").serialize(),
                success: function(msg){
                    //$("#datosEmpresa").html(msg);
                    reloadEmpresa();
                }
            });
        });
    });

    function reloadEmpresa() {
        var idCli = $("#idCliente").val();
        //	    alert(src+" "+idPer);

        $("#empleos").addClass("loading_bg");
        //esta abierto por primera vez: cargar con ajax el contenido
        $.ajax({
            type: "POST",
            url: "../showEmpresa2",
            data: "id="+idCli,
            success: function(msg){
                $("#datosEmpresa").removeClass("loading_bg");
                $("#datosEmpresa").html(msg);
                
            }
        });
    }
    
    $("#agregarEmpleadosEmpresa").livequery(function() {
        $(this).click(function() {
            var idCli = $(this).attr("idCli");
            $.ajax({
                type: "POST",
                url: "../newPersonalEmpresa",
                data: "cli="+idCli,
                success: function(msg){
                    $("#listaPersonalEmpresa").html(msg);

                   
                }
            });
        });
    });

    $("#cancelarEmpleadosEmpresa").livequery(function() {
        $(this).click(function() {
            reloadPersonalEmpresa();
        });
    });

    $("#guardarEmpleadosEmpresa").livequery(function() {
        $(this).click(function() {
            $.ajax({
                type: "POST",
                url: "../savePersonalEmpresa",
                data: $(".formPersonalEmpresa").serialize(),
                success: function(msg){
                    //$("#datosEmpresa").html(msg);
                    reloadPersonalEmpresa();
                }
            });
        });
    });

    function reloadPersonalEmpresa() {
        var idCli = $("#idCliente").val();
        //	    alert(src+" "+idPer);

        $("#empleos").addClass("loading_bg");
        //esta abierto por primera vez: cargar con ajax el contenido
        $.ajax({
            type: "POST",
            url: "../listaPersonalEmpresa",
            data: "cli="+idCli,
            success: function(msg){
                $("#listaPersonalEmpresa").removeClass("loading_bg");
                $("#listaPersonalEmpresa").html(msg);

            }
        });
    }

    $(".borrarPersonal").livequery(function() {
        $(this).click(function() {
            var id = $(this).attr("idPersonal");
            $.ajax({
                type: "POST",
                url: "../deletePersonalEmpresa",
                data: "personalEmpresa.id="+id+"&persona.id=",

                success: function(msg) {
                    if(msg=="1")
                        reloadPersonalEmpresa();


                }
            });
        });
    });


    $(".editarPersonal").livequery(function() {
        $(this).click(function() {
            var id = $(this).attr("idPersonal");
            $.ajax({
                type: "POST",
                url: "../editPersonalEmpresa",
                data: "id="+id+"&cli="+$("#clienteId").val(),
                success: function(msg){
                    $("#listaPersonalEmpresa").html(msg);
                    
                }
            });

        });
    });





});