<g:form name="frm-tipoContrato" action="save" method="post" >
    <g:hiddenField name="id" value="${tipoContratoInstance?.id}" />
    <g:hiddenField name="version" value="${tipoContratoInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-tipoContrato").validate();

        $("#frm-tipoContrato").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
