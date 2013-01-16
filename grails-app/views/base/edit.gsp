<g:form name="frm-base" action="save" method="post" >
    <g:hiddenField name="id" value="${baseInstance?.id}" />
    <g:hiddenField name="version" value="${baseInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-base").validate();

        $("#frm-base").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
