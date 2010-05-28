(function(punymce) {
	punymce.plugins.Image = function(ed) {
		var I18n = punymce.I18n;

		if (!ed.settings.image || ed.settings.image.skip_css)
			punymce.DOM.loadCSS(punymce.baseURL + '/plugins/image/css/editor.css');

		// Add image command
		punymce.extend(ed.commands, {
			mceInsertImage : function(u, v, e) {
				var tx, f = ed.selection.getNode();

				tx = prompt(I18n.entersrc, f.nodeName == "IMG" ? ed.dom.getAttr(f, "src") : "");
				if (tx)
					ed.selection.setNode(ed.dom.create('img', {src : tx}));
			}
		});

		// Add tools
		punymce.extend(ed.tools, {
			image : {cmd : 'mceInsertImage', title : I18n.insertimage}
		});
	};

	// English i18n strings
	punymce.extend(punymce.I18n, {
		insertimage : 'Insert image',
		entersrc : 'Enter the URL of the image'
	});
})(punymce);
