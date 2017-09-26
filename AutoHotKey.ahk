; partial match of window title
SetTitleMatchMode, 2

;###############################################################################
; Mac                                                                          #
;###############################################################################

; preliminary setup in SharpKeys
; LAlt (positioned as Cmd on Mac keyboard) is remapped to LCtrl (kinda new Cmd)
; LWin (positioned as Alt on Mac keyboard) is remapped to LAlt
; PrtSc is remapped to LWin (to be able to use Win sometimes)
; lCtrl remains Ctrl to use it in Terminal as expected

; window switch like Mac's Cmd+Tab
LCtrl & Tab::AltTab

; language switch like Mac's Cmd+Space
LCtrl & Space::
  KeyWait, Space
  KeyWait, LCtrl
  Send {Ctrl Down}{Shift Down}{Shift Up}{Ctrl Up}
return

; Chrome and Chromium remappings
IfWinActive, ahk_exe chrome.exe
{
  ; DevTools like Mac's Alt+Cmd+I
  ^!SC017::Send {F12}

  ; jump to the address bar like Mac's Cmd+L
  ^SC026::Send !{SC020}

  ; view page source like Mac's Alt+Cmd+U
  !^SC016::Send ^{SC016}
}
return

; special symbols remappings like on Mac's Russian default layout
+SC005::EnforceLayoutSymbol(0x4190419, "%") ; Shift+4
+SC006::EnforceLayoutSymbol(0x4190419, ":") ; Shift+5
+SC007::EnforceLayoutSymbol(0x4190419, ",") ; Shift+6
+SC008::EnforceLayoutSymbol(0x4190419, ".") ; Shift+7
+SC009::EnforceLayoutSymbol(0x4190419, ";") ; Shift+8
 SC035::EnforceLayoutSymbol(0x4190419, "/") ; /
+SC035::EnforceLayoutSymbol(0x4190419, "?") ; Shift+/

EnforceLayoutSymbol(layout, symbol)
{
  WinGet, WinID,, A
  ThreadID := DllCall("GetWindowThreadProcessId", "Int", WinID, "Int", 0)
  KeyboardLayout := DllCall("GetKeyboardLayout", "Int", ThreadID)
  if (KeyboardLayout == layout)
  {
    SendRaw %symbol%
  }
  else
  {
    OriginalHotKey := A_ThisHotkey
    if OriginalHotKey contains +
    {
      StringReplace, OriginalHotKey, OriginalHotKey, +
      Send +{%OriginalHotKey%}
    }
    else
    {
      Send {%OriginalHotKey%}
    }
  }
  return
}

;###############################################################################
; Custom bindings and remappings                                               #
;###############################################################################

; disable PgUp and PgDn positioned too close to arrows
*PgUp::Return
*PgDn::Return

;###############################################################################
; Fast switch between mostly used apps                                         #
;###############################################################################

; Atom
!a::
IfWinExist, ahk_exe atom.exe
{
  WinActivate
}
else
{
  Run, "%LOCALAPPDATA%\atom\atom.exe"
}
return

; Chrome
!c::
IfWinExist, - Google Chrome ahk_exe chrome.exe
{
  WinActivate
}
else
{
  Run, "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe"
}
return

; Chromium
+!c::
IfWinExist, - Chromium ahk_exe chrome.exe
{
  WinActivate
}
else
{
  Run, "%LOCALAPPDATA%\Chromium\Application\chrome.exe"
}
return

; File manager
!f::
IfWinExist, ahk_class CabinetWClass ahk_exe explorer.exe
{
  WinActivate
}
else
{
  Run, "%WINDIR%\explorer.exe"
}
return

; Firefox
+!f::
IfWinExist, ahk_exe firefox.exe
{
  WinActivate
}
else
{
  Run, "%LOCALAPPDATA%\Mozilla Firefox\firefox.exe"
  WinWait, ahk_exe firefox.exe
  WinActivate
}
return

; GitKraken
!g::
IfWinExist, ahk_exe gitkraken.exe
{
  WinActivate
}
else
{
  Run, "%LOCALAPPDATA%\gitkraken\Update.exe" --processStart "gitkraken.exe"
}
return

; Internet Explorer
!i::
IfWinExist, ahk_class IEFrame
{
  WinActivate
}
else
{
  Run, "%ProgramFiles%\Internet Explorer\iexplore.exe"
  WinWait, ahk_class IEFrame
  WinActivate
}
return

; IntelliJ Idea
!j::
IfWinExist, ahk_exe idea64.exe
{
  WinActivate
}
else
{
  Run, "%ProgramFiles%\JetBrains\IntelliJ IDEA 2017.2.3\bin\idea64.exe"
  WinWait, ahk_exe idea64.exe
  WinActivate
}
return

; Outlook
!o::
IfWinExist, ahk_exe OUTLOOK.EXE
{
  WinActivate
}
else
{
  Run, "%ProgramFiles% (x86)\Microsoft Office\Office15\OUTLOOK.exe"
}
return

; SourceTree
!s::
IfWinExist, ahk_exe SourceTree.exe
{
  WinActivate
}
else
{
  Run, "%LOCALAPPDATA%\SourceTree\SourceTree.exe"
}
return

; VirtualBox
!v::
IfWinExist, ahk_exe VirtualBox.exe
{
  WinActivate
}
else
{
  Run, "%ProgramFiles%\Oracle\VirtualBox\VirtualBox.exe"
}
return

; WorkFlowy
!w::
IfWinExist, ahk_exe WorkFlowy.exe
{
  WinActivate
}
else
{
  Run, "%LOCALAPPDATA%\WorkFlowy\WorkFlowy.exe"
}
return

; Terminal
!z::
IfWinExist, ahk_exe mintty.exe
{
  WinActivate
}
else
{
  Run, "%LOCALAPPDATA%\Programs\Git\git-bash.exe"
}
return
