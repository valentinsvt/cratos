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
                "delete"   : "${resource(dir: 'images/img', file: 'delete.png')}"
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
                var ocupado = node.hasClass("ocupado")

                var items = {
                    "create" : false,
                    "remove" : false,
                    "rename" : false,
                    "ccp"    : false,
                    "crear"  : {
                        "label"            : "Nueva cuenta hija",
                        "_disabled"        : false, // clicking the item won't do a thing
                        "separator_before" : false, // Insert a separator before the item
                        "separator_after"  : false, // Insert a separator after the item
                        "icon"             : icons.create,
                        "action"           : function (obj) {
                            var tipo = $(obj).attr("rel");
                            var str = $(obj).attr("id");
                            var parts = str.split("_");
                            var id = parts[1];
                            var lvl = $(obj).attr("level");
                            var url = "${createLink(action: 'editCuenta')}";

                            $.ajax({
                                "type"    : "POST",
                                "url"     : url,
                                "data"    : {
                                    "id"    : id,
                                    "level" : lvl,
                                    "type"  : "create"
                                },
                                "success" : function (msg) {
                                    $("#dlgCrear").dialog("option", "title", "Crear cuenta");
                                    $("#dlgCrear").html(msg);
                                    $("#dlgCrear").dialog("open");
                                }
                            });
                        }
                    },
                    "editar" : {
                        "label"            : "Editar cuenta",
                        "_disabled"        : false, // clicking the item won't do a thing
                        "separator_before" : false, // Insert a separator before the item
                        "separator_after"  : false, // Insert a separator after the item
                        "icon"             : icons.edit,
                        action             : function (obj) {
                            var tipo = $(obj).attr("rel");
                            var str = $(obj).attr("id");
                            var parts = str.split("_");
                            var id = parts[1];
                            var lvl = $(obj).attr("level");
                            var url = "${createLink(action: 'editCuenta')}";

                            $.ajax({
                                "type"    : "POST",
                                "url"     : url,
                                "data"    : {
                                    "id"    : id,
                                    "level" : lvl,
                                    "type"  : "edit"
                                },
                                "success" : function (msg) {
                                    $("#dlgCrear").dialog("option", "title", "Crear cuenta");
                                    $("#dlgCrear").html(msg);
                                    $("#dlgCrear").dialog("open");
                                }
                            });
                        }
                    }
                } //items

                if (!nodeHasChildren && !ocupado) {
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

                if (nodeStrId == "root") {
                    items.editar._disabled = true;
                } else {
                    items.editar._disabled = false;
                }

                return items;
            }

            function initTree() {
                $("#tree").bind("loaded.jstree",
                        function (event, data) {
                            $("#loading").hide();
                            $("#tree").show();
                        }).jstree({
                            "plugins"     : ["themes", "html_data", "json_data", "ui", "cookies", "types", "contextmenu", "search", "crrm"/*, "wholerow"*/],
                            "html_data"   : {
                                "data" : "<ul type='root'><li id='root' class='root hasChildren jstree-closed' rel='root' level='0'><a href='#' class='label_arbol'>Plan de cuentas</a></ul>",
                                "ajax" : {
                                    "url"   : "${createLink(action: 'loadTreePart')}",
                                    "data"  : function (n) {
                                        var obj = $(n);
                                        var id = obj.attr("id");
                                        var parts = id.split("_");
                                        var id = 0;
                                        if (parts.length > 1) {
                                            id = parts[1]
                                        }
                                        return {id : id}
                                    },
                                    success : function (data) {

                                    },
                                    error   : function (data) {
                                        ////console.log("error");
                                        ////console.log(data);
                                    }
                                }
                            },
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
                                "theme" : "apple"
                            },
                            "search"      : {
                                "case_insensitive" : true,
                                "ajax"             : {
                                    "url" : "${createLink(action:'ajaxSearch')}"
                                }
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
            }

            $(function () {

                initTree();

                $("#dlgCrear").dialog({
                    modal    : true,
                    autoOpen : false,
                    width    : 500,
                    height   : 440,
                    buttons  : {
                        "Guardar"  : function () {
                            if ($(".form-cuenta").valid()) {
                                $.ajax({
                                    type    : "POST",
                                    url     : "${createLink(action:'saveAjax')}",
                                    data    : $(".form-cuenta").serialize(),
                                    success : function (msg) {
                                        var parts = msg.split("_");
                                        var img = "";
                                        if (parts[0] == "OK") {
                                            img = "info"
                                        }
                                        $.box({
                                            text       : parts[1],
                                            title      : "Mensaje",
                                            imageClass : "box_" + img,
                                            dialog     : {
                                                resizable : false,
                                                buttons   : false,
                                                draggable : false
                                            }
                                        });

                                        window.location.reload(true);
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
