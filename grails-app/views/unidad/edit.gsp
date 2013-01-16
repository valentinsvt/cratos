<g:form name="frm-unidad" action="save" method="post" >
    <g:hiddenField name="id" value="${unidadInstance?.id}" />
    <g:hiddenField name="version" value="${unidadInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-unidad").validate();

        $("#frm-unidad").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
