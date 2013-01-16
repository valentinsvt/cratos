<g:form name="frm-color" action="save" method="post" >
    <g:hiddenField name="id" value="${colorInstance?.id}" />
    <g:hiddenField name="version" value="${colorInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-color").validate();

        $("#frm-color").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
