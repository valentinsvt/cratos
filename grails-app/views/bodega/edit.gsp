<g:form name="frm-bodega" action="save" method="post" >
    <g:hiddenField name="id" value="${bodegaInstance?.id}" />
    <g:hiddenField name="version" value="${bodegaInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-bodega").validate();

        $("#frm-bodega").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
