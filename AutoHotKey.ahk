; in case of reloading removes previous instance
#SingleInstance force

; partial match of window title
SetTitleMatchMode, 2

; reload configuration Shift+Ctrl+Alt+R
<+<^<!SC013::Run %A_ScriptFullPath%

;###############################################################################
; Mac                                                                          #
;###############################################################################

; preliminary setup in SharpKeys
; LAlt (positioned as Cmd on Mac keyboard) is remapped to RCtrl (kinda new Cmd)
; LWin (positioned as Alt on Mac keyboard) is remapped to LAlt
; PrtSc is remapped to LWin (to be able to use Win sometimes)
; LCtrl remains Ctrl to use it in Terminal as expected

; quit app like Mac's Cmd+Q
>^SC010::Send !{F4}

; window switch like Mac's Cmd+Tab
>^Tab::AltTab

; language switch like Mac's Cmd+Space
>^Space::
  KeyWait, Space
  KeyWait, LCtrl
  Send {Ctrl Down}{Shift Down}{Shift Up}{Ctrl Up}
return

; Chrome and Chromium remappings
#IfWinActive ahk_exe chrome.exe
  ; prev/next tab like Mac's Alt+Cmd+Left/Right
  <!>^Left::Send ^{PgUp}
  <!>^Right::Send ^{PgDn}

  ; DevTools like Mac's Alt+Cmd+I
  <!>^SC017::Send {F12}

  ; jump to the address bar like Mac's Cmd+L
  >^SC026::Send !{SC020}

  ; view page source like Mac's Alt+Cmd+U
  <!>^SC016::Send ^{SC016}
#IfWinActive

; Terminal remappings
#IfWinActive ahk_exe mintty.exe
  ; copy-paste like Mac's Cmd+C and Cmd+V
  >^SC02E::Send ^{Ins} ; Cmd+C => Ctrl+Ins
  >^SC02F::Send +{Ins} ; Cmd+V => Shift+Ins

  ; clear terminal like Mac's Cmd+R
  >^SC013::Send ^{SC026} ; Cmd+R => Ctrl+L

  ; tmux controls
  ; (Ctrl+\ and numbers are used because work with any language layout)
  >^SC014::  Send {Ctrl Down}{\}{Ctrl Up}{1} ; Cmd+T
  >^SC011::  Send {Ctrl Down}{\}{Ctrl Up}{2} ; Cmd+W
  >^SC027::  Send {Ctrl Down}{\}{Ctrl Up}{3} ; Cmd+:
  >^SC028::  Send {Ctrl Down}{\}{Ctrl Up}{4} ; Cmd+"
  <!>^Left:: Send {Ctrl Down}{\}{Ctrl Up}{5} ; Alt+Cmd+Left
  <!>^Right::Send {Ctrl Down}{\}{Ctrl Up}{6} ; Alt+Cmd+Right
  <!Tab::    Send {Ctrl Down}{\}{Ctrl Up}{7} ; Alt+Tab
#IfWinActive

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

 !a::ActivateOrRunApp("ahk_exe atom.exe", LOCALAPPDATA . "\atom\atom.exe") ; Atom
 !c::ActivateOrRunApp("- Google Chrome ahk_exe chrome.exe", LOCALAPPDATA . "\Google\Chrome\Application\chrome.exe") ; Chrome
+!c::ActivateOrRunApp("- Chromium ahk_exe chrome.exe", LOCALAPPDATA . "\Chromium\Application\chrome.exe") ; Chromium
 !f::ActivateOrRunApp("ahk_class CabinetWClass ahk_exe explorer.exe", WINDIR . "\explorer.exe") ; File manager
+!f::ActivateOrRunApp("ahk_exe firefox.exe", LOCALAPPDATA . "\Mozilla Firefox\firefox.exe") ; Firefox
 !g::ActivateOrRunApp("ahk_exe gitkraken.exe", LOCALAPPDATA . "\gitkraken\Update.exe --processStart gitkraken.exe") ; GitKraken
 !i::ActivateOrRunApp("ahk_class IEFrame", ProgramFiles . "\Internet Explorer\iexplore.exe") ; Internet Explorer
 !j::ActivateOrRunApp("ahk_exe idea64.exe", ProgramFiles . "\JetBrains\IntelliJ IDEA 2017.2.3\bin\idea64.exe") ; IntelliJ Idea
 !o::ActivateOrRunApp("ahk_exe OUTLOOK.EXE", ProgramFiles . " (x86)\Microsoft Office\Office15\OUTLOOK.exe") ; Outlook
 !s::ActivateOrRunApp("ahk_exe SourceTree.exe", LOCALAPPDATA . "\SourceTree\SourceTree.exe") ; SourceTree
 !v::ActivateOrRunApp("ahk_exe VirtualBox.exe", ProgramFiles . "\Oracle\VirtualBox\VirtualBox.exe") ; VirtualBox
 !w::ActivateOrRunApp("ahk_exe WorkFlowy.exe", LOCALAPPDATA . "\WorkFlowy\WorkFlowy.exe") ; WorkFlowy
 !z::ActivateOrRunApp("ahk_exe mintty.exe", LOCALAPPDATA . "\Programs\Git\git-bash.exe") ; Terminal

ActivateOrRunApp(title, app)
{
  IfWinExist, %title%
  {
    WinActivate
  }
  else
  {
    Run %app%
    WinWait, %title%
    WinActivate
  }
  return
}
