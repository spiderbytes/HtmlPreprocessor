EnableExplicit

#AppName = "HtmlPreprocessor"

Structure sSearchReplaceItem
	search.s
	replace.s
EndStructure

NewList SearchReplaceItems.sSearchReplaceItem()

Define File.s, TempFile.s, Executable.s
Define FF
Define HtmlContent.s

Define P1, P2
Define SbContent.s
Define JsonString.s
Define Json

File       = ProgramParameter(0) ; -> SB-File (if saved)
TempFile   = ProgramParameter(1) ; -> SB-File (if not saved)
Executable = ProgramParameter(2) ; -> HTML-File

If File = ""
	File = TempFile
EndIf

; read sb-file:

FF = ReadFile(#PB_Any, File)

If FF = 0
	MessageRequester(#AppName, "Couldn't load file '" + File + "'")
	End
EndIf

SbContent = ReadString(FF, #PB_File_IgnoreEOL)

CloseFile(FF)

; search for inject-instructions:

P1 = FindString(SbContent, "<HtmlPreprocessor>", 1, #PB_String_NoCase)
P2 = FindString(SbContent, "</HtmlPreprocessor>", 1, #PB_String_NoCase)

If P1 = 0 Or P2 = 0 ; no HtmlPreprocessor-Tags found
	End ; Cheerio, nothing to do...
EndIf

P1 + Len("<HtmlPreprocessor>")

JsonString = Mid(SbContent, P1, P2 - P1)

JsonString = RemoveString(JsonString, ";!")

JsonString = RemoveString(JsonString, #CRLF$)

JsonString = ReplaceString(JsonString, "#CRLF#", "\n")

; MessageRequester(#AppName, JsonString)

Json = ParseJSON(#PB_Any, JsonString)

If Json = 0
	MessageRequester(#AppName, "Json-Error in HtmlPreprocessor - Block:" + #CRLF$ + JSONErrorMessage())
	End
EndIf

ExtractJSONList(JSONValue(Json), SearchReplaceItems())

If ListSize(SearchReplaceItems()) = 0 
	End ; Cheerio, nothing to do...
EndIf


; now read the Html-File

FF = ReadFile(#PB_Any, Executable)

If FF = 0
	MessageRequester(#AppName, "Couldn't load file '" + Executable + "'")
	End
EndIf

HtmlContent.s = ReadString(FF, #PB_File_IgnoreEOL)

CloseFile(FF)

; now Search & Replace

ForEach SearchReplaceItems()
  If SearchReplaceItems()\Search
    HtmlContent = ReplaceString(HtmlContent, SearchReplaceItems()\Search, SearchReplaceItems()\Replace)
  EndIf
Next

; and fnially save HTML

FF = CreateFile(#PB_Any, Executable)

If FF = 0
	MessageRequester(#AppName, "Couldn't save file '" + Executable + "'")
	End
EndIf

WriteString(FF, HtmlContent)

CloseFile(FF)

; over and out