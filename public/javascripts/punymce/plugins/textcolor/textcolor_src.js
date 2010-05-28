(function(punymce) {
	punymce.plugins.TextColor = function(ed) {
		var colors = '000000,993300,333300,003300,003366,000080,333399,333333,800000,FF6600,808000,008000,008080,0000FF,666699,808080,FF0000,FF9900,99CC00,339966,33CCCC,3366FF,800080,999999,FF00FF,FFCC00,FFFF00,00FF00,00FFFF,00CCFF,993366,C0C0C0,FF99CC,FFCC99,FFFF99,CCFFCC,CCFFFF,99CCFF,CC99FF,FFFFFF';
		var DOM = punymce.DOM, Event = punymce.Event, each = punymce.each, extend = punymce.extend, s;

		if (!ed.settings.textcolor || ed.settings.textcolor.skip_css)
			DOM.loadCSS(punymce.baseURL + '/plugins/textcolor/css/editor.css');

		s = extend({
			colors : colors
		}, ed.settings.textcolor);

		extend(ed.commands, {
			mceColor : function(u, v, e) {
				var n, t = this, id = ed.settings.id, p = DOM.getPos(e.target), co, cb;

				if (ed.hideMenu)
					return ed.hideMenu();

				function hide(e) {
					ed.hideMenu = null;
					Event.remove(document, 'click', hide);
					Event.remove(ed.getDoc(), 'click', hide);
					DOM.get(id + '_mcolor').style.display = 'none';
					return 1;
				};

				n = DOM.get(id + '_mcolor');
				if (!n) {
					n = DOM.get(id + '_t');
					n = DOM.add(document.body, 'div', {id : id + '_mcolor', 'class' : 'punymce_color punymce'});
					n = DOM.add(n, 'table', {'class' : 'punymce'});
					n = DOM.add(n, 'tbody');
					co = 8;
					each(s.colors.split(','), function(c) {
						if (co == 8) {
							r = DOM.add(n, 'tr');
							co = 0;
						}

						co++;

						Event.add(DOM.add(DOM.add(r, 'td'), 'a', {href : '#', style : 'background:#' + c}), 'mousedown', function(e) {
							hide.call(t);

							ed.execCommand('forecolor', 0, '#' + c);

							return Event.cancel(e);
						});
					});
				}

				Event.add(document, 'click', hide, t);
				Event.add(ed.getDoc(), 'click', hide, t);
				ed.hideMenu = hide;

				s = DOM.get(id + '_mcolor').style;
				s.left = p.x + 'px';
				s.top = (p.y + e.target.clientHeight + 2) + 'px';
				s.display = 'block';
			}
		});

		extend(ed.tools, {
			textcolor : {cmd : 'mceColor', title : punymce.I18n.textcolor}
		});
	};

	// English i18n strings
	punymce.extend(punymce.I18n, {
		textcolor : 'Text color'
	});
})(punymce);
