CKEDITOR.plugins.add( 'box', {
    icons: 'box',
    init: function( editor ) {
        editor.addCommand( 'insertBox', {
            exec: function( editor ) {
                var edDoc = editor.document;

                edDoc.getHead().appendHtml('<link rel="import" href="/LessMS/src/main/custom/test-box.html">');
                //editor.insertHtml( '<p>Box here</p><test-box></test-box><p>End of box</p>', 'text' );
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
