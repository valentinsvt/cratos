<g:form name="frm-documentosProceso" action="save" method="post" >
    <g:hiddenField name="id" value="${documentosProcesoInstance?.id}" />
    <g:hiddenField name="version" value="${documentosProcesoInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-documentosProceso").validate();

        $("#frm-documentosProceso").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
