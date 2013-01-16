function extendRemove(target, props) {
    $.extend(target, props);
    for (var name in props) {
        if (props[name] == null || props[name] == undefined) {
            target[name] = props[name]
        }
    }
    return target
}
(function ($) {
    $.box = $.fn.box = function (settings) {

        var defaults = {
            text      : "text",
            title     : "Title",
            imageClass: "box_alert",
            input     : false,
            html      : false,
            remote    : false,
            iconClose : true,
            dialog    : {
                modal  : true,
                title  : "Title",
                buttons: {
                    "OK": function () {
                        div.dialog("close");
                    }
                }
            },
            id        : "boxHiddenDlg"
        };

        var dlg_opts = defaults.dialog;
        dlg_opts = extendRemove(dlg_opts, settings.dialog || {});
        dlg_opts.autoOpen = false;

        defaults = extendRemove(defaults, settings || {});

        if (defaults.title) {
            dlg_opts.title = defaults.title
        }

        //TODO: fix it so as not to replace the open function if there is one
        if (!defaults.iconClose) {
//            if (!dlg_opts.open) {
            dlg_opts.open = function (event, ui) {
                $(event.target).parent().find(".ui-dialog-titlebar-close").remove();
            };
//            } else {
//                var func = function (event, ui) {
////                    dlg_opts.open(event, ui);
//                    console.log(dlg_opts.open);
//                    var fn = window[dlg_opts.open];
//                    console.log(typeof fn);
//                    if (typeof fn === 'function') {
//                        console.log("FASD");
//                        fn(event, ui);
//                    } else if (typeof dlg_opts.open === 'function') {
//                        console.log("!@#");
//                        dlg_opts.open();
//                    }
//                    $(event.target).parent().find(".ui-dialog-titlebar-close").remove();
//                };
////                console.log(func);
//                dlg_opts.open = func;
//            }
        }


        var div = $("#" + defaults.id);
        if (div.length == 0) {
            div = $("<div id='" + defaults.id + "' style=\"display:none\">");
            div.appendTo(document.body);
        }
        div.empty();
        var spanText = $("<span>")
        spanText.html(defaults.text);

        if (defaults.imageClass) {
            var spanImg = $("<div>");
            spanImg.addClass("box_img");
            spanImg.addClass(defaults.imageClass);
            div.append(spanImg);
        }
        div.append(spanText);
        var input = false;
        if (defaults.input) {
            input = $(defaults.input);
            var spanInput = $("<div>");
            spanInput.addClass("box_input");
            spanInput.html(input);
            div.append(spanInput);
        } else if (defaults.html) {
            div.append(defaults.html.clone());
        } else if (defaults.remote) {
            $.ajax({
                type   : "POST",
                url    : defaults.remote,
                success: function (msg) {
                    div.append(msg);
                }
            });
        }

        div.dialog(dlg_opts);
        var btns = {};
        if (defaults.dialog.buttons != null) {
            jQuery.each(defaults.dialog.buttons, function (i, val) {
                btns[i] = function (e) {
                    if (val) {
                        if (input) {
                            val(input.val());
                        } else {
                            val($(e.currentTarget).text());
                        }
                    }
                    $(this).dialog('close');
                    $(this).dialog('destroy');
                    div.remove();
                }
            });

            div.dialog("option", "buttons", btns);
        }

        div.dialog("open");

    };
})(jQuery);