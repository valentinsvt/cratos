<g:form name="frm-cargo" action="save" method="post" >
    <g:hiddenField name="id" value="${cargoInstance?.id}" />
    <g:hiddenField name="version" value="${cargoInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-cargo").validate();

        $("#frm-cargo").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
