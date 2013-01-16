<g:form name="frm-tipoComprobanteId" action="save" method="post" >
    <g:hiddenField name="id" value="${tipoComprobanteIdInstance?.id}" />
    <g:hiddenField name="version" value="${tipoComprobanteIdInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-tipoComprobanteId").validate();

        $("#frm-tipoComprobanteId").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
