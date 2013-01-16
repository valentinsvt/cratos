<g:form name="frm-fuente" action="save" method="post" >
    <g:hiddenField name="id" value="${fuenteInstance?.id}" />
    <g:hiddenField name="version" value="${fuenteInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-fuente").validate();

        $("#frm-fuente").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
