<g:form name="frm-tipoDocumento" action="save" method="post" >
    <g:hiddenField name="id" value="${tipoDocumentoInstance?.id}" />
    <g:hiddenField name="version" value="${tipoDocumentoInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-tipoDocumento").validate();

        $("#frm-tipoDocumento").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
