<%@ page import="cratos.Existencias" %>
<table border="1" style="border-collapse: collapse; width: 100%;">
    <thead>
    <tr>
        <th>Marca</th>
        <th>Código</th>
        <th>Nombre</th>
        <th>Precio</th>
        <th>Descripción</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${results}" var="r">

        %{--<g:if test="${cratos.Existencias.findAllByItem(r).size() > 0}">--}%
            %{--<g:set var="precio" value="${cratos.Existencias.withCriteria {--}%
                %{--eq('item', r)--}%
                %{--projections {--}%
                    %{--max "precio"--}%
                %{--}--}%
            %{--}[0]}"/>--}%
        %{--</g:if>--}%
        %{--<g:else>--}%
            <g:set var="precio" value="${r.precioCosto}"/>
        %{--</g:else>--}%

        <tr class="item" id="${r.id}"
            data-iva="${r.iva}" data-id="${r.id}" data-codigo="${r.codigo}" data-nombre="${r.nombre}"
            data-precio="${precio}">
            <td class="marca">
                ${r?.marca?.descripcion}
            </td>
            <td class="codigo">
                ${r.codigo}
            </td>
            <td class="nombre">
                ${r.nombre}
            </td>

            <td class="precio" style="text-align:right;">
                <g:formatNumber number="${precio}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/>
            </td>
            <td>${r.observaciones}</td>
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
                    var itemId = tr.data("id");
                    var conIva = tr.data("iva");
                    var codigo = tr.data("codigo");
                    var nombre = tr.data("nombre");
                    var precio = tr.data("precio");

                    var cant = 1;
                    var total = parseFloat(precio) * cant;

                    $("#txtItem").val(nombre);
                    $("#tdCodigo").text(codigo);
                    $("#txtPrecio").val(number_format(precio, 2, ".", ""));
                    $("#txtCantidad").val(1);
                    $("#txtDescuento").val(0);
                    $("#tdPrecioT").text(number_format(total, 2, ".", "")).css({textAlign:"right"});

                    var obj = {
                        id:itemId,
                        codigo:codigo,
                        nombre:nombre,
                        conIva:parseInt(conIva),
                        precio:parseFloat(precio),
                        cantidad:1,
                        descuento:0,
                        total:total,
                        observaciones:""
                    };

                    $("#tdItem").data("item", obj);
//                    console.log("1",obj);
                    $("#dlgBuscar").dialog("close");
                });
    });
</script>