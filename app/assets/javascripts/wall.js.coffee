saveAgent = (->
  # Page elements
  saveState = 0
  wallForm = 0
  magicBox = 0
  timeoutHandle = 0
  timeoutLength = 0

  init = (length)->
    timeoutLength = length
    findElements(bindEvents)
    return

  bindEvents = ->
    bindInputEvent()
    bindSuccessfulSaveEvent()
    return

  findElements = (callback)->
    saveState = $('#save_state')
    wallForm = $('#wall_form')
    magicBox = $('.magic-box')
    callback()
    return

  saveMagicBox = ()->
    wallForm.submit()
    return

  bindSuccessfulSaveEvent = () ->
    wallForm.on 'ajax:success', (e, data, status, xhr) ->
      saveState.text(data.state)
      saveState.addClass 'muted'
      return
    .on 'ajax:error', (e, data, status, xhr) ->
      saveState.text('Save Error')
      return
    return


  bindInputEvent = ->
    magicBox.keyup ->
      saveState.text('Not Saved').removeClass('muted')
      window.clearTimeout(timeoutHandle)
      timeoutHandle = window.setTimeout saveMagicBox, timeoutLength * 1000
      return
    return


  return init: init
)()


$(document).ready ->
  saveAgent.init(5) # Save After 5 seconds of inactivity
  return