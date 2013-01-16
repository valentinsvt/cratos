<g:form name="frm-nacionales" action="save" method="post" >
    <g:hiddenField name="id" value="${nacionalesInstance?.id}" />
    <g:hiddenField name="version" value="${nacionalesInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-nacionales").validate();

        $("#frm-nacionales").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
