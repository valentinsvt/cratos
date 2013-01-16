<g:form name="frm-tipoFactura" action="save" method="post" >
    <g:hiddenField name="id" value="${tipoFacturaInstance?.id}" />
    <g:hiddenField name="version" value="${tipoFacturaInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-tipoFactura").validate();

        $("#frm-tipoFactura").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
