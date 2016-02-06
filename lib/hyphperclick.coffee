HyphperclickView = require './hyphperclick-view'
{CompositeDisposable} = require 'atom'

module.exports = Hyphperclick =
  hyphperclickView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @hyphperclickView = new HyphperclickView(state.hyphperclickViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @hyphperclickView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'hyphperclick:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @hyphperclickView.destroy()

  serialize: ->
    hyphperclickViewState: @hyphperclickView.serialize()

  toggle: ->
    console.log 'Hyphperclick was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
