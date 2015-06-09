html2jade = require 'html2jade'

module.exports =

  activate: (state) ->

    # Register convert command.
    atom.commands.add 'atom-workspace',
      'html2jade-plus:convert': => @convert()

    # atom.workspaceView.command "html2jade:convert", => @convert()

  convert: ->
    try
      editor = atom.workspace.getActivePaneItem()
      selection = editor.getLastSelection()
      html = selection.getText()
      html = "#{html}".replace /\>\s+\</, '><' # HACK: FIXME:
      html2jade.convertHtml html, { bodyless: true }, (err, jade) ->
        unless err?
          selection.insertText jade
        else
          console.error err
    catch ex
      console.error ex
