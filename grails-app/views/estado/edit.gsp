<g:form name="frm-estado" action="save" method="post" >
    <g:hiddenField name="id" value="${estadoInstance?.id}" />
    <g:hiddenField name="version" value="${estadoInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-estado").validate();

        $("#frm-estado").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
