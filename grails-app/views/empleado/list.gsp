<%@ page import="cratos.Empleado" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Empleados</title>

    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}" type="text/css">

    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

    <style type="text/css">
    .etiqueta {
        width       : 80px;
        height      : 20px;
        line-height : 20px;
        font-weight : bold;
        display     : inline-block;
        margin-left: 5px;
    }
    </style>
</head>

<body>



<div class="container entero ui-widget-content ui-corner-all">
    <h1 class="titulo center ui-widget-header ui-corner-all" style="margin-bottom: 15px; margin-left: 8px;padding-left: 10px;height: 30px;line-height: 30px;width: 95%">
        Nómina
    </h1>

    <div style="width: 90%;margin-left: 15px;height: 30px;margin-bottom: 10px;">
        <g:link action="form" class="btnNew ">Nuevo</g:link>
        <a href="#" id="generar_rol">Generar rol de pagos</a>
    </div>

    <div id="list-empleado" class="content scaffold-list ui-corner-all" role="main" style="width: 95%;margin: auto;border: 1px solid black;margin-bottom: 15px;padding: 5px">
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <table id="tbl-empleado">
            <thead>
            <tr>
                <th>Cédula</th>
                <th>Nombres</th>
                <th>Cargo</th>
                <th>Dirección</th>
                <th>Teléfono</th>
                <th>E-mail</th>
                <th>Fecha Ingreso</th>
                <th>Fecha Salida</th>
                <th>Estado</th>
            </tr>
            </thead>
            <tbody id="tb-empleado">
            <g:each in="${empleadoInstanceList}" status="i" var="empleadoInstance">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${empleadoInstance.id}">
                    <td>${empleadoInstance.persona.cedula}</td>
                    <td>${empleadoInstance.persona.nombre} ${empleadoInstance.persona.apellido}</td>
                    <td>${empleadoInstance.cargo?.descripcion}</td>
                    <td>${empleadoInstance.persona.direccion}</td>
                    <td>${empleadoInstance.persona.telefono}</td>
                    <td>${empleadoInstance.persona.email}</td>
                    <td><g:formatDate date="${empleadoInstance.fechaInicio}" format="dd-MM-yyyy"/></td>
                    <td><g:formatDate date="${empleadoInstance.fechaFin}" format="dd-MM-yyyy"/></td>
                    <td>${empleadoInstance.estado}</td>
                </tr>
            </g:each>
            </tbody>
        </table>
        <g:if test="${empleadoInstanceList.size() < empleadoInstanceTotal}">
            <div class="pagination">
                <g:paginate total="${empleadoInstanceTotal}" prev="Ant." next="Sig."/>
            </div>
        </g:if>
    </div>
</div>

<ul id="menu-empleado" class="contextMenu">
    <li class="show">
        <a href="#show">Ver</a>
    </li>
    <li class="edit">
        <a href="#edit">Editar</a>
    </li>
    <li class="delete">
        <a href="#delete">Eliminar</a>
    </li>
</ul>

<div id="dlg-empleado"></div>
<div id="dlg-rol">
    <div class="etiqueta">Mes:</div>  <g:select name="mes" from="${mes}" optionKey="id" optionValue="descripcion"></g:select><br>
    <div class="etiqueta">Periodo: </div> <g:select name="periodo" from="${periodos}" id="periodos" optionKey="id" ></g:select>

</div>

<div id="dlgLoad" class="ui-helper-hidden" style="text-align:center;">
    Cargando.....Por favor espere......<br/><br/>
    <img src="${resource(dir: 'images', file: 'spinner64.gif')}" alt=""/>
</div>

