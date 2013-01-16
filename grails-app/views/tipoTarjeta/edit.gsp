<g:form name="frm-tipoTarjeta" action="save" method="post" >
    <g:hiddenField name="id" value="${tipoTarjetaInstance?.id}" />
    <g:hiddenField name="version" value="${tipoTarjetaInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-tipoTarjeta").validate();

        $("#frm-tipoTarjeta").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
