<g:each in="${consumos}" var="consumo">
    <tr id="${consumo.item?.id}">
        <td class="cantidad">
            ${consumo.cantidad}
        </td>
        <td class="codigo">
            ${consumo.item?.codigo}
        </td>
        <td class="nombre">
            ${consumo.item?.nombre}
        </td>
        <td class="precio">
            ${consumo.precioUnitario}
        </td>
        <td class="descuento">
            ${consumo.descuento}
        </td>
        <td class="total">
            ${consumo.cantidad * consumo.precioUnitario - (consumo.precioUnitario * consumo.descuento * consumo.cantidad)}
        </td>
        <td class="observaciones">
            ${consumo.observaciones}
        </td>
        <g:if test="${update == true || update == 'true'}">
            <td>
                <a href='#' class="editar" id="editar_${consumo.id}">Editar</a>
                <a href='#' class="eliminar" id="eliminar_${consumo.id}">Eliminar</a>
            </td>
        </g:if>
    </tr>
</g:each>


<script type="text/javascript">
    $(".editar").button({
        text  : false,
        icons : {
            primary : "ui-icon-pencil"
        }
    }).css({
                width  : 15,
                height : 15
            }).click(function () {
                var tr = $(this).parents("tr");
                $(".selected").removeClass("selected");
                tr.addClass("selected");
                var parts = $(this).attr("id").split("_");
                var id = parts[1];
                var item = {
                    id            : tr.attr("id"),
                    consumo       : id,
                    nombre        : trim(tr.find(".nombre").text()),
                    codigo        : trim(tr.find(".codigo").text()),
                    precio        : parseFloat(trim(tr.find(".precio").text())),
                    cantidad      : parseFloat(trim(tr.find(".cantidad").text())),
                    descuento     : parseFloat(trim(tr.find(".descuento").text())),
                    total         : parseFloat(trim(tr.find(".total").text())),
                    observaciones : trim(tr.find(".observaciones").text())
                };

                $("#tdItem").data("item", item);
                $("#txtId").val(item.id);
                $("#txtItem").val(item.nombre);
                $("#tdCodigo").text(item.codigo);
                $("#txtPrecio").val(number_format(item.precio, 2, ".", ""));
                $("#txtCantidad").val(item.cantidad);
                $("#txtDescuento").val(item.descuento);
                $("#tdPrecioT").text(number_format(item.total, 2, ".", "")).css({textAlign : "right"});
                $("#txaObservaciones").val(item.observaciones);

                $("#btnAdd").button("option", "icons", {primary : "ui-icon-disk"});
            });
    $(".eliminar").button({
        text  : false,
        icons : {
            primary : "ui-icon-trash"
        }
    }).css({
                width      : 15,
                height     : 15,
                marginLeft : 20
            }).click(function () {
                var tr = $(this).parents("tr");
                $(".selected").removeClass("selected");
                tr.addClass("selected");
                var parts = $(this).attr("id").split("_");
                var id = parts[1];
                if (confirm("Esta seguro que desea eliminar el item?")) {
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action: 'deleteItem')}",
                        data    : {
                            id : id
                        },
                        success : function (msg) {
                            tr.remove();
                        }
                    });
                }
            });
</script>