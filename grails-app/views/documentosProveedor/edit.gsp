<g:form name="frm-documentosProveedor" action="save" method="post" >
    <g:hiddenField name="id" value="${documentosProveedorInstance?.id}" />
    <g:hiddenField name="version" value="${documentosProveedorInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-documentosProveedor").validate();

        $("#frm-documentosProveedor").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
