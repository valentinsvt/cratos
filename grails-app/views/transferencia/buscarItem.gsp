<table border="1" style="border-collapse: collapse; width: 100%;">
    <thead>
        <tr>
            <td colspan="5" style="text-align:center;">
                Items en la bodega <strong>${bodega.descripcion}</strong>
            </td>
        </tr>
        <tr>
            <th>Nombre</th>
            <th>Marca</th>
            <th>Código</th>
            <th>Precio</th>
            <th>Cantidad</th>
        </tr>
    </thead>
    <tbody>
        <g:each in="${results}" var="rr">
            <g:set var="r" value="${rr.item}"/>
            <tr class="item" id="${r.id}" data-iva="${r.iva}" data-max="${rr.cantidad}" data-precio="${r.precioCosto}">
                <td class="nombre">${r.nombre}</td>
                <td class="marca">${r.marca?.descripcion}</td>
                <td class="codigo">${r.codigo}</td>
                <td class="precio" style="text-align:right;"><g:formatNumber number="${r.precioCosto}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                <td class="cantidad" style="text-align:right;"><g:formatNumber number="${rr.cantidad}" minFractionDigits="2" maxFractionDigits="2"/></td>
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
                    var precio = tr.data("precio");
                    var max = tr.data("max");

                    var cant = 1;
                    var total = parseFloat(precio) * cant;

                    $("#txtItem").val(nombre);
                    $("#tdCodigo").text(codigo);
                    $("#txtPrecio").val(number_format(precio, 2, ".", ""));
                    $("#txtCantidad").val(1);
                    $("#txtDescuento").val(0);
                    $("#tdPrecioT").text(number_format(total, 2, ".", "")).css({textAlign : "right"});

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
                        max       : max
//                        observaciones : ""
                    };

                    $("#tdItem").data("item", obj);
//                    $("#btnUpdatePrecio").attr("item", itemId);

                    $("#dlgBuscar").dialog("close");

                });
    });
</script>


