<%@ page import="cratos.Persona" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'persona.label', default: 'Persona')}"/>
        <title>Crear Persona</title>
    </head>

    <body>
        <a href="#create-persona" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="create-persona" class="content scaffold-create" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion" role="navigation">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                </ul>
            </div>
            <g:form name="form-persona" action="save" >
            <div class="contenedor">
                <h1>Crear Persona</h1>

                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>
                <g:hasErrors bean="${personaInstance}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${personaInstance}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                    </ul>
                </g:hasErrors>
                <g:render template="form"/>
            </div>

            <div class="ui-widget-header buttons botones">
                <g:actionSubmit class="save" action="save" value="Guardar"/>
            </div>
            </g:form>
        </div>

        <script type="text/javascript">
            $(function () {
                $(".field").qtip();

                $("#unidad-form").validate({
                    errorClass: "invalid"
                });
            });
        </script>

    </body>
</html>
