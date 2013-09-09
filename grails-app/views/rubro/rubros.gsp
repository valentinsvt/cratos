<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main"/>
    <title>Rubros</title>
    <style type="text/css">
    .etiqueta {
        width       : 80px;
        height      : 20px;
        line-height : 20px;
        font-weight : bold;
        display     : inline-block;
        margin-left: 5px;
    }
    .margen{
        margin-left: 20px;
    }
    th{
        text-align: center;
    }

    table{
        border-collapse:collapse;
    }
    td,th{
        border: 1px solid #000000;
    }
    </style>
</head>
<body>
<g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
</g:if>

<div class="container entero ui-widget-content ui-corner-all">
    <h1 class="titulo center ui-widget-header ui-corner-all" style="margin-bottom: 15px; margin-left: 8px;padding-left: 10px;height: 30px;line-height: 30px">
        Detalle
    </h1>

    <div class="etiqueta margen">  Tipo: </div>
    <g:select name="tipo" from="${tipos}" id="tipoRubro" optionKey="id"></g:select>
    <div style="width: 95%;height: 30px;margin-left: 20px;margin-bottom: 10px;">
        <input type="hidden" id="rubro_id">
        <div class="etiqueta"> Porcentaje: </div><input type="text" id="rubro_porcentaje" style="width: 50px;">
        <div class="etiqueta" style="width: 40px;">Valor:    </div> <input type="text" id="rubro_valor" style="width: 50px;">
        <div class="etiqueta">Descripción:</div><input type="text" id="rubro_descripcion" style="width: 250px;">
        <div class="etiqueta" style="width: 35px;"> IESS:</div> <input type="checkbox" id="rubro_iess" value="1">
        <div class="etiqueta" style="width: 35px;"> Grav.:</div> <input type="checkbox" id="rubro_gravable" value="1">
        <div class="etiqueta" style="width: 45px;">Décimo:</div> <input type="checkbox" id="rubro_decimo" value="1">
        <div class="agregarCuenta  " id="agregar" style="margin-left: 5px;">
            Agregar
        </div>
    </div>
    <fieldset style="width: 90%;margin-left: 20px;">
        <legend>Rubros</legend>
        <div id="detalle" style="width: 95%"></div>
    </fieldset>
    <div id="errors" style="display: none"></div>
</div>
<script type="text/javascript">
    $("#tipoRubro").change(function(){

        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'rubro',action: 'cargaRubros')}",
            data    : "id=" +$("#tipoRubro").val(),
            success : function (msg) {

                $("#detalle").html(msg).show("slide")
            }
        });
    });

    $("#errors").dialog({
        width:400,
        height:200,
        title:"Errores",
        autoOpen:false,
        modal:true,
        buttons:{
            "Cerrar":function(){
                $(this).dialog("close")
            }
        }
    })

    $("#agregar").button().click(function(){

        var id = $("#rubro_id").val()
        var porcentaje = $("#rubro_porcentaje").val()
        var valor = $("#rubro_valor").val()
        var descripcion =$("#rubro_descripcion").val()
        var iess=0
        var grav=0
        var decimo=0
        var msn=""
        if(isNaN(porcentaje) || porcentaje=="")
            porcentaje=-1
        if(porcentaje*1<0)
            msn+="<br>Error: El porcentaje debe ser un número positivo"
        if(isNaN(valor) || valor=="")
            valor=-1
        if(valor*1<0)
            msn+="<br>Error: El valor debe ser un número positivo"
        if(descripcion.length>62)
            msn+="<br>Error: la descripcíon debe tener máximo 62 caracteres"
        if(descripcion=="")
            msn+="<br>Error: ingrese una descripción"
        if($("#rubro_iess").attr("checked")=="checked")
            iess=1
        if($("#rubro_decimo").attr("checked")=="checked")
            decimo=1
        if($("#rubro_gravable").attr("checked")=="checked")
            grav=1

        if(msn==""){
            $.ajax({
                type    : "POST",
                url     : "${g.createLink(controller: 'rubro',action: 'addRubro')}",
                data    : "id=" +id+"&porcentaje="+porcentaje+"&valor="+valor+"&descripcion="+descripcion+"&iess="+iess+"&decimo="+decimo+"&grav="+grav+"&tipo="+$("#tipoRubro").val(),
                success : function (msg) {
                    $("#rubro_gravable").attr("checked","false")
                    $("#rubro_iess").attr("checked","false")
                    $("#rubro_decimo").attr("checked","false")
                    $("#detalle").html(msg).show("slide")
                    $("#rubro_porcentaje").val("")
                    $("#rubro_valor").val("")
                    $("#rubro_id").val("")
                    $("#rubro_descripcion").val("")
                }
            });
        }else{
            $("#errors").html(msn)
            $("#errors").dialog("open")

        }


    });
    $("#tipoRubro").change()

</script>
</body>
</html>