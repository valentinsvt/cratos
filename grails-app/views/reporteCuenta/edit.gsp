<g:form name="frm-reporteCuenta" action="save" method="post" >
    <g:hiddenField name="id" value="${reporteCuentaInstance?.id}" />
    <g:hiddenField name="version" value="${reporteCuentaInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-reporteCuenta").validate();

        $("#frm-reporteCuenta").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
