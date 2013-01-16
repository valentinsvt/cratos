<g:form name="frm-rubroTipoContrato" action="save" method="post" >
    <g:hiddenField name="id" value="${rubroTipoContratoInstance?.id}" />
    <g:hiddenField name="version" value="${rubroTipoContratoInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-rubroTipoContrato").validate();

        $("#frm-rubroTipoContrato").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
