<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Acciones</title>
    <g:set var="entityName" value="Perfiles"/>
    <title>Estructura del Men&uacute; y Procesos</title>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.livequery.js')}"></script>
</head>

<body>
<div style="width:900px; margin-bottom:5px; margin-top:10px; padding: 4px;margin-left: 30px;margin-bottom: 10px;" class="ui-corner-all ui-widget-content">
    <span id="tipo" style="text-align: right; padding-left: 6px;">
        Tipo de acción
        <g:each var="tp" in="${cratos.seguridad.Tpac.list([sort:id])}" status="i">
            <input class="rd_tipo" type="radio" id="tpac${i}" name="tpac" value="${tp.id}" ${(tp.id == 1) ? 'checked' : ''}/><label
                for="tpac${i}">${tp.tipo}</label>
        </g:each>
    </span>
    <span style="margin-left: 30px;"></span>
    <a href="${createLink(controller: 'prfl', action: 'modulos', id: '1')}"
       id="aPrfl">Gestionar Permisos y M&oacute;dulos</a>
    <a href="#" id="cargaCtrl">Cargar Controladores</a>
    <a href="#" id="cargaAccn">Cargar Acciones</a>
</div>


<div class="" id="parm" >
    <h3 style="margin-left: 30px">Seleccione el módulo para fijar permisos o editar acciones y procesos</h3>

    <div style="text-align: left; padding:5px; width: 900px;margin-left: 30px;" class="ui-corner-all ui-widget-content">
        <div id="botones">
            <g:each in="${lstacmbo}" status="i" var="d">
                <input class="modulo" type="radio" id="check${i}" name="modulo"
                       value="${d[0]?.encodeAsHTML()}"/><label for="check${i}">${d[1]?.encodeAsHTML()}</label>
            </g:each>
        </div>
    </div>
    <br>
    <div id="ajx" style="width:820px; padding-left: 20px; height: 520px;margin-left: 30px"></div>

</div>

<div id="datosPerfil" class="container entero  ui-corner-bottom">
</div>


<script type="text/javascript">
    $(document).ready(function() {

        $("#tipo").buttonset();
        $("#botones").buttonset();
        $("#aPrfl").button();

        $("#cargaCtrl").button().click(function() {
            //alert("crear un perfil");
            if (confirm("Cargar controladores desde Grails?")) {
                $.ajax({
                    type: "POST", url: "${createLink(controller:'acciones', action:'cargarControladores')}",
                    data: "",
                    success: function(msg) {
                        alert(msg)
                    }
                });
            }
        });

        $("#cargaAccn").button().click(function() {
            //alert("crear un perfil");
            if (confirm("Cargar las Acciones desde Grails?")) {
                $.ajax({
                    type: "POST", url: "${createLink(controller:'acciones', action:'cargarAcciones')}",
                    data: "",
                    success: function(msg) {
                        alert(msg)
                    }
                });
            }
        });


        $(".modulo").click(function() {
            var datos = armar()
            var v_tipo = tipo()
            //alert("datos código del módulo:" + datos);
            //alert("tipo: " + v_tipo)
            $.ajax({
                type: "POST", url: "${createLink(controller:'acciones', action:'ajaxAcciones')}",
                data: "mdlo=" + datos + "&tipo=" + tipo(),
                success: function(msg) {
                    $("#ajx").html(msg)
                }
            });
        });

        $(".rd_tipo").click(function(){
            $("#ajx").html('')
            //location.reload();
        })

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

        function tipo() {  // menu o proceso
            var datos = new Array()
            $('.rd_tipo:checked').each(
                    function() {
                        datos.push($(this).val());
                    }
            )
            return datos
        }

        ;

        function armarAccn() {
            var datos = new Array()

            $('.chkAccn:checked').each(
                    function() {

                            datos.push($(this).val());
                    })
            return datos
        }

        ;

        $("#aceptaAJX").livequery(function() {
            $(this).click(function() {
                if (confirm("Eliminar las acciones seleccionadas de este módulo??")) {
                    var data = armarAccn();
                    alert('datos armados:' + data);
                    $.ajax({
                        type: "POST", url: "${createLink(controller:'acciones', action:'sacarAccn')}",
                        data: "&ids=" + data + "&mdlo=" + $('#mdlo__id').val() + "&tipo=" + tipo(),
                        success: function(msg) {
                            $("#ajx").html(msg)
                        }
                    });
                }
            });
        });

        $("#mueveAJX").livequery(function() {
            $(this).click(function() {

                if (confirm("Mover las acciones seleccionadas??")) {
                    var data = armarAccn()
                    $.ajax({
                        type: "POST", url: "${createLink(controller:'acciones', action:'moverAccn')}",
                        data: "&ids=" + data + "&mdlo=" + $('#modulo').val() + "&tipo=" + tipo(),
                        success: function(msg) {
                            //$("#ajx").html(msg)
                            alert(msg);
                        }
                    });
                }
            });
        });


        $("#cambia").livequery(function() {
            $(this).click(function() {
                if (confirm("Cambiar las acciones señaladas de Menú a Proceso o Viceversa ??")) {
                    var data = armarAccn()
                    alert('datos armados:' + data)
                    $.ajax({
                        type: "POST", url: "${createLink(controller:'acciones', action:'cambiaAccn')}",
                        data: "&ids=" + data + "&mdlo=" + $('#mdlo__id').val() + "&tipo=" + tipo(),
                        success: function(msg) {
                            $("#ajx").html(msg)
                        }
                    });
                }
            });
        });

        $("#cambias").livequery(function() {
            $(this).click(function() {
                if (confirm("Cambiar las acciones señaladas de Menú a Proceso o Viceversa??")) {
                    var data = armarAccn()
                    alert('datos armados:' + data)
                    $.ajax({
                        type: "POST", url: "${createLink(controller:'acciones', action:'hola')}",
                        data: "&ids=" + data + "&mdlo=" + $('#mdlo__id').val() + "&tipo=" + tipo(),
                        success: function(msg) {
                            $("#ajx").html(msg)
                        }
                    });
                }
            });
        });


    });

</script>

</body>
</html>