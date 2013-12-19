<g:form name="frm-conceptoRetencionImpuestoRenta" action="save" method="post" >
    <g:hiddenField name="id" value="${conceptoRetencionImpuestoRentaInstance?.id}" />
    <g:hiddenField name="version" value="${conceptoRetencionImpuestoRentaInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-conceptoRetencionImpuestoRenta").validate();

        $("#frm-conceptoRetencionImpuestoRenta").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
