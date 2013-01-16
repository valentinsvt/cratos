<g:form name="frm-tipoDocumentoProveedor" action="save" method="post" >
    <g:hiddenField name="id" value="${tipoDocumentoProveedorInstance?.id}" />
    <g:hiddenField name="version" value="${tipoDocumentoProveedorInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-tipoDocumentoProveedor").validate();

        $("#frm-tipoDocumentoProveedor").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
