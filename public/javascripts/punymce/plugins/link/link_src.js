(function(punymce) {
	punymce.plugins.Link = function(ed) {
		var I18n = punymce.I18n;

		if (!ed.settings.link || ed.settings.link.skip_css)
			punymce.DOM.loadCSS(punymce.baseURL + '/plugins/link/css/editor.css');

		// Add image command
		punymce.extend(ed.commands, {
			mceInsertLink : function(u, v, e) {
				var tx, f = ed.selection.getNode();

				tx = prompt(I18n.enterhref, f.nodeName == "A" ? ed.dom.getAttr(f, "href") : "");
				if (tx) {
					if (ed.selection.isCollapsed())
						ed.selection.setContent('<a href="' + tx + '">' + tx + '</a>');
					else
						ed.execCommand('CreateLink', 0, tx);
				}
			}
		});

		// Add tools
		punymce.extend(ed.tools, {
			link : {cmd : 'mceInsertLink', title : I18n.link},
			unlink : {cmd : 'Unlink', title : I18n.unlink}
		});
	};

	// English i18n strings
	punymce.extend(punymce.I18n, {
		link : 'Insert link',
		unlink : 'Unlink',
		enterhref : 'Enter the URL of the link'
	});
})(punymce);
