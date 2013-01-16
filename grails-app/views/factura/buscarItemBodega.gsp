<table border="1" style="border-collapse: collapse; width: 100%;">
    <thead>
        <tr>
            <th style="width: 50px;">Cant.</th>
            <th>Marca</th>
            <th>Código</th>
            <th>Nombre</th>
            <th>Precio</th>
            <th>Descripción</th>
        </tr>
    </thead>
    <tbody>
        <g:each in="${results}" var="r">
            <tr class="item" id="${r.item.id}" data_iva="${r.item.iva}" data-max="${r.cantidad}">
                <td class="cantidad" style="text-align:right;">${r.cantidad}</td>
                <td class="marca">${r.item.marca?.descripcion}</td>
                <td class="codigo">${r.item.codigo}</td>
                <td class="nombre">${r.item.nombre}</td>
                <td class="precio" data_precio="${r.item.precioVenta}" style="text-align:right;"><g:formatNumber number="${r.item.precioVenta}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                <td>${r.item.observaciones}</td>
                <input type="hidden" class="bodega" value="${r.bodega.id}">
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
                    var conIva = tr.attr("data_iva");
                    var codigo = tr.find(".codigo").text();
                    var nombre = tr.find(".nombre").text();
                    var precio = tr.find(".precio").attr("data_precio");
                    var cant = tr.find(".cantidad").text();
                    var bodega = tr.find(".bodega").val();
                    var cant = 1;
                    var total = parseFloat(precio) * cant;

                    $("#txtItem").val(nombre);
                    $("#tdCodigo").text(codigo);
                    $("#txtPrecio").val(number_format(precio, 2, ".", ""));
                    $("#txtCantidad").val(1);
                    $("#txtDescuento").val(0);
                    $("#tdPrecioT").text(number_format(total, 2, ".", "")).css({textAlign : "right"});

                    var obj = {
                        id            : itemId,
                        codigo        : codigo,
                        nombre        : nombre,
                        conIva        : parseInt(conIva),
                        precio        : parseFloat(precio),
                        cantidad      : cant,
                        max           : tr.data("max"),
                        descuento     : 0,
                        total         : total,
                        observaciones : "",
                        bodega        : bodega
                    };

                    $("#tdItem").data("item", obj);

                    $("#dlgBuscar").dialog("close");
                });
    })
    ;
</script>