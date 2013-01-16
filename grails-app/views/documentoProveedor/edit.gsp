<g:form name="frm-documentoProveedor" action="save" method="post" >
    <g:hiddenField name="id" value="${documentoProveedorInstance?.id}" />
    <g:hiddenField name="version" value="${documentoProveedorInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-documentoProveedor").validate();

        $("#frm-documentoProveedor").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
