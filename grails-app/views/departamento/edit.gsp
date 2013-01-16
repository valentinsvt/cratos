<g:form name="frm-departamento" action="save" method="post" >
    <g:hiddenField name="id" value="${departamentoInstance?.id}" />
    <g:hiddenField name="version" value="${departamentoInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-departamento").validate();

        $("#frm-departamento").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
