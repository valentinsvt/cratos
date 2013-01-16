<g:form name="frm-nivel" action="save" method="post" >
    <g:hiddenField name="id" value="${nivelInstance?.id}" />
    <g:hiddenField name="version" value="${nivelInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-nivel").validate();

        $("#frm-nivel").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