<script type="text/javascript">
    function openDlg(url, id, cont, ajax, title, buttons) {
        if (ajax) {
            $("#dlgLoad").dialog("open");
            $.ajax({
                async    : false,
                type     : "POST",
                url      : url,
                data     : {
                    id : id
                },
                success  : function (msg) {
                    $("#dlg-empleado").html(msg);
                },
                complete : function () {
                    $("#dlgLoad").dialog("close");
                }
            });
            $("#dlg-empleado").dialog("option", "width", 1155).dialog("option", "minWidth", 1155);
        } else {
            $("#dlg-empleado").html(cont);
        }
        $("#dlg-empleado").dialog("option", "title", title);
        $("#dlg-empleado").dialog("option", "buttons", buttons);
        $("#dlg-empleado").dialog("open");
    }

    function submitForm() {
        if ($("#frm-empleado").valid()) {
            $("#dlgLoad").dialog("open");
            var data = $("#frm-empleado").serialize();
            var url = $("#frm-empleado").attr("action");

            $.ajax({
                type    : "POST",
                url     : url,
                data    : data,
                success : function (msg) {
//                            console.log(msg);
                    location.reload(true);
                }
            });
        }
    }

    $(function () {

        $("#generar_rol").button().click(function(){
            $("#dlg-rol").dialog("open");
        });

        $("#dlgLoad").dialog({
            modal         : true,
            autoOpen      : false,
            closeOnEscape : false,
            draggable     : false,
            resizable     : false,
            zIndex        : 9000,
            open          : function (event, ui) {
                $(event.target).parent().find(".ui-dialog-titlebar-close").remove();
            }
        });

        $("#dlg-empleado").dialog({
            modal    : true,
            autoOpen : false,
            width    : 420,
            zIndex   : 1000,
            position : ["center", 10]
        });
        $("#dlg-rol").dialog({
            modal    : true,
            autoOpen : false,
            width    : 420,
            zIndex   : 1000,
            position :"center" ,
            title:"Generar rol de pagos",
            buttons:{
                "Cancelar":function(){
                    $(this).dialog("close")
                },
                "Aceptar":function(){
                    $.ajax({
                        type    : "POST",
                        url     : "${g.createLink(controller: 'rubro',action: 'generarRol')}",
                        data    : "mes="+$("#mes").val()+"&periodo="+$("#periodos").val(),
                        success : function (msg) {
                            console.log("msg")
                           if(msg=="ok"){
                               location.href="${g.createLink(controller: 'rubro',action: 'verRol')}/?mes="+$("#mes").val()+"&periodo="+$("#periodos").val()
                           }else{
                               alert(msg)
                           }
                        }
                    });
                }
            }
        });

        $("th").hover(function () {
            $(this).addClass("hover");
            var i = $(this).index();
            $("#tb-empleado").find("tr").each(function () {
                $(this).children().eq(i).addClass("hover");
            });
        }, function () {
            $(".hover").removeClass("hover");
        });

        $("#tb-empleado").find("tr").hover(function () {
            $(this).addClass("hover");
        }, function () {
            $(".hover").removeClass("hover");
        });

        $(".btnNew").button({
            icons : {
                primary : "ui-icon-document"
            }
        }).click(function () {
                    var id = $(this).attr("id");
                    var url = $(this).attr("href");
                    var title = "Crear Empleado";
                    var buttons = {
                        "Guardar"  : function () {
                            submitForm();
                        },
                        "Cancelar" : function () {
                            $("#dlg-empleado").dialog("close");
                        }
                    };
                    openDlg(url, id, "", true, title, buttons);
                    return false;
                });

        $("#tb-empleado").find("tr").contextMenu({
                    menu : "menu-empleado"
                },
                function (action, el, pos) {
                    $("#dlg-empleado").html("");
                    var id = $(el).attr("id");
                    var title, buttons, url, cont;
                    switch (action) {
                        case "edit":
                            title = "Editar Empleado";
                            buttons = {
                                "Guardar"  : function () {
                                    submitForm();
                                },
                                "Cancelar" : function () {
                                    $("#dlg-empleado").dialog("close");
                                }
                            };
                            url = "${createLink(action:'form')}/" + id;
                            break;
                        case "show":
                            title = "Ver Empleado";
                            buttons = {
                                "Aceptar" : function () {
                                    $("#dlg-empleado").dialog("close");
                                }
                            };
                            url = "${createLink(action:'show')}/" + id;
                            break;
                        case "delete":
                            title = "Eliminar Empleado";
                            buttons = {
                                "Aceptar"  : function () {
                                    $("#dlgLoad").dialog("open");
                                    $.ajax({
                                        type    : "POST",
                                        url     : "${createLink(action:'delete')}",
                                        data    : {
                                            id : id
                                        },
                                        success : function (msg) {
                                            location.reload(true);
                                        }
                                    });
                                },
                                "Cancelar" : function () {
                                    $("#dlg-empleado").dialog("close");
                                }
                            };
                            cont = "<span style='font-size: 16px;'> Est&aacute; seguro de querer eliminar este Empleado?";
                            cont += "<br/>Esta acci&oacute;n es definitiva.</span>"
                            $("#dlg-empleado").dialog("option", "width", 360);
                            break;
                    }
                    openDlg(url, id, cont, action != "delete", title, buttons);
                });
    });
</script>
</body>
</html>
