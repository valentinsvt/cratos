<g:form name="frm-tipoComprobanteSri" action="save" method="post" >
    <g:hiddenField name="id" value="${tipoComprobanteSriInstance?.id}" />
    <g:hiddenField name="version" value="${tipoComprobanteSriInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-tipoComprobanteSri").validate();

        $("#frm-tipoComprobanteSri").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
