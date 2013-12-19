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
                    <label>Período</label> <g:select name="periodo" from="${periodos}"/>
                    <label>Fecha de Registro Contable</label>
                    <g:set var="anio" value="${new Date().format('yyyy')}"/>
                    <g:set var="mes" value="${new Date().format('MM').toInteger()}"/>
                    <elm:datePicker class="field ui-corner-all" name="fechaIngresoSistema" title="fecha"
                                    minDate="'-1m'" maxDate="new Date()"
                                    style="width: 80px; margin-left: 5px" format="yyyy-MM-dd" value="${proceso?.fechaIngresoSistema}"/>
                    <label>Sustento Tributario</label>
                </div>
            </div>
        </g:form>
        <script type="text/javascript">

        </script>

    </body>
</html>