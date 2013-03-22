<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main"/>
    <g:includeJQuery archivo="transacciones"/>
    <title>Transacciones</title>
    <style type="text/css">
    .etiqueta {
        width       : 100px;
        height      : 20px;
        line-height : 20px;
        font-weight : bold;
        display     : inline-block;
    }

    </style>
</head>

<body>
<g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
</g:if>
<g:hasErrors bean="${gestorContableInstance}">
    <div class="errors">
        <g:renderErrors bean="${gestorContableInstance}" as="list"/>
    </div>
</g:hasErrors>
<g:form name="procesoForm" action="save" method="post" class="frmProceso">
    <div class="container entero ui-widget-content ui-corner-all">
        <h1 class="titulo center ui-widget-header ui-corner-all" style="margin-bottom: 15px; margin-left: 8px;padding-left: 10px;height: 30px;line-height: 30px">${(proceso) ? 'Editar transaccion' : 'Nueva transacción'}</h1>


        <div style="width: 800px;height: 30px;padding-left: 30px;margin-bottom: 15px">
            <g:if test="${!registro}">
                <a href="#" class="btn ui-corner-all" id="guardarProceso">
                    Guardar
                </a>

            </g:if>
            <g:if test="${params.id}">
                <g:if test="${proceso.adquisicion == null && proceso.fact == null && proceso.transferencia == null}">
                    <a href="#" class="btn" id="registrarProceso">
                        Registrar
                    </a>
                </g:if>
            </g:if>
            <g:link class="btn ui-corner-all" action="index">
                Cancelar
            </g:link>
        </div>
        <input type="hidden" name="id" value="${proceso?.id}" id="idProceso"/>
        <input type="hidden" name="empleado.id" value="${session.usuario.id}"/>
        <input type="hidden" name="periodoContable.id" value="${session?.contabilidad?.id}"/>

        <div id="contenido" style="width: 900px;padding-left: 30px;">
            <div class="etiqueta">Gestor:</div> <g:select class="ui-corner-all" name="gestor.id" from="${cratos.Gestor.findAllByEstado('A')}" label="Proceso tipo: " value="${proceso?.gestor?.id}" optionKey="id" optionValue="nombre"></g:select>
            <br>

            <div class="etiqueta">Fecha:</div> ${new java.util.Date().format("dd/MM/yyyy")}
            <br>

            <div class="etiqueta">Proveedor:</div>
            <input type="text" name="proveedor.ruc" class="ui-corner-all" id="prov" disabled="true" value="${proceso?.proveedor?.ruc}">
            <a href="#" id="btn_buscar" class="btn">Buscar</a>
            <input type="hidden" name="proveedor.id" id="prov_id" value="${proceso?.proveedor?.id}">
            <br>

            <div class="etiqueta">Descripción:</div> <textArea style='height:40px;width: 700px;' name="descripcion" class="ui-corner-all">${proceso?.descripcion}</textArea>
        </div>
        <br>
        <br>

        <div class="span-28" style="margin-left: 40px;margin-top: 10px;margin-bottom: 15px;">
            <div style="float:left;padding-top: 3px;">
                <label>Valor:</label><input type="text" name="valor" size="7" value="${proceso?.valor}" class="required ui-widget-content ui-corner-all "   validate="required number">
                <label style="margin-left: 40px;">Impuestos:</label><input type="text" name="impuesto" size="7" value="${proceso?.impuesto}" class="required ui-widget-content ui-corner-all" validate="required number">
                <label style="margin-left: 40px;">Documento:</label><input type="text" name="documento" style="width: 120px;margin-right: 5px" value="${proceso?.documento}" class=" ui-widget-content ui-corner-all">
                <b>Tipoa de pago:</b> <g:select name="tipoPago.id" from="${cratos.TipoPago.list()}" label="Tipo de pago: " value="${proceso?.tipoPago?.id}" optionKey="id" validate="required " optionValue="descripcion"></g:select>
            </div>

            <div class="span-9 last" style="margin-left: 40px;float: left;"></div>
        </div>
        <br>

        <div id="registro" style="float:left; margin-left: 40px;border: black solid 1px; margin-bottom: 25px;padding: 10px;display: none;margin-top: 15px;">

        </div>

    </div>

    <div id="dlgBuscar" style="width: 500px;height: 450px;">
        <div style="width: 450px;height: 30px;margin-bottom: 15px">
            <select id="tipoPar" style="margin-right: 5px;" class="ui-corner-all">
                <option value="1">RUC</option>
                <option value="2">Nombre</option>
            </select>
            <input type="text" id="parametro" class="ui-corner-all" style="margin-right: 10px;">
            <a href="#" id="buscar" class="btn">Buscar</a>
        </div>

        <div style="width: 450px;height: 300px;overflow-y: auto;" id="resultados"></div>

    </div>

