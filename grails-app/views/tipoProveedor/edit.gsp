<g:form name="frm-tipoProveedor" action="save" method="post" >
    <g:hiddenField name="id" value="${tipoProveedorInstance?.id}" />
    <g:hiddenField name="version" value="${tipoProveedorInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-tipoProveedor").validate();

        $("#frm-tipoProveedor").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
