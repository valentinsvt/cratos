<g:form name="frm-marca" action="save" method="post" >
    <g:hiddenField name="id" value="${marcaInstance?.id}" />
    <g:hiddenField name="version" value="${marcaInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-marca").validate();

        $("#frm-marca").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
