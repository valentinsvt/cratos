<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<head>
        <meta name="layout" content="main">
        <title>Reportes</title>

        <style type="text/css">
        .lista, .desc {
            float       : left;
            min-height  : 150px;
            margin-left : 25px;
        }

        .lista {
            width : 615px;
        }

        .desc {
            width : 265px;
        }

        .link {
            font-weight     : bold;
            text-decoration : none;
        }

        .noBullet {
            list-style : none;
            margin     : 1em;
            padding    : 0;
        }

        .noBullet li {
            margin-bottom : 10px;
        }

        .linkHover {
            text-decoration : overline underline;
        }
        </style>

    </head>
</head>
<body>
<div id="list-empresa" class="content scaffold-list" role="main">

<g:form action="grabarCuentaResultado" name="res_form" style="padding-left: 30px;padding-top: 20px">
    <g:if test="${flash.message}">
        <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
        </div>
    </g:if>
    <p style="float: left;width: 90%;font-size: 14px;border-bottom:1px solid black;font-weight: bold ">
        Por favor seleccione las cuentas para el calculo de resultado del ejercicio
    </p>
    <div class="span-20 " style="float: left">
        <div class="span-5 ">
            <label style="padding-top: 5px;" >
                Cuenta de Superavit
            </label>
        </div>

        <div class="span-5">
            <g:select name="super" from="${cuentas}" optionKey="id" value="${cuentaS?.id}" ></g:select>
        </div>
    </div>

    <div class="span-20" style="float: left">
        <div class="span-5 ">
            <label>
                Cuenta de Deficit
            </label>
        </div>
        <div class="span-5">
            <g:select name="deficit" from="${cuentas}" optionKey="id" value="${cuentaD?.id}"></g:select>
        </div>
    </div>
    <div class="span-9  " style="margin-top: 20px;">
        <div class="span-3 ">
            <input type="submit" id="sub" value="Grabar">
        </div>
    </div>
</g:form>
</div>
    <script type="text/javascript">
        $("#sub").button()
    </script>
</body>
</html>