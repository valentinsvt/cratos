<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main"/>
    <g:includeJQuery archivo="transacciones"/>
    <title>Transacciones anuladas</title>
    <style type="text/css">
    .etiqueta {
        width       : 100px;
        height      : 20px;
        line-height : 20px;
        font-weight : bold;
        display     : inline-block;
    }
    </style>
</head>
<body>
<div class="container entero ui-corner-all">
    <fieldset style="margin-left: 25px;width: 800px;float: left" class="ui-corner-all">
        <legend>Transacciones anuladas</legend>
        <b>Contabilidad:</b> <g:select name="contabilidad"  id="contabilidad" from="${cratos.Contabilidad.findAllByInstitucion(session.empresa,[sort:'id',order:'desc'])}" value="${contabilidad.id}" optionKey="id"></g:select>
        <table style="margin-top: 10px;border: 1px solid black;padding:5px;">
            <thead>
            <tr>
                <th>Descripción</th>
                <th>Fecha</th>
                <th>Comprobate</th>
                <th>Valor</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${procesos}" var="p">
                <tr>
                    <td>${p.descripcion}</td>
                    <td>${p.fecha.format("dd/MM/yyyy")}</td>
                    <g:set var="comp" value="${cratos.Comprobante.findByProceso(p)}"></g:set>
                    <g:if test="${comp}">
                        <td><g:link controller="proceso" action="verComprobante" id="${comp.id}">${comp?.prefijo+""+comp?.numero}</g:link></td>
                    </g:if>
                    <g:else>
                        <td></td>
                    </g:else>
                    <td style="text-align: right">${(p.valor+p.impuesto).round(2)}</td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </fieldset>
</div>
<script type="text/javascript">
    $("#contabilidad").change(function(){
        location.href="${g.createLink(controller: 'proceso',action: 'procesosAnulados')}?contabilidad="+$(this).val()
    })
</script>
</body>
</html>