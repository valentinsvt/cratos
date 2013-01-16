<g:link controller="ordenCompra" action="create" class="btnCrearOC">Crear nueva orden de compra</g:link>

<table border="1" style="border-collapse: collapse; width: 100%; margin-top: 5px;">
    <thead>
    <tr>
        <th>Fecha</th>
        <th>Descripción</th>
        <th>Valor</th>
        <th>Estado</th>
        <th>Observaciones</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${results}" var="r">
        <tr class="oc" id="${r.id}">
            <td class="fecha">${r.fecha.format("dd-MM-yyyy")}</td>
            <td class="descripcion">${r.descripcion}</td>
            <td class="valor"><g:formatNumber number="${r.valor}" maxFractionDigits="2" minFractionDigits="2"/></td>
            <td class="estado"><g:formatBoolean boolean="${r.estado == 'R'}" true="Registrada"
                                                false="No registrada"/></td>
            <td class="observaciones">${r.observaciones}</td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">

    $(function () {
        $(".btnCrearOC").button();

        $(".oc").hover(
                function () {
                    $(this).addClass("hover");
                },
                function () {
                    $(this).removeClass("hover");
                }).click(function () {
                    var tr = $(this);
                    var ocId = tr.attr("id");
                    var descripcion = tr.find(".descripcion").text();

                    $("#txtBuscarOC").val(descripcion);
                    var antId = $.trim($("#ordenes").val());
                    if(antId != ocId) {
                        resetOrden();
                    }
                    $("#ordenes").val(ocId);
                    $("#overlay").hide();
                    $("#dlgBuscarOC").dialog("close");

                });
    });
</script>


