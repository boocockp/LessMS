describe "File List", ->

  @timeout 5000

  awsConfig = {accessKeyId: 'AKIAJZEULXXXXXXXXXX', secretAccessKey: 'RJySTXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', region: 'eu-west-1'}
  bucketName = "ashridgetech.cms.test"

  testUser = {email: "a@a.com", identityId: "eu-west-1:yourid"}

  class S3Tool
    constructor: (config, @bucketName)->
      bucketConfig = $.extend { params: {Bucket: @bucketName}}, config
      @s3bucket = new AWS.S3(bucketConfig)
      @requestsInFlight = 0

    setItems: (user, items, done) ->
      userFolder = user.identityId
      @setFileOrFolder userFolder, i for i in items
      waitFor (=>
        console.log "waiting for requests - @requestsInFlight", @requestsInFlight
        @requestsInFlight == 0), done

    setFileOrFolder: (userFolder, item) -> if item instanceof FolderItem then @setFolder(userFolder, item) else @setFile(userFolder, item)

    setFile: (parentFolder, file) ->
      path = parentFolder + '/' + file.name
      contentType = file.contentType or "text/plain"
      fileData = file.data or "#{file.name} content"
      @_createObject path, contentType, fileData

    setFolder: (parentFolder, folder) ->
      path = parentFolder + '/' + folder.name
      @_createObject path + '/', null, ''
      @setFileOrFolder path, i for i in folder.items

    _createObject: (path, contentType, body) ->
      putParams =
        Key: path,
        ContentType: contentType or "text/plain",
        ACL: 'public-read',
        Body: body or "#{file.name} content"

      @requestsInFlight = @requestsInFlight + 1
      @s3bucket.putObject putParams, (error, data) =>
        @requestsInFlight = @requestsInFlight - 1
        if error
          throw new Error "Error creating #{path}: #{error}"
        else
          console.log 'Created', path



  class FileItem
    constructor: (@name) ->

  class FolderItem
    constructor: (@name, @items) ->

  class BrowserFileList
    constructor: (@el) ->
      el.find('ag-grid').length.should.eql 1

    hasItems: -> !!@el.find('.fb-name').length

    itemsShown: ->
      fileOrFolder = (itemEl) ->
        name = itemEl.text().trim()
        if (itemEl.hasClass('fb-folder')) then new FolderItem(name) else new FileItem(name)

      (fileOrFolder $(s) for s in @el.find('.fb-name').toArray())

    toggleExpand: (name) ->
      @el.find('.fb-name.fb-folder').filter((i, el) -> $(el).text().trim() == name).prevAll('.ag-group-expand:visible').click()

    edit: (name) ->
      @el.find('.fb-name.fb-file').filter((i, el) -> $(el).text().trim() == name).find('a')[0].click()

    createFolderIn: (name) ->

  class TabbedEditor
    constructor: (@el) ->
      el.find('ul.nav-tabs').length.should.eql 1

    tabs: -> (new Tab($(t)) for t in @el.find('ul.nav-tabs li').get())

    class Tab
      constructor: (@el) ->
        @name = @el.text()

  class BrowserEditor

    constructor: (@el) ->
    fileList: -> new BrowserFileList(@el.find('file-list'))
    tabbedEditor: -> new TabbedEditor(@el.find('tabbed-editor'))

  file = (name) -> new FileItem name
  folder = (name, items) -> new FolderItem name, items
  browserEditorS3 = -> new BrowserEditor($('browser-editor-s3'))
  signIn = (user) ->

  waitFor = (condition, action) ->
    checks = 0
    doCheck = ->
      if (condition())
        clearInterval intervalId
        action()
      else if (checks > 100)
        clearInterval intervalId
        throw new Error ("Wait for timed out: #{condition.toString()}")
      else
        checks = checks + 1
    intervalId = setInterval doCheck, 100

  s3 = new S3Tool(awsConfig, bucketName)

  describe "given test items in user folder", ->

    be = browserEditorS3()
    fileList = be.fileList()
    tabbedEditor = be.tabbedEditor()

    before 'Set up test items in bucket', (done) ->
      $('browser-editor-s3').find('ag-grid').length.should.eql 1

      s3.setItems testUser, [
        file "a1.html"
        file "b1.txt"
        folder "c1", [
          file "d1.css"
        ]
      ], ->
        waitFor (->
          console.log "waiting for fileList"
          fileList.hasItems()), done

    signIn testUser

    it "shows files and folders in top-level directory",  ->
      fileList.itemsShown().should.eql [
        folder "Your files"
        file "a1.html"
        file "b1.txt"
        folder "c1"
      ]

    it "can expand a folder", ->
      fileList.toggleExpand "c1"
      fileList.itemsShown().should.eql [
        folder "Your files"
        file "a1.html"
        file "b1.txt"
        folder "c1"
        file "d1.css"
      ]

    it "can edit a file", (done) ->
      fileList.edit "d1.css"
      waitFor (-> tabbedEditor.tabs().length == 1), ->
        tabbedEditor.tabs()[0].name.should.eql "d1.css"
        done()

    it.skip "can create a folder in top level", ->
      fileList.createFolderIn "Your files", "folderX"