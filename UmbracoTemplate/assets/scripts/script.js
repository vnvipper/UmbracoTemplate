(function ($, window, document, undefined) {
    var responsiveHandler = {
        init: function () {
            responsiveHandler.markView();
            $(window).on({
                resize: responsiveHandler.markView,
                orientationchange: responsiveHandler.markView
            });
        },
        markView: function () {
            var w = window.innerWidth;
            //var ori = window.orientation;
            var body = $('body');
            var v = { s: 'mobile', m: 'tablet', l: 'desktop' };  // class names
            var c, portLand, orgView;

            // determine orginal view
            if (body.hasClass(v.s)) {
                orgView = v.s;
            } else if (body.hasClass(v.m)) {
                orgView = v.m;
                if (body.hasClass(v.ml)) {
                    orgView += ' ' + v.ml;
                }
            } else if (body.hasClass(v.l)) {
                orgView = v.l;
            }

            // determine new view
            portLand = w > $(window).height() ? 'landscape' : 'portrait';  // w == h is portrait in CSS media query
            if (w > 991) {
                c = v.l;
            } else if (w < 992 && w > 767) {
                c = v.m;
            }
            else {
                c = v.s;
            }

            // apply new view
            body.removeClass(v.s).removeClass(v.m).removeClass(v.l).addClass(c);

            // trigger event
            if (orgView != c) {
                body.trigger('viewchange', { orgView: orgView, newView: c });
            }
        }
    };

    // please modulize your functions so we can reuse/turn on & off easily
    $(document).ready(function () {
        responsiveHandler.init();
    });

})(jQuery, window, document);