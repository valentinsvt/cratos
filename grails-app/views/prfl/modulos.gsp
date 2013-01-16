<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Perfil</title>
    <g:set var="entityName" value="${message(code: 'prfl.label', default: 'Perfiles')}"/>
    <title>Gestión de Permisos, Módulos y Perfiles</title>
</head>

<body>
<div style="width:960px; margin-bottom:5px; margin-top:10px; padding: 4px;" class="ui-corner-all ui-widget-content">
    <a href="#" id="creaPrfl">Crear Perfil</a>
    <a href="#" id="editPrfl">Editar Perfil</a>
    <a href="#" id="borraPrfl">Borrar Perfil</a>
    <span style="margin-left: 6px;"><a href="#" id="creaModulo">Crear M&oacute;dulo</a>
    <a href="#" id="editModulo">Editar M&oacute;dulo</a>
    <a href="#" id="borraModulo">Borrar M&oacute;dulo</a>
    <span style="margin-left: 6px;"></span><a href="#" id="vermenu">Ver men&uacute; de usuario</a>
</div>

<div id="tipo" style="width: 960px; margin-top:10px; padding: 4px;" class="ui-corner-all ui-widget-content">
    Selecione el tipo de acción
    <g:each var="tp" in="${cratos.seguridad.Tpac.list()}" status="i">
        <input class="rd_tipo" type="radio" id="tpac${i}" name="tpac" value="${tp.id}" ${(tp.id == 1) ? 'checked=' : ''}/><label
            for="tpac${i}">${tp.tipo}</label>
    </g:each>
    <span style="font-size: 10pt; color: black; margin-left: 160px;">Seleccione un Perfil
       <g:select optionKey="id" from="${cratos.seguridad.Prfl.list()}" name="perfil" value="${prflInstace?.id}" style="width: 180px;"></g:select>
    </span>
</div>

<br/>

<div class="" id="parm">
    <g:form action="registro" method="post" >
        <input type="hidden" id="prfl__id" name="id" value="${prflInstance?.id}"/>
        <h3>Seleccione el módulo y fije los permisos</h3>
        <div style="text-align: left; padding:5px; width: 840px;" class="ui-corner-all ui-widget-content">
            <div id="botones">
                <g:each in="${lstacmbo}" status="i" var="d">
                    <input class="modulo" type="radio" id="check${i}" name="modulo"
                           value="${d[0]?.encodeAsHTML()}" nombre="${d[1]?.encodeAsHTML()}" /><label for="check${i}">${d[1]?.encodeAsHTML()}</label>
                </g:each>
            </div>
        </div>
        <br>
    </g:form>
    <div id="ajx" style="width:820px; padding-left: 20px; "></div>

    <div id="ajx_prfl" style="width:520px;"></div>

    <div id="ajx_menu" style="width:520px;"></div>

</div>

<div id="datosPerfil" class="container entero  ui-corner-bottom">
</div>


<script type="text/javascript">
    $(document).ready(function() {
        $("#tipo").buttonset();
        $("#botones").buttonset();

        $("#procesos").click(function() {
            var datos = armar()
            //alert(datos)
            $.ajax({
                type: "POST", url: "../ajaxPermisos",
                data: "ids=" + datos + "&tipo=P",
                success: function(msg) {
                    $("#ajx").html(msg)
                }
            });
        });

        $(".modulo").click(function() {
            var datos = armar()
            //alert(datos)
            $.ajax({
                type: "POST", url: "../ajaxPermisos",
                data: "ids=" + datos + "&prfl=" + $('#perfil').val() + "&tpac=" + tipo(),
                success: function(msg) {
                    $("#ajx").html(msg)
                }
            });
        })

        $(".rd_tipo").click(function(){
            $("#ajx").html('')
            //location.reload();
        })

        $("#perfil").click(function(){
            $("#ajx").html('')
            //location.reload();
        })


        $("#vermenu").button().click(function() {
            $.ajax({
                type: "POST", url: "../verMenu",
                data: "prfl=" + $('#perfil').val() + "&tpac=" + tipo(),
                success: function(msg) {
                    $("#ajx").html(msg)
                }
            });
        });

        function armar() {
            var datos = new Array()
            $('.modulo:checked').each(
                    function() {
                        datos.push($(this).val());
                    }
            )
            return datos
        }

        ;

        function tipo() {
            var datos = new Array()
            $('.rd_tipo:checked').each(
                    function() {
                        datos.push($(this).val());
                    }
            )
            return datos
        }

        ;


        $("#creaPrfl").button().click(function() {
            //alert("crear un perfil");
            $.ajax({
                type: "POST", url: "../creaPrfl",
                data: "&tbla=prfl",
                success: function(msg) {
                    $("#ajx_prfl").dialog("option","title","Crear Perfil")
                    $("#ajx_prfl").html(msg).show("puff", 100)
                }
            });
            $("#ajx_prfl").dialog("open");
        });

        $("#editPrfl").button().click(function() {
            $.ajax({
                type: "POST", url: "../editPrfl",
                data: "&id=" + $('#perfil').val(),
                success: function(msg) {
                    $("#ajx_prfl").dialog("option","title","Editar Perfil")
                    $("#ajx_prfl").html(msg).show("puff", 100)
                }
            });
            $("#ajx_prfl").dialog("open");
        });

        $("#borraPrfl").button().click(function() {
            if (confirm("Seguro que desea Borrar el perfil \n" + $('#perfil :selected').text())) {
                $.ajax({
                    type: "POST", url: "../borraPrfl",
                    data: "&id=" + $('#perfil').val(),
                    success: function(msg) {
                        location.reload(true);
                    }
                });
            }
        });


        $("#ajx_prfl").dialog({
            autoOpen: false,
            resizable:false,
            title: 'Crear un Perfil',
            modal:true,
            draggable:false,
            width:420,
            position: 'center',
            open: function(event, ui) {
                $(".ui-dialog-titlebar-close").hide();
            },
            buttons: {
                "Grabar": function() {
                    $(this).dialog("close");
                    $.ajax({
                        type: "POST", url: "../grabaPrfl",
                        data: "&nombre=" + $('#nombre').val() + "&descripcion=" + $('#descripcion').val() +
                                "&padre.id=" + $('#padre_id').val() + "&observaciones=" + $('#observaciones').val() +
                                "&id=" + $('#id_prfl').val(),
                        success: function(msg) {
                            //$("#ajx").html(msg)
                            location.reload(true);

                        }
                    });
                },
                "Cancelar": function() {
                    $(this).dialog("close");
                }
            }
        });

        //módulos
        $("#creaModulo").button().click(function() {
            if (confirm("Crear un nuevo módulo \n")) {
                $.ajax({
                    type: "POST", url: "../creaMdlo",
                    data: "&pdre=0",
                    success: function(msg) {
                        $("#ajx_menu").dialog("option","title","Crear Módulo")
                        $("#ajx_menu").html(msg).show("puff", 100)
                    }
                });
                $("#ajx_menu").dialog("open");
            }
        });

        $("#editModulo").button().click(function() {
            var datos = armar()
            //alert(datos + "longitud: " + datos.length)
            if(datos.length > 0) {
              $.ajax({
                  type: "POST", url: "../editMdlo",
                  data: "&id=" + datos,
                  success: function(msg) {
                      $("#ajx_menu").dialog("option","title","Editar Módulo")
                      $("#ajx_menu").html(msg).show("puff", 100)
                  }
              });
              $("#ajx_menu").dialog("open");
            } else alert ("Selecione un módulo")
        });

        $("#borraModulo").button().click(function() {
            if($('.modulo:checked').attr('nombre') == undefined ) alert ("Seleccione un Modulo")
            else {
              if (confirm("Seguro que desea Borrar el Módulo: " + $('.modulo:checked').attr('nombre'))) {
                $.ajax({
                    type: "POST", url: "../borraMdlo",
                    data: "&id=" + $('.modulo:checked').val(),
                    success: function(msg) {
                        location.reload(true);
                    }
                });
              }
            }
        });


        $("#ajx_menu").dialog({
            autoOpen: false,
            resizable:false,
            title: 'Crear un Módulo',
            modal:true,
            draggable:false,
            width:420,
            position: 'center',
            open: function(event, ui) {
                $(".ui-dialog-titlebar-close").hide();
            },
            buttons: {
                "Grabar": function() {
                    $(this).dialog("close");
                    $.ajax({
                        type: "POST", url: "../grabaMdlo",
                        data: "&nombre=" + $('#nombre').val() + "&descripcion=" + $('#descripcion').val() +
                                "&id=" + $('#id_mdlo').val() + "&orden=" + $('#orden').val(),
                        success: function(msg) {
                            $("#ajx").html(msg)
                            location.reload(true);

                        }
                    });
                },
                "Cancelar": function() {
                    $(this).dialog("close");
                }
            }
        });

    });

</script>

</body>
</html>