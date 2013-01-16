<%@ page import="cratos.seguridad.Modulo" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName"
           value="${message(code: 'modulo.label', default: 'Modulo')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="dialog" title="${title}">
    <div id="" class="toolbar ui-widget-header ui-corner-all">
        <a class="button home" href="${createLinkTo(dir: '')}">
            <g:message code="home" default="Home"/>
        </a>
        <g:link class="button list" action="list">
            <g:message code="modulo.list" default="Modulo List"/>
        </g:link>
        <g:link class="button create" action="create">
            <g:message code="default.new.label" args="[entityName]"/>
        </g:link>
    </div> <!-- toolbar -->

    <div class="body">
        <g:if test="${flash.message}">
            <div class="message ui-state-highlight ui-corner-all">${flash.message}</div>
        </g:if>
        <div>

            <fieldset class="ui-corner-all">
                <legend class="ui-widget ui-widget-header ui-corner-all">
                    <g:message code="modulo.show.legend"
                               default="Modulo details"/>
                </legend>


                <div class="prop">
                    <label>
                        <g:message code="modulo.id.label"
                                   default="Id"/>
                    </label>

                    <div class="campo">

                        ${fieldValue(bean: moduloInstance, field: "id")}

                    </div> <!-- campo -->
                </div> <!-- prop -->


                <div class="prop">
                    <label>
                        <g:message code="modulo.descripcion.label"
                                   default="Descripcion"/>
                    </label>

                    <div class="campo">

                        ${fieldValue(bean: moduloInstance, field: "descripcion")}

                    </div> <!-- campo -->
                </div> <!-- prop -->


                <div class="prop">
                    <label>
                        <g:message code="modulo.nombre.label"
                                   default="Nombre"/>
                    </label>

                    <div class="campo">

                        ${fieldValue(bean: moduloInstance, field: "nombre")}

                    </div> <!-- campo -->
                </div> <!-- prop -->


                <div class="prop">
                    <label>
                        <g:message code="modulo.orden.label"
                                   default="Orden"/>
                    </label>

                    <div class="campo">

                        ${fieldValue(bean: moduloInstance, field: "orden")}

                    </div> <!-- campo -->
                </div> <!-- prop -->


                <div class="buttons">
                    <g:link class="button edit" action="edit" id="${moduloInstance?.id}">
                        <g:message code="default.button.update.label" default="Edit"/>
                    </g:link>
                    <g:link class="button delete" action="delete" id="${moduloInstance?.id}">
                        <g:message code="default.button.delete.label" default="Delete"/>
                    </g:link>
                </div>

            </fieldset>
        </div>
    </div> <!-- body -->
</div> <!-- dialog -->

<script type="text/javascript">
    $(function() {
        $(".button").button();
        $(".home").button("option", "icons", {primary:'ui-icon-home'});
        $(".list").button("option", "icons", {primary:'ui-icon-clipboard'});
        $(".create").button("option", "icons", {primary:'ui-icon-document'});

        $(".edit").button("option", "icons", {primary:'ui-icon-pencil'});
        $(".delete").button("option", "icons", {primary:'ui-icon-trash'}).click(function() {
            if (confirm("${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}")) {
                return true;
            }
            return false;
        });
    });
</script>

</body>
</html>
