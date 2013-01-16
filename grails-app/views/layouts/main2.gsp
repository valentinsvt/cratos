<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
    <head>
        <title><g:layoutTitle default="cratos - DATA WAREHOUSE"/></title>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-1.7.1.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-ui-1.8.17.custom.min.js')}"></script>


        <link rel="stylesheet" href="${resource(dir: 'css', file: 'custom.css')}"/>
        <link rel="shortcut icon" href="${resource(dir: 'images', file: 'logo_cratos.jpg')}" type="image/x-icon"/>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.livequery.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js', file: 'funciones.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/css/bnw', file: 'jquery-ui-1.8.17.custom.css')}"/>
        <g:layoutHead/>

    </head>

    <body class="easyui-layout" style="min-width: 540px;">
        <div region="north" %{--title="North Title"--}% %{--split="true"--}% style="height:38px;padding: 3px;">
            %{--<g:generarMenuHorizontalLuzJUI/>--}%
            %{--<div region="west" split="true" title="West" style="width:300px;"></div>--}%

            <div region="center" title="${g.layoutTitle(default: 'cratos - DATA WAREHOUSE')}" style="padding:5px;background:#eee;">
                <g:layoutBody/>
            </div>


            <script type="text/javascript">
                var t;
                function format(val) {
                    var str = val < 10 ? "0" + val : val;
                    return str;
                }

                function clock() {
                    var d = new Date();
                    var str = format(d.getDate()) + "-" + format(d.getMonth() + 1) + "-" + format(d.getFullYear())
                    str += "&nbsp;&nbsp;&nbsp;"
                    str += format(d.getHours()) + ":" + format(d.getMinutes()) + ":" + format(d.getSeconds());
                    $("#reloj").html(str);
                    t = setTimeout("clock()", 1000);
                }

                setTimeout('clock()', 50);
            </script>
    </body>
</html>