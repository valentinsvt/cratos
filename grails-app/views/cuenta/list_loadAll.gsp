<%@ page import="cratos.Cuenta" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'cuenta.label', default: 'Cuenta')}"/>
        <title>Lista de Cuentas</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jstree', file: 'jquery.jstree.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jstree/_lib', file: 'jquery.cookie.js')}"></script>

        <style type="text/css">
        .jstree-search {
            background : #d1d1d1;
            color      : #333333 !important;
        }
        </style>

    </head>

    <body>
        <a href="#list-cuenta" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-cuenta" class="content scaffold-list" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="create linkButton" action="create">Crear Cuenta</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Lista de Cuentas</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>


                <div class="" style=" height:30px; margin-bottom: 8px;">
                    <div class="span-2 prepend-1">
                        Buscar:
                    </div>

                    <div class="span-5">
                        <input type="search" id="txtSearch" class="ui-corner-all span-4"/>
                    </div>

                    <div class="span-5" id="cantRes"></div>
                </div>

                <div id="loading" style="text-align:center;">
                    <img src="${resource(dir: 'images', file: 'loading_bg.gif')}" alt="Cargando..."/>

                    <p>Cargando el árbol de cuentas. Por favor espere.</p>
                </div>

                <div id="tree" style="overflow-y: auto; height: 428px; display: none;">
                    ${res}
                </div>
            </div>
        </div>

        <div id="dlgCrear" title="Crear cuenta" style="display: none;">

        </div>


        <script type="text/javascript">

            var icons = {
                padre      : "${resource(dir: 'images/img', file: 'safe.png')}",
                hijo       : "${resource(dir: 'images/img', file: 'coins2.png')}",
                create     : "${resource(dir: 'images/img', file: 'add.png')}",
                newHija    : "${resource(dir: 'images/img', file: 'brick_add.png')}",
                newSibling : "${resource(dir: 'images/img', file: 'page_white_add.png')}",
                edit       : "${resource(dir: 'images/img', file: 'pencil.png')}",
                delete     : "${resource(dir: 'images/img', file: 'delete.png')}"
            };

            function createContextmenu(node) {
                var parent = node.parent().parent();

                var nodeStrId = node.attr("id");
                var nodeText = trim(node.children("a").text());

                var parentStrId = parent.attr("id");
                var parentText = trim(parent.children("a").text());

                var parts = nodeStrId.split("_");
                var nodeId = parts[1];

                parts = parentStrId.split("_");
                var parentId = parts[1];

                var nodeHasChildren = node.hasClass("hasChildren");

                var items = {
                    "create" : false,
                    "remove" : false,
                    "rename" : false,
                    "ccp"    : false,
                    "crear"  : {
                        "label"            : "Nueva cuenta",
                        "_disabled"        : false, // clicking the item won't do a thing
                        "separator_before" : false, // Insert a separator before the item
                        "separator_after"  : false, // Insert a separator after the item
                        "icon"             : icons.create,
                        "submenu"          : {}
                    },
                    "editar" : {
                        "label"            : "Editar cuenta",
                        "_disabled"        : false, // clicking the item won't do a thing
                        "separator_before" : false, // Insert a separator before the item
                        "separator_after"  : false, // Insert a separator after the item
                        "icon"             : icons.edit,
                        action             : function (obj) {

                        }
                    }
                } //items

                items.crear.submenu.nuevoSibling = {
                    "label"            : "Mismo nivel",
                    "_disabled"        : false, // clicking the item won't do a thing
                    "separator_before" : false, // Insert a separator before the item
                    "separator_after"  : false, // Insert a separator after the item
                    "icon"             : icons.newSibling,
                    // The function to execute upon a click
                    "action"           : function (obj) {
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(action:'loadForm')}",
                            data    : {
                                padre : parentId
                            },
                            success : function (msg) {
                                $("#dlgCrear").html(msg);
                                $("#dlgCrear").dialog("open");
                            }
                        });
                    }
                }; //nuevo hermano

                items.crear.submenu.nuevoHijo = {
                    "label"            : "Hija",
                    "_disabled"        : false, // clicking the item won't do a thing
                    "separator_before" : false, // Insert a separator before the item
                    "separator_after"  : false, // Insert a separator after the item
                    "icon"             : icons.newHija,
                    // The function to execute upon a click
                    "action"           : function (obj) {

                    }
                }; //nuevo hijo

                if (!nodeHasChildren) {
                    items.eliminar = {
                        "label"            : "Eliminar cuenta",
                        "_disabled"        : false, // clicking the item won't do a thing
                        "separator_before" : false, // Insert a separator before the item
                        "separator_after"  : false, // Insert a separator after the item
                        "icon"             : icons.delete,
                        action             : function (obj) {
                            $.box({
                                imageClass : "box_warning",
                                text       : "Está seguro de querer eliminar esta cuenta?<div style='font-size: 15px; font-weight:bold;'>Esta acción no se puede deshacer.</div>",
                                title      : "Alerta",
                                iconClose  : false,
                                dialog     : {
                                    resizable     : false,
                                    draggable     : false,
                                    width         : 340,
                                    closeOnEscape : false,
                                    buttons       : {
                                        "Aceptar"  : function () {
                                            $.ajax({
                                                type    : "POST",
                                                url     : "${createLink(action: 'deleteCuenta')}",
                                                data    : {
                                                    id : nodeId
                                                },
                                                success : function (msg) {
                                                    if (msg == "OK") {
                                                        $("#tree").jstree("remove", "#" + nodeStrId);
                                                    } else {
                                                        var parts = msg.split("_");
                                                        $.box({
                                                            text       : parts[1],
                                                            title      : "Error",
                                                            imageClass : "box_error",
                                                            dialog     : {
                                                                resizable : false,
                                                                buttons   : {
                                                                    "Aceptar" : function () {
                                                                    }
                                                                }
                                                            }
                                                        });
                                                    }
                                                },
                                                error   : function (jqXHR, textStatus, errorThrown) {
                                                    $.box({
                                                        text       : "Ha ocurrido un error: <br/>" + jqXHR.status + "  " + jqXHR.statusText,
                                                        title      : errorThrown,
                                                        imageClass : "box_error",
                                                        dialog     : {
                                                            resizable : false,
                                                            buttons   : {
                                                                "Aceptar" : function () {
                                                                }
                                                            }
                                                        }
                                                    });
                                                }
                                            });
                                        },
                                        "Cancelar" : function () {
                                        }
                                    }
                                }
                            });
                        }
                    }
                }

                return items;
            }

            $(function () {

                $("#tree").bind("loaded.jstree",
                        function (event, data) {
                            $("#loading").hide();
                            $("#tree").show();
                        }).jstree({
                            "plugins"     : ["themes", "html_data", "ui", "cookies", "types", "contextmenu", "search", "crrm"/*, "wholerow"*/],
                            "types"       : {
                                "valid_children" : [ "root" ],
                                "types"          : {
                                    "padre" : {
                                        "icon"           : {
                                            "image" : icons.padre
                                        },
                                        "valid_children" : [ "hijo" ]
                                    },
                                    "hijo"  : {
                                        "icon" : {
                                            "image" : icons.hijo
                                        }
                                    }
                                }
                            },
                            "themes"      : {
                                "theme" : "default"
                            },
                            "search"      : {
                                "case_insensitive" : true
                            },
                            "contextmenu" : {
                                select_node : true,
                                "items"     : createContextmenu
                            }, //contextmenu
                            "ui"          : {
                                "select_limit" : 1
                            }
                        }).bind("search.jstree", function (e, data) {
                            var cant = data.rslt.nodes.length;
                            var search = data.rslt.str;
                            $("#cantRes").html("<b>" + cant + "</b> resultados");
                        });

                $("#dlgCrear").dialog({
                    modal    : true,
                    autoOpen : false,
                    width    : 380,
                    height   : 400,
                    buttons  : {
                        "Guardar"  : function () {
                            if ($("#form-cuenta").valid()) {
                                $.ajax({
                                    type    : "POST",
                                    url     : "${createLink(action:'saveAjax')}",
                                    data    : $("#form-cuenta").serialize(),
                                    success : function (msg) {
                                        console.log(msg);
                                    }
                                });
                            }
                        },
                        "Cancelar" : function () {
                            $("#dlgCrear").dialog("close");
                        }
                    }
                });

                $("#txtSearch").val("").keyup(function () {
                    $("#tree").jstree("search", $(this).val());
                });
            });
        </script>

    </body>
</html>
