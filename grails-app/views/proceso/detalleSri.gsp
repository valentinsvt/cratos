<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 12/19/13
  Time: 12:56 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
  <title>SRI</title>
</head>
<body>

<g:form name="sriForm">
    <div class="container entero ui-widget-content ui-corner-all">
        <h1 class="titulo center ui-widget-header ui-corner-all" style="margin-bottom: 5px; margin-left: 8px;height: 30px;line-height: 30px;padding-left: 30px;margin-bottom: 20px;">Detalle SRI</h1>

    <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">

    <label>Período</label> <g:select name="periodo" from="${['ENERO', 'FEBRERO', 'MARZO', 'ABRIL', 'MAYO', 'JUNIO', 'JULIO',
        'AGOSTO', 'SEPTIEMBRE', 'OCTUBRE', 'NOVIEMBRE', 'DICIEMBRE']}"/>
    <label>Fecha de Registro Contable</label>
    <label>Sustento Tributario</label>

    </div>

    </div>

</g:form>

<script type="text/javascript">

    var fecha = ${proceso?.fecha}

</script>


</body>
</html>