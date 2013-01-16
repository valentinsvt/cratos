<g:form name="frm-operador" action="save" method="post" >
    <g:hiddenField name="id" value="${operadorInstance?.id}" />
    <g:hiddenField name="version" value="${operadorInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-operador").validate();

        $("#frm-operador").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
