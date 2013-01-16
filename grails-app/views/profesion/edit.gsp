<g:form name="frm-profesion" action="save" method="post" >
    <g:hiddenField name="id" value="${profesionInstance?.id}" />
    <g:hiddenField name="version" value="${profesionInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-profesion").validate();

        $("#frm-profesion").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
