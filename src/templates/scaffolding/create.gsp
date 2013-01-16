<g:form name="frm-${domainClass.propertyName}" action="save" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
</g:form>

<script type="text/javascript">
    \$(function() {
        \$("#frm-${domainClass.propertyName}").validate();

        \$("#frm-${domainClass.propertyName}").find("input, select, textarea").keypress(function (evt) {
            if (evt.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    });
</script>
