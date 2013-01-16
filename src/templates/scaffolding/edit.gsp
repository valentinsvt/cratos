<g:form name="frm-${domainClass.propertyName}" action="save" method="post" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
    <g:hiddenField name="id" value="\${${propertyName}?.id}" />
    <g:hiddenField name="version" value="\${${propertyName}?.version}" />
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
