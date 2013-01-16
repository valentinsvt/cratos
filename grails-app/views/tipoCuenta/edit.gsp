<g:form name="frm-tipoCuenta" action="save" method="post" >
    <g:hiddenField name="id" value="${tipoCuentaInstance?.id}" />
    <g:hiddenField name="version" value="${tipoCuentaInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-tipoCuenta").validate();

        $("#frm-tipoCuenta").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
