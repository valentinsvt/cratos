<%@ page import="cratos.Bodega" %>
<h1>Item: ${detalle.item.codigo}  ${detalle.item.nombre}</h1>
Cantidad Total: <g:formatNumber number="${detalle.cantidad}" minFractionDigits="2" maxFractionDigits="2"/><br>
Cantidad Restante por Asignar: <g:formatNumber number="${detalle.cantidad - cant}" minFractionDigits="2"
                                               maxFractionDigits="2"/><br>

<fieldset>

    <label>Cantidad</label>
    <g:textField name="cant" style="width: 50px"/>

    <label>Bodega</label>
    <g:select name="bodega" from="${Bodega.findAllByEmpresa(session.empresa)}" optionKey="id"
              optionValue="descripcion"/>

    <a href="#" id="addItem">Agregar</a>

</fieldset>
<table boder="1" style="border-collapse: collapse; ">
    <thead>
    <tr>
        <th>
            Bodega

        </th>
        <th>

            Fecha
        </th>
        <th>
            Cantidad

        </th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${bodegas}" var="b" status="i">
        <tr class="${i % 2 == 0 ? 'even' : 'odd'}">

            <td>
                ${b.bodega.descripcion}

            </td>

            <td>
                <g:formatDate date="${b.fecha}" format="dd-MM-yyyy HH:mm"/>

            </td>
            <td style="text-align: right">
                <g:formatNumber number="${b.cantidad}" minFractionDigits="2" maxFractionDigits="2"/>

            </td>
        </tr>
    </g:each>

    </tbody>
    <tfoot>

    <td colspan="2" style="text-align: right">
        Total Asignado

    </td>

    <td style="text-align: right">

        <g:formatNumber number="${cant}" minFractionDigits="2" maxFractionDigits="2"/>

    </td>

    </tfoot>
</table>


<div id="dlgLoad">
    <img src="${resource(dir: 'images', file: 'spinner.gif')}" alt=""/>
    Procesando
</div>

<script type="text/javascript">

    $( "#busqueda" ).dialog( "option", "title", "Item: ${detalle.item.codigo}  ${detalle.item.nombre}" );

    $("#dlgLoad").dialog({

        autoOpen:false,
        modal:true,
        draggable:false,
        resizable:false,
        closeOnEscape:false,
        open:function (event, ui) {
            $(event.target).parent().find(".ui-dialog-titlebar-close").remove();
        }
    })

    $("#addItem").button().click(function () {

        var cantidad = trim($("#cant").val());
        var bodega = $("#bodega").val();

        var msg = "";

        if (cantidad == "") {
            msg += "<li>Ingrese una cantidad</li>"
        } else {
            if (isNaN(cantidad)) {
                msg += "<li>Cantidad debe ser un número</li>"
            }
            else {
                cantidad = parseFloat(cantidad)
                if (cantidad > parseFloat("${detalle.cantidad - cant}")) {
                    msg += "<li>Ingrese un valor menor que: ${detalle.cantidad - cant}</li>"
                }
                else {
                    $("#dlgLoad").dialog("open");
                    $.ajax({
                        type:"POST",
                        url:"${createLink(action: 'addToBodega')}",
                        data:{
                            detalle:"${detalle.id}",
                            cantidad:cantidad,
                            bodega:bodega

                        },
                        success:function (ret) {
                            console.log(ret)

                            $("#busqueda").html(ret)
                        },
                        complete:function () {

                            $("#dlgLoad").dialog("close");

                        }
                    });
                    //
                }
            }
        }


        if (msg != "") {
            $.box({
                imageClass:"box_warning",
                text:"<ul>" + msg + "</ul>",
                title:"Error",
                iconClose:false,
                dialog:{
                    resizable:false,
                    draggable:false,
                    closeOnEscape:false,
                    buttons:{
                        "Aceptar":function () {
                        }
                    }
                }
            });
        }

        return false
    });


</script>