<g:form name="frm-tipoPersona" action="save" method="post" >
    <g:hiddenField name="id" value="${tipoPersonaInstance?.id}" />
    <g:hiddenField name="version" value="${tipoPersonaInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-tipoPersona").validate();

        $("#frm-tipoPersona").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
