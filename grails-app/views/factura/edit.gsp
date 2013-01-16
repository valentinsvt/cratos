<%@ page import="cratos.Factura" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'factura.label', default: 'Factura')}"/>
    <title>Editar Factura</title>
</head>

<body>
<a href="#edit-factura" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                              default="Skip to content&hellip;"/></a>

<div id="edit-factura" class="content scaffold-edit" role="main">

    <div class="ui-widget-header ui-corner-all nav navegacion">
        <ul style="margin-bottom:0;">
            <li><g:link class="list linkButton" action="list">Lista</g:link></li>
            <li><g:link class="create linkButton" action="create">Crear Factura</g:link></li>
        </ul>
    </div>

    <g:form name="form-factura" action="save">
        <div class="contenedor">
            <h1>Editar Factura</h1>

            <g:if test="${flash.message}">
                <div class="message ${flash.clase}" role="status"><span
                        class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                </div>
            </g:if>
            <g:hasErrors bean="${facturaInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${facturaInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:render template="form"/>
        </div>

        <div class="ui-widget-header buttons botones">
            <g:actionSubmit class="save" action="save" value="Guardar"/>
            <g:actionSubmit class="delete" action="delete" value="Eliminar" formnovalidate=""
                            onclick="return confirm('Está seguro?');"/>
            <g:link class="cancel linkButton" action="show" id="${facturaInstance.id}">Ver</g:link>
        </div>
    </g:form>
</div>

<script type="text/javascript">
    $(function () {
        $(".field").qtip();

        $("form-factura").validate({
            errorClass:"invalid"
        });
    });
</script>

</body>
</html>
