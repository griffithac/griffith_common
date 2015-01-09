jQuery.fn.extend
	insertAtCaret: (myValue) ->
		@.each (i) ->
			if (document.selection) # For browsers like Internet Explorer
				@.focus()
				sel = document.selection.createRange()
				sel.text = myValue
				@.focus()
			else if (@.selectionStart || this.selectionStart == '0') #For browsers like Firefox and Webkit based
				startPos = @.selectionStart
				endPos = @.selectionEnd
				scrollTop = @.scrollTop
				this.value = @.value.substring(0, startPos) + myValue + @.value.substring(endPos,@.value.length)
				@.focus()
				@.selectionStart = startPos + myValue.length
				@.selectionEnd = startPos + myValue.length
				@.scrollTop = scrollTop
			else
				@.value += myValue
				@.focus()

	wrapSelectedText: (before = '', after = '') ->
		len = @.val().length
		start = @[0].selectionStart
		end = @[0].selectionEnd
		selectedText = @.val().substring(start, end)
		replacement = before + selectedText + after
		@.val(@.val().substring(0, start) + replacement + @.val().substring(end, len))