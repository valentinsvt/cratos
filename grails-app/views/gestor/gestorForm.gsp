<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />



    <title>${(gestorContableInstance)?'Editar gestor contable':'Nuevo gestor contable'}</title>

</head>
<body>
<g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
</g:if>
<g:hasErrors bean="${gestorContableInstance}">
    <div class="errors">
        <g:renderErrors bean="${gestorContableInstance}"	as="list" />
    </div>
</g:hasErrors>
<g:form name="gestorForm" action="save" method="post" class="frmGestor" >
    <div class="container entero ui-widget-content ui-corner-all">
        <h1 class="titulo center  ui-corner-all" style="margin-bottom: 5px; margin-left: 10px;margin-bottom: 15px;">${(gestorContableInstance)?'Editar gestor contable':'Nuevo gestor contable'}</h1>
        <div style="margin-left: 20px;margin-bottom: 10px;">
            <a href="#" class=" btn tbbtn " id="guardarGestor">
                Guardar
            </a>
            <g:link class="btn" action="index">Cancelar</g:link>
        </div>
        <div id="contenido" style="margin-left: 20px;" >
            <input type="hidden" name="id" value="${gestorContableInstance?.id}"/>
            <div style="width: 800px;height: 45px;">
                <div style="width: 80px;float: left;height: 30px;line-height: 30px;">
                    Nombre:
                </div>
                <div style="width: 670px;float: right;height: 30px;">
                <input  name="nombre" type="text" value="${gestorContableInstance?.nombre}" style="width:700px;" class="ui-corner-all"/>
                </div>
            </div>

            <div style="width: 800px;height: 45px;">
                <div style="width: 80px;float: left;height: 30px;line-height: 30px;">
                    Descripción:
                </div>
                <div style="width: 670px;float: right;height: 30px;">
                    <input   name="descripcion"   type="textArea" value="${gestorContableInstance?.descripcion}" style="width:700px;"  class="ui-corner-all"/>
                </div>
            </div>

            <div style="width: 800px;height: 45px;">
                <div style="width: 80px;float: left;height: 30px;line-height: 30px;">
                    Observaciones:
                </div>
                <div style="width: 670px;float: right;height: 30px;">
                    <input   name="observaciones"   type="textArea" value="${gestorContableInstance?.observaciones}" style="width:700px;"  class="ui-corner-all"/>
                </div>
            </div>

            <div style="width: 800px;height: 45px;">
                <div style="width: 80px;float: left;height: 30px;line-height: 30px;">
                    Fuente:
                </div>
                <div style="width: 670px;float: right;height: 30px;">
                    <g:select name="fuente.id" type="select" campo="fuente" from="${cratos.Fuente.list()}" label="Fuente: " value="${gestorContableInstance?.fuente?.id}"  optionKey="id" class="ui-corner-all" ></g:select>
                </div>
            </div>

            <div style="width: 800px;height: 45px;">
                <div style="width: 80px;float: left;height: 30px;line-height: 30px;">
                    Tipo:
                </div>
                <div style="width: 670px;float: right;height: 30px;">
                    <g:select name="tipoCom" type="select" campo="tipo" from="${cratos.TipoComprobante.list()}" label="Tipo comprobante: " value="${tipoCom?.id}"  optionKey="id" id="tipo" class="ui-corner-all" ></g:select>
                </div>
            </div>


            <div style="margin-left: 50px">
            </div>
        </div>

        <fieldset style="width: 850px;border: 1px solid black;min-height: 450px;margin: auto;margin-top: 10px" class="ui-corner-all">
            <legend>MOVIMIENTOS CONTABLES</legend>
            <g:render template="busquedaCuentas"/>
        </fieldset>

    </div>
</g:form>
<script type="text/javascript">
    $(function() {
        $(".btn").button()
        var band=1
        $("#buscar").click(function() {
            $.ajax({
                type: "POST",
                url: "buscarCuentas",
                data: "nombre="+$('#nombreBus').val()+"&codigo="+$("#codigoBus").val(),
                success: function(msg){
                    $('#divPlanCuentas').html(" ")
                    $('#divPlanCuentas').html(msg);
                    var b=true

                }
            })
        });

        $("#tipo").change(function(){
            $.ajax({
                type: "POST",
                url: "cambiarComprobante",
                data: "tc="+$(this).val(),
                success: function(msg){
                    $("#agregarCuentas").html(msg)

                }
            })
        });

        $("form:eq(0)").submit(function() {
            return false;
        });

        $("#txtBusca").bind('keyup',function(event){
            var keyCode = event.which;
            if ( keyCode == 13) {
                enviar();
            }
            if($(this).val().length >= 0 && $("#error").parent().is(":visible")) {
                $("#error").html("").parent().hide("slide");
            }
        });

        $("#buscarGestor").click(function() {
            enviar();
        });

        function enviar() {
            $.ajax({
                type: "POST",
                url: "buscarGestor",
                data: $(".buscarGestor").serialize(),
                success: function(msg){
                    $("#divLista").html(msg).show("slide");
                    tablas();
                }
            });
        }

    });
</script>
</body>
</html>

