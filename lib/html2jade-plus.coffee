html2jade = require 'html2jade'

module.exports =

  activate: (state) ->

    # Register convert command.
    atom.commands.add 'atom-workspace',
      'html2jade-plus:convert': => @convert()

  convert: ->
    unless (editor = atom.workspace.getActiveTextEditor())
      return (atom.notifications.addWarning('No text editor found'))
    html =
      if (selection = editor.getLastSelection()) and not selection.isEmpty()
        selection.getText()
      else
        selection = null
        editor.getText()
    html = "#{html}".replace /\>\s+\</, '><' # HACK: FIXME:
    html2jade.convertHtml html, { bodyless: true }, (err, jade) ->
      if err
        atom.notifications.addError(err.name or err.toString(), {detail: e.message})
        return
      if selection
        selection.insertText(jade)
      else
        atom.workspace.open().then (newEditor) ->
          newEditor.insertText(jade)
          if (jadeGrammar = atom.grammars.grammarForScopeName('source.jade'))
            newEditor.setGrammar(jadeGrammar)
