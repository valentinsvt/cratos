<g:form name="frm-tipoPago" action="save" method="post" >
    <g:hiddenField name="id" value="${tipoPagoInstance?.id}" />
    <g:hiddenField name="version" value="${tipoPagoInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-tipoPago").validate();

        $("#frm-tipoPago").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
