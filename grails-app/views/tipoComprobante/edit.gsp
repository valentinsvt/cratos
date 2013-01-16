<g:form name="frm-tipoComprobante" action="save" method="post" >
    <g:hiddenField name="id" value="${tipoComprobanteInstance?.id}" />
    <g:hiddenField name="version" value="${tipoComprobanteInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-tipoComprobante").validate();

        $("#frm-tipoComprobante").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
