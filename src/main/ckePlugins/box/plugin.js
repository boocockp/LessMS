CKEDITOR.plugins.add( 'box', {
    icons: 'box',
    init: function( editor ) {
        editor.addCommand( 'insertBox', {
            exec: function( editor ) {
                var edDoc = editor.document;

                edDoc.getHead().appendHtml('<link rel="import" href="/LessMS/src/main/custom/test-box.html">');
                editor.insertHtml( '<p>Box here</p><test-box></test-box><p>End of box</p>' );
            }
        });
        editor.ui.addButton( 'Box', {
            label: 'Insert Box',
            command: 'insertBox',
            toolbar: 'insert'
        });
    }
});
