<% import grails.persistence.Event %>
<%=packageName%>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de ${className}s</title>

        <script type="text/javascript" src="\${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
        <link rel="stylesheet" href="\${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}" type="text/css">

        <script type="text/javascript" src="\${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript" src="\${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

    </head>
    <body>
        <div class="ui-widget-content ui-corner-all cont">
            <div class="ui-widget-header ui-corner-all titulo">
                Lista de ${className}s
                <div class="fright">
                    <g:link action="create" class="btnNew miniButton">Nuevo</g:link>
                </div>
            </div>

            <div id="list-${domainClass.propertyName}" class="content scaffold-list" role="main">
                <g:if test="\${flash.message}">
                    <div class="message" role="status">\${flash.message}</div>
                </g:if>
                <table id="tbl-${domainClass.propertyName}">
                    <thead>
                        <tr>
                            <%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
                            allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
                            props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && it.type != null && !Collection.isAssignableFrom(it.type) }
                            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                            props.eachWithIndex { p, i ->
                                if (i < 6) {
                                    if (p.isAssociation()) { %>
                            <th><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></th>
                            <%} else { %>
                            <g:sortableColumn property="${p.name}" title="\${message(code: '${domainClass.propertyName}.${p.name}.label', default: '${p.naturalName}')}" />
                            <%  }   }   } %>
                        </tr>
                    </thead>
                    <tbody id="tb-${domainClass.propertyName}">
                        <g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
                            <tr class="\${(i % 2) == 0 ? 'even' : 'odd'}" id="\${${propertyName}.id}">
                                <%  props.eachWithIndex { p, i ->
                                    if (i == 0) { %>
                                <td>\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</td>
                                <%      } else if (i < 6) {
                                    if (p.type == Boolean || p.type == boolean) { %>
                                <td><g:formatBoolean boolean="\${${propertyName}.${p.name}}" /></td>
                                <%          } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
                                <td><g:formatDate date="\${${propertyName}.${p.name}}" /></td>
                                <%          } else { %>
                                <td>\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</td>
                                <%  }   }   } %>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <g:if test="\${${propertyName}List.size() < ${propertyName}Total}">
                    <div class="pagination">
                        <g:paginate total="\${${propertyName}Total}"  prev="Ant." next="Sig." />
                    </div>
                </g:if>
            </div>
        </div>

        <ul id="menu-${domainClass.propertyName}" class="contextMenu">
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

        <div id="dlg-${domainClass.propertyName}"></div>

        <div id="dlgLoad" class="ui-helper-hidden" style="text-align:center;">
            Cargando.....Por favor espere......<br/><br/>
            <img src="\${resource(dir: 'images', file: 'spinner64.gif')}" alt=""/>
        </div>

        <script type="text/javascript">
            function openDlg(url, id, cont, ajax, title, buttons) {
                if (ajax) {
                \$("#dlgLoad").dialog("open");
                    \$.ajax({
                        async   : false,
                        type    : "POST",
                        url     : url,
                        data    : {
                            id : id
                        },
                        success : function (msg) {
                            \$("#dlg-${domainClass.propertyName}").html(msg);
                        },
                        complete : function () {
                            \$("#dlgLoad").dialog("close");
                        }
                    });
                    \$("#dlg-${domainClass.propertyName}").dialog("option", "width", 420);
                } else {
                \$("#dlg-${domainClass.propertyName}").html(cont);
                }
                \$("#dlg-${domainClass.propertyName}").dialog("option", "title", title);
                \$("#dlg-${domainClass.propertyName}").dialog("option", "buttons", buttons);
                \$("#dlg-${domainClass.propertyName}").dialog("open");
            }

            function submitForm() {
                if (\$("#frm-${domainClass.propertyName}").valid()) {
                    \$("#dlgLoad").dialog("open");
                    var data = \$("#frm-${domainClass.propertyName}").serialize();
                    var url = \$("#frm-${domainClass.propertyName}").attr("action");

                    \$.ajax({
                        type    : "POST",
                        url     : url,
                        data    : data,
                        success : function (msg) {
                            location.reload(true);
                        }
                    });
                }
            }

            \$(function () {
                \$("#dlgLoad").dialog({
                    modal         : true,
                    autoOpen      : false,
                    closeOnEscape : false,
                    draggable     : false,
                    resizable     : false,
                    zIndex        : 9000,
                    open          : function (event, ui) {
                        \$(event.target).parent().find(".ui-dialog-titlebar-close").remove();
                    }
                });

                \$("#dlg-${domainClass.propertyName}").dialog({
                    modal    : true,
                    autoOpen : false,
                    width    : 420,
                    zIndex   : 1000,
                    position : ["center", 10]
                });

                \$("th").hover(function () {
                    \$(this).addClass("hover");
                    var i = \$(this).index();
                    \$("#tb-${domainClass.propertyName}").find("tr").each(function () {
                        \$(this).children().eq(i).addClass("hover");
                    });
                }, function () {
                    \$(".hover").removeClass("hover");
                });

                \$("#tb-${domainClass.propertyName}").find("tr").hover(function () {
                    \$(this).addClass("hover");
                }, function () {
                    \$(".hover").removeClass("hover");
                });

                \$(".btnNew").button({
                    icons : {
                        primary : "ui-icon-document"
                    }
                }).click(function () {
                            var id = \$(this).attr("id");
                            var url = \$(this).attr("href");
                            var title = "Crear ${className}";
                            var buttons = {
                                "Guardar"  : function () {
                                    submitForm();
                                },
                                "Cancelar" : function () {
                                    \$("#dlg-${domainClass.propertyName}").dialog("close");
                                }
                            };
                            openDlg(url, id, "", true, title, buttons);
                            return false;
                        });

                \$("#tb-${domainClass.propertyName}").find("tr").contextMenu({
                            menu : "menu-${domainClass.propertyName}"
                        },
                        function (action, el, pos) {
                            \$("#dlg-${domainClass.propertyName}").html("");
                            var id = \$(el).attr("id");
                            var title, buttons, url, cont;
                            switch (action) {
                                case "edit":
                                    title = "Editar ${className}";
                                    buttons = {
                                        "Guardar"  : function () {
                                            submitForm();
                                        },
                                        "Cancelar" : function () {
                                            \$("#dlg-${domainClass.propertyName}").dialog("close");
                                        }
                                    };
                                    url = "\${createLink(action:'edit')}/" + id;
                                    break;
                                case "show":
                                    title = "Ver ${className}";
                                    buttons = {
                                        "Aceptar" : function () {
                                            \$("#dlg-${domainClass.propertyName}").dialog("close");
                                        }
                                    };
                                    url = "\${createLink(action:'show')}/" + id;
                                    break;
                                case "delete":
                                    title = "Eliminar ${className}";
                                    buttons = {
                                        "Aceptar"  : function () {
                                            \$("#dlgLoad").dialog("open");
                                            \$.ajax({
                                                type    : "POST",
                                                url     : "\${createLink(action:'delete')}",
                                                data    : {
                                                    id : id
                                                },
                                                success : function (msg) {
                                                    location.reload(true);
                                                }
                                            });
                                        },
                                        "Cancelar" : function () {
                                            \$("#dlg-${domainClass.propertyName}").dialog("close");
                                        }
                                    };
                                    cont = "<span style='font-size: 16px;'> Est&aacute; seguro de querer eliminar este ${className}?";
                                    cont += "<br/>Esta acci&oacute;n es definitiva.</span>"
                                    \$("#dlg-${domainClass.propertyName}").dialog("option", "width", 360);
                                    break;
                            }
                            openDlg(url, id, cont, action != "delete", title, buttons);
                        });
            });
        </script>
    </body>
</html>
