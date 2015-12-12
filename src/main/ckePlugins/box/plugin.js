CKEDITOR.plugins.add( 'box', {
    icons: 'box',
    init: function( editor ) {

        function findImport(el, elementName) {
            var imports = el.find('link[rel="import"]');
            for (var i = 0; i < imports.count(); i++) {
                var node = imports.getItem(i);
                if (node.getAttribute('href').match("\\/" + elementName + ".html")) {
                    return node;
                }
            }

            return null;
        }
        editor.addCommand( 'insertBox', {
            exec: function( editor ) {
                var head = editor.document.getHead();
                if (!findImport(head, "test-box")) {
                    head.appendHtml('<link rel="import" href="/LessMS/src/main/custom/test-box.html">');
                }

                var boxEl = new CKEDITOR.dom.element('test-box');
                editor.insertElement(boxEl);
            }
        });
        editor.ui.addButton( 'Box', {
            label: 'Insert Box',
            command: 'insertBox',
            toolbar: 'insert'
        });
    }
});
