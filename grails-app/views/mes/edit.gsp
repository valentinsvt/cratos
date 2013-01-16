<g:form name="frm-mes" action="save" method="post" >
    <g:hiddenField name="id" value="${mesInstance?.id}" />
    <g:hiddenField name="version" value="${mesInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-mes").validate();

        $("#frm-mes").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
