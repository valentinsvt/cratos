<%@ page import="cratos.seguridad.Prfl; cratos.seguridad.Accn" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Configuracion del menu</title>
    <meta name="layout" content="main"/>
</head>
<body>
<div class="dialog" title="Configuracion de menu">


    <div class="body">
        <g:if test="${flash.message}">
            <div class="message ui-state-highlight ui-corner-all">
                <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
        </g:if>
        <g:hasErrors bean="${personaInstance}">
            <div class="errors ui-state-error ui-corner-all">
                <g:renderErrors bean="${personaInstance}" as="list"/>
            </div>
        </g:hasErrors>
        <g:form action="save" class="frmMenu" method="post">
            <div style="width: 600px; height: 40px;margin-bottom: 5px;margin-top: 10px;">
                Perfil: <g:select from="${Prfl.list()}" optionKey="id" id="perfil" noSelection="${[0:'Seleccione']}" name="perfil"/>
                <a href="#" id="nuevoPerfil">Nuevo</a>
            </div>
            <div id="tabla">

            </div>

        </g:form>
    </div>
</div>

<script>
    $(function() {

        $("#nuevoPerfil").button().click(function(){
            location.href="${createLink(controller:'prfl',action:'create')}"
        });
        $("#perfil").change(function(){
            if($("#perfil").val()!="0")
                cargar()
        });


        function cargar(){
            $.ajax({
                        type: "POST",
                        url: "${createLink(action:'cargarAccionesPerfil')}",
                        data: {
                            perfil:$("#perfil").val()
                        },
                        success: function(msg) {
                            $("#tabla").html(msg);
                        }
                    });
        }
    });
</script>
</body>
</html>