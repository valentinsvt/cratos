<g:form name="frm-adquisiciones" action="save" method="post" >
    <g:hiddenField name="id" value="${adquisicionesInstance?.id}" />
    <g:hiddenField name="version" value="${adquisicionesInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-adquisiciones").validate();

        $("#frm-adquisiciones").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
