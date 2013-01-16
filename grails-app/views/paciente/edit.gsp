<g:form name="frm-paciente" action="save" method="post" >
    <g:hiddenField name="id" value="${pacienteInstance?.id}" />
    <g:hiddenField name="version" value="${pacienteInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-paciente").validate();

        $("#frm-paciente").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
