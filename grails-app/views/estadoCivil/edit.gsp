<g:form name="frm-estadoCivil" action="save" method="post" >
    <g:hiddenField name="id" value="${estadoCivilInstance?.id}" />
    <g:hiddenField name="version" value="${estadoCivilInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-estadoCivil").validate();

        $("#frm-estadoCivil").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
