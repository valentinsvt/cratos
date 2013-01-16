<g:form name="frm-activoFijo" action="save" method="post" >
    <g:hiddenField name="id" value="${activoFijoInstance?.id}" />
    <g:hiddenField name="version" value="${activoFijoInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-activoFijo").validate();

        $("#frm-activoFijo").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
