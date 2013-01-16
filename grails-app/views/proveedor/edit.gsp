<g:form name="frm-proveedor" action="save" method="post" >
    <g:hiddenField name="id" value="${proveedorInstance?.id}" />
    <g:hiddenField name="version" value="${proveedorInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-proveedor").validate();

        $("#frm-proveedor").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
