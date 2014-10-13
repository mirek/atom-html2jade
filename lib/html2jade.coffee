html2jade = require 'html2jade'

module.exports =

  activate: ->
    atom.workspaceView.command "html2jade:convert", => @convert()

  convert: ->
    try
      editor = atom.workspace.activePaneItem
      selection = editor.getSelection()
      html = selection.getText()
      html = "#{html}".replace /\>\s+\</, '><' # HACK: FIXME:
      html2jade.convertHtml html, { bodyless: true }, (err, jade) ->
        unless err?
          selection.insertText jade
        else
          console.error err
    catch ex
      console.error ex
