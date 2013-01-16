<g:form name="frm-tipoRelacion" action="save" method="post" >
    <g:hiddenField name="id" value="${tipoRelacionInstance?.id}" />
    <g:hiddenField name="version" value="${tipoRelacionInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-tipoRelacion").validate();

        $("#frm-tipoRelacion").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
