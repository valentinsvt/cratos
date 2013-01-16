<g:form name="frm-tipoEmpresa" action="save" method="post" >
    <g:hiddenField name="id" value="${tipoEmpresaInstance?.id}" />
    <g:hiddenField name="version" value="${tipoEmpresaInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-tipoEmpresa").validate();

        $("#frm-tipoEmpresa").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
