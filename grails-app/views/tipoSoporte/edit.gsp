<g:form name="frm-tipoSoporte" action="save" method="post" >
    <g:hiddenField name="id" value="${tipoSoporteInstance?.id}" />
    <g:hiddenField name="version" value="${tipoSoporteInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-tipoSoporte").validate();

        $("#frm-tipoSoporte").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
