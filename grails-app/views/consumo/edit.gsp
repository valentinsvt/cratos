<%@ page import="cratos.Consumo" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'consumo.label', default: 'Consumo')}"/>
        <title>Editar Consumo</title>
    </head>

    <body>
        <a href="#edit-consumo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="edit-consumo" class="content scaffold-edit" role="main">

            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                    <li><g:link class="create linkButton" action="create">Crear Consumo</g:link></li>
                </ul>
            </div>

            <g:form name="form-consumo" action="save" >
            <div class="contenedor">
                <h1>Editar Consumo</h1>

                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>
                <g:hasErrors bean="${consumoInstance}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${consumoInstance}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                    </ul>
                </g:hasErrors>
                <g:render template="form"/>
            </div>

            <div class="ui-widget-header buttons botones">
                <g:actionSubmit class="save" action="save" value="Guardar"/>
                <g:actionSubmit class="delete" action="delete" value="Eliminar" formnovalidate="" onclick="return confirm('Está seguro?');"/>
                <g:link class="cancel linkButton" action="show" id="${consumoInstance.id}">Ver</g:link>
            </div>
            </g:form>
        </div>

         <script type="text/javascript">
            $(function () {
                $(".field").qtip();

                $("form-consumo").validate({
                    errorClass: "invalid"
                });
            });
        </script>

    </body>
</html>
