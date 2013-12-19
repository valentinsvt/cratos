<g:form name="frm-sustentoTributario" action="save" method="post" >
    <g:hiddenField name="id" value="${sustentoTributarioInstance?.id}" />
    <g:hiddenField name="version" value="${sustentoTributarioInstance?.version}" />
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    $(function() {
        $("#frm-sustentoTributario").validate();

        $("#frm-sustentoTributario").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
