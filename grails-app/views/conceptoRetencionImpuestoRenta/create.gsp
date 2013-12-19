<g:form name="frm-conceptoRetencionImpuestoRenta" action="save" >
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
