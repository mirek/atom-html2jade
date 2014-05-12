html2jade = require 'html2jade'

module.exports =

  activate: ->
    atom.workspaceView.command "html2jade:convert", => @convert()

  convert: ->
    try
      editor = atom.workspace.activePaneItem
      selection = editor.getSelection()
      html2jade.convertHtml selection.getText(), {}, (err, jade) ->
        unless err?
          selection.insertText jade
        else
          console.error err
    catch ex
      console.error ex
