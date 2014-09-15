window.MagicBox = (->

  ###########
  # Public 
  ###########

  init = ()->
    setDataCache()
    bindServerCommandCallback()
    bindCommandSubmission()
    bindAutocomplete()
    return

  # object to hold local command functions
  localCommands = {}
  
  ###########
  # Private 
  ###########

  # data cache
  dc = {}

  # Need to find DOM elements after page load
  setDataCache = ()->
    # TODO, automatically detect local commands
    dc.localCommands  = ['encrypt', 'decrypt']
    dc.serverCommands = ['email']
    dc.commandList = dc.localCommands.concat dc.serverCommands
    dc.$commandForm = $('#command_form')
    dc.$commandField = $('#wall_command')
    dc.$wallForm = $('#wall_form')
    dc.commandPrefix = '$$'
    return

  # Bind Command submission event
  bindCommandSubmission = ()->
    $('#command_form').on 'ajax:beforeSend', (e, xhr)->
      parseInputCommand(e, xhr)
      return
    return

  # Parse the command and determine whether to run locally, send to server or display error
  parseInputCommand = (e, xhr)->
    commandStr = dc.$commandField.val().trim()
    commandKeyword = getCommand(commandStr)

    if commandKeyword in dc.localCommands
      xhr.abort()
      runLocalCommand(commandStr)
    else if commandKeyword in dc.serverCommands
      runServerCommand(commandStr)
    else
      displayError("Invalid Command: #{commandStr}")
    dc.$commandField.val('')
    return

  # UJS handles ajax submission for now
  runServerCommand = ()->
    # do nothing right now
    return

  # Run the command
  runLocalCommand = (commandStr)->
    commandKeyword = getCommand(commandStr)
    commandArgsInt = commandStr.split(' ')
    commandArgsInt.shift()
    commandArgs = commandArgsInt.filter validArgument

    try
      resp = localCommands[commandKeyword].apply(this, commandArgs)
      saveWall()
      displayMessage resp
    catch err
      displayError err
    return

  # Function to filter out invalid arguments for command
  validArgument = (val)->
    return false if val in ['', ' ', undefined]
    return true

  bindServerCommandCallback = ()->
    dc.$commandForm.on 'ajax:success', (e, data, status, xhr)->
      this.reset()
      displayMessage(data.message, 'success')
      return

  displayError = (msg)->
    displayMessage(msg, 'error')
    return

  bindAutocomplete = ()->
    opts = 
      at: dc.commandPrefix
      data: dc.commandList

    dc.$commandField.atwho opts
    return


  # Function to display message. This should be extracted into separate presentation class
  displayMessage = (message, klass)->
    messageElement = document.createElement('div')
    messageElement.innerHTML = '<p>' + message + '</p>'
    messageElement.className = 'command-message fade-in-left' + ' ' + klass
    messagesContainer = document.getElementById('messages')
    messagesContainer.insertBefore(messageElement, messagesContainer.firstChild)
    return

  getCommand = (commandStr)->
    commandStr.split(' ')[0].toLowerCase().substring(dc.commandPrefix.length)

  # Submit wall form
  saveWall = ()->
    dc.$wallForm.submit()
    return

  publicFunctions = 
    init: init
    commands: localCommands

  return publicFunctions
)()

MagicBox.commands.encrypt = (->
  encrypt = (key)->
    if confirm "Are you sure you want to encrypt this with the key: '#{key}'? \n This will replace the text in the magic box"
      return encryptMessage(key)
    else
      return

  encryptMessage = (key)->
    wallField = $('#wall_text')
    encWall = CryptoJS.AES.encrypt wallField.val(), key
    wallField.val encWall
    return 'Message encrypted!! You better remember that password'

  return encrypt
)()

MagicBox.commands.decrypt = (->
  encrypt = (key)->
    if confirm "Are you sure you want to decrypt? \n This will replace the text in the magic box if decryption is successful"
      return decryptMessage(key)
    else 
      return

  decryptMessage = (key)->
    wallField = $('#wall_text')
    decWall = CryptoJS.AES.decrypt wallField.val(), key
    throw 'Incorrect key or not encrypted' if decWall.toString().length < 1

    wallField.val decWall.toString(CryptoJS.enc.Utf8);
    return 'Message decrypted!!'

  return encrypt
)()


$(->
  MagicBox.init()
)