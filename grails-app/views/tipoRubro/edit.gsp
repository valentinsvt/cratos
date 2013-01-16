<g:form name="frm-tipoRubro" action="save" method="post" >
    <g:hiddenField name="id" value="${tipoRubroInstance?.id}" />
    <g:hiddenField name="version" value="${tipoRubroInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-tipoRubro").validate();

        $("#frm-tipoRubro").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
