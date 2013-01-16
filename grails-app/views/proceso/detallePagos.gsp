<g:if test="${!pagos}">
    <div class="errors" style="padding-left: 10px;">
        No hay pagos registrados para este auxiliar
    </div>
</g:if>
<g:if test="${pagos.size() > 0}">
    <g:set var="totalD" value="${0}"/>
    <g:set var="totalH" value="${0}"/>


    <table width="700px">
    <thead>
      <tr>
      <th>Fecha</th>
      <th>Factura</th>
      <th>Monto</th>
      <th></th>
      </tr>
    </thead>
    <tbody style="border:1px solid black">

    <g:set var="tot" value="${0}"/>
    <g:each var="p" in="${pagos}" status="i">
        <tr>
            <td>${p.fecha.format("dd/MM/yyyy")}</td>
            <td>${p.factura}</td>
            <td style="text-align: right;">
                <g:formatNumber number="${p.monto}" minFractionDigits="2" maxFractionDigits="2"/>
            </td>
            <g:set var="tot" value="${tot.toDouble() + p.monto}"></g:set>
        </tr>
    </g:each>
    <tr>
        <td>TOTAL:</td>
        <td></td>
        <td style="background-color: #d0ffd0;text-align: right">
            <g:formatNumber number="${tot}" minFractionDigits="2" maxFractionDigits="2"/>
        </td>
        <td>&nbsp;</td>
    </tr>
    </tbody>
    </tbody>
  </table>

</g:if>