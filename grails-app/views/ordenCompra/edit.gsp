<g:form name="frm-ordenCompra" action="save" method="post">
    <g:hiddenField name="id" value="${ordenCompraInstance?.id}"/>
    <g:hiddenField name="version" value="${ordenCompraInstance?.version}"/>
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function () {
        $("#frm-ordenCompra").validate();

        $("#frm-ordenCompra").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
