<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>cp</title>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/css/bnw', file: 'jquery-ui-1.8.17.custom.css')}" type="text/css"/>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-1.7.1.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-ui-1.8.17.custom.min.js')}"></script>
</head>

<script type="text/javascript">
    function getCookie(name)
    {
        var i,x,y,ARRcookies=document.cookie.split(";");
        for (i=0;i<ARRcookies.length;i++)
        {
            x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
            y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
            x=x.replace(/^\s+|\s+$/g,"");
            if (x==name)
            {
                return (y);
            }
        }
    }
</script>
<body>


<div id="dlg">
    %{--<iframe src="http://www.google.com/ig" style="width: 600px;height: 400px;"></iframe>--}%
</div>
<div id="dlg2">
    %{--<iframe src="http://www.google.com/ig" style="width: 600px;height: 400px;"></iframe>--}%
</div>



</body>
<script type="text/javascript">
    $(function() {
        $( "#dlg" ).dialog({
            width:620,
            height:450,
            position:"center"
        });
    });
    $(function() {
        $( "#dlg2" ).dialog({
            width:620,
            height:450,
            position:[20,20]
        });
    });
</script>
</html>