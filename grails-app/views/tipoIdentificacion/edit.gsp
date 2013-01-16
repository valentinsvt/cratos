<g:form name="frm-tipoIdentificacion" action="save" method="post" >
    <g:hiddenField name="id" value="${tipoIdentificacionInstance?.id}" />
    <g:hiddenField name="version" value="${tipoIdentificacionInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-tipoIdentificacion").validate();

        $("#frm-tipoIdentificacion").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
