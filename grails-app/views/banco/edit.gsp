<g:form name="frm-banco" action="save" method="post" >
    <g:hiddenField name="id" value="${bancoInstance?.id}" />
    <g:hiddenField name="version" value="${bancoInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-banco").validate();

        $("#frm-banco").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