</g:form>

<script type="text/javascript">
    $(function () {

        $(".btn").button()

        $("#guardarProceso").click(function () {
            $.box({
                imageClass : "box_info",
                text       : "Por favor espere",
                title      : "Procesando",
                iconClose  : false,
                dialog     : {
                    resizable     : false,
                    draggable     : false,
                    closeOnEscape : false,
                    buttons       : { }
                }
            });
        });

        $("#btn_buscar").click(function () {
            $("#dlgBuscar").dialog("open")
        });

        $("#buscar").click(function () {

            $.ajax({
                type    : "POST",
                url     : "${g.createLink(controller: 'proceso',action: 'buscarProveedor')}",
                data    : "par=" + $("#parametro").val() + "&tipo=" + $("#tipoPar").val(),
                success : function (msg) {
                    //$("#registro").html(msg).show("slide");

                    $("#resultados").html(msg).show("slide")
                }
            });

        });

        $("#dlgBuscar").dialog({
            autoOpen  : false,
            modal     : true,
            resizable : false,
            draggable : false,
            title     : "Busqueda de proveedores",
            width     : 500,
            height    : 450,
            position  : "center",
            buttons   : {
                "Cerrar" : function () {
                    $("#dlgBuscar").dialog("close");
                }
            }
        });

        $("#registrarProceso").click(function () {
            if (confirm("Está seguro?")) {
                var d = $.box({
                    imageClass : "box_info",
                    text       : "Por favor espere",
                    title      : "Procesando",
                    iconClose  : false,
                    dialog     : {
                        resizable     : false,
                        draggable     : false,
                        closeOnEscape : false,
                        buttons       : { }
                    }
                });
                $.ajax({
                    type    : "POST",
                    url     : "${g.createLink(controller: 'proceso',action: 'registrar')}",
                    data    : "id=" + $("#idProceso").val(),
                    success : function (msg) {
                        //$("#registro").html(msg).show("slide");
                        $("#auth").dialog("close");
                        location.reload(true);
                    },
                    error   : function () {
                        $.box({
                            imageClass : "box_info",
                            text       : "Ha ocurrido un error. Por favor revise el gestor y los valores del proceso.",
                            title      : "Alerta",
                            iconClose  : false,
                            dialog     : {
                                resizable     : false,
                                draggable     : false,
                                closeOnEscape : false,
                                buttons       : {
                                    "Aceptar" : function () {
                                        d.dialog("close");
                                    }
                                }
                            }
                        });

                    }
                });

            }
        });
    });
</script>


<g:if test="${proceso}">
    <script type="text/javascript">
        //                console.log("entro")

        $.ajax({
            type    : "POST",
            url     : "${g.createLink(action: 'cargaComprobantes')}",
            data    : "proceso=" + $("#idProceso").val(),
            success : function (msg) {
                $("#registro").html(msg).show("slide");
            }
        });

    </script>
</g:if>
</body>

</html>
