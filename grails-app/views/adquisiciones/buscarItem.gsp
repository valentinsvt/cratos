<table border="1" style="border-collapse: collapse; width: 100%;">
    <thead>
        <tr>
            <g:if test="${ordenesCompra}">
                <th>Cantidad</th>
            </g:if>
            <th>Nombre</th>
            <th>Marca</th>
            <th>Código</th>
            <th>Precio</th>
        </tr>
    </thead>
    <tbody>
        <g:each in="${items}" var="r">
            <g:set var="cant" value="${(cants.size() > 0) ? cants[r.id.toString()] : ''}"/>
            <tr class="${cant == 0 ? 'disabled' : 'item'}" id="${r.id}" data-iva="${r.iva}" max="${(cants.size() > 0) ? cants[r.id.toString()] : 1000000}" data-ice="${r.ice}">
                <g:if test="${ordenesCompra}">
                    <td class="cantidad">
                        <g:formatNumber number="${cant}" minFractionDigits="2" maxFractionDigits="2"/>
                    </td>
                </g:if>
                <td class="nombre" id="nombre">${r.nombre}</td>
                <td class="marca" id="marca">${r.marca?.descripcion}</td>
                <td class="codigo" id="codigo">${r.codigo}</td>
                <td class="precio" id="precio" data-precio="${r.precioCosto}" style="text-align:right;"><g:formatNumber number="${r.precioCosto}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>

            </tr>
        </g:each>

    </tbody>
</table>

<script type="text/javascript">


    $(function () {

        $(".item").hover(
                function () {
                    $(this).addClass("hover");
                },
                function () {
                    $(this).removeClass("hover");
                }).click(function () {
                    var tr = $(this);
                    var itemId = tr.attr("id");
                    var conIva = tr.data("iva");
                    var codigo = tr.find(".codigo").text();
                    var nombre = tr.find(".nombre").text();
                    var marca = tr.find(".marca").text();
                    var precio = tr.find(".precio").data("precio");

                    var pctIce = tr.data("ice");
                    var pctIva = (parseInt("${iva}") / 100) * parseInt(conIva);

                    var cant = 1;
                    var total = parseFloat(precio) * cant;

                    var iva = total * pctIva;
                    var ice = parseFloat(pctIce) * total;

                    var totalTodo = total + iva + ice;

                    $("#txtItem").val(nombre);
                    $("#tdCodigo").text(codigo);
                    $("#txtPrecio").val(number_format(precio, 2, ".", ""));
                    $("#txtCantidad").val(1);
                    $("#txtDescuento").val(0);
                    $("#tdPrecioT").text(number_format(total, 2, ".", "")).css({textAlign : "right"});
                    $("#hCantidad").val(parseFloat(tr.attr("max")));

                    $("#txtIva").text(number_format(iva, 2, ".", ""));
                    $("#txtIce").text(number_format(ice, 2, ".", ""));

                    $("#spIva").text(number_format(parseFloat(pctIva) * 100, 2, ".", "") + "%");
                    $("#spIce").text(number_format(parseFloat(pctIce) * 100, 2, ".", "") + "%");

                    $("#tdTotal").text(number_format(totalTodo, 2, ".", ""));

                    var obj = {
                        id        : itemId,
                        codigo    : codigo,
                        nombre    : nombre,
                        marca     : marca,
                        conIva    : parseInt(conIva),
                        precio    : parseFloat(precio),
                        cantidad  : 1,
                        descuento : 0,
                        total     : total,
                        max       : parseFloat(tr.attr("max")),
                        iva       : iva,
                        ice       : ice,
                        pctIce    : pctIce,
                        totalTodo : totalTodo
//                        observaciones : ""
                    };

                    $("#tdItem").data("item", obj);
                    $("#btnUpdatePrecio").attr("item", itemId);

                    $("#dlgBuscar").dialog("close");

                });
    });
</script>


