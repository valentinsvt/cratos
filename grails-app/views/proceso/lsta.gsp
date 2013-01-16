<%@ page import="cratos.Presupuesto" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'presupuesto.label', default: 'Proceso')}" />
    <title>Transacciones contables</title>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.livequery.js')}"></script>
</head>
<body>
<div class="container entero ui-corner-all">

    <fieldset style="width: 900px;border: none;margin-top: 30px;" class="ui-corner-all">
        <legend>
            Transacciones contables
        </legend>
        <g:link class="btn ui-corner-all" action="nuevoProceso" style="color: white !important;">Nuevo</g:link>

        <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
        </g:if>

        <bsc:buscador name="proceso.id" value="${proceso?.id}"  accion="listar" campos="${campos}" label="Transacción" tipo="lista"/>
        <br>
    </fieldset>


      <script type="text/javascript">
          $(".btn").button()
      </script>

</div>
</body>
</html>
