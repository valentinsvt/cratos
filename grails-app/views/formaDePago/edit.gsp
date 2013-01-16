<g:form name="frm-formaDePago" action="save" method="post" >
    <g:hiddenField name="id" value="${formaDePagoInstance?.id}" />
    <g:hiddenField name="version" value="${formaDePagoInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-formaDePago").validate();

        $("#frm-formaDePago").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
