<g:form name="frm-centroCosto" action="save" method="post" >
    <g:hiddenField name="id" value="${centroCostoInstance?.id}" />
    <g:hiddenField name="version" value="${centroCostoInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-centroCosto").validate();

        $("#frm-centroCosto").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
