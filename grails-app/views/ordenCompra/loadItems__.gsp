<g:each in="${items}" var="detalle">
    <tr>
        <td style="text-align: right;">
            <g:formatNumber number="${detalle.cantidad}" maxFractionDigits="2" minFractionDigits="2"/>
        </td>
        <td>
            ${detalle.item.codigo}
        </td>
        <td>
            ${detalle.item.nombre}
        </td>
        <td style="text-align: right;">
            <g:formatNumber number="${detalle.precioUnitario}" maxFractionDigits="2" minFractionDigits="2"/>
        </td>
        <td style="text-align: right;">
            <g:formatNumber number="${detalle.cantidad * detalle.precioUnitario}" maxFractionDigits="2" minFractionDigits="2"/>
        </td>
        <td>
            ...
        </td>
    </tr>
</g:each>