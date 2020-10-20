#include <WinAPI.au3>

Opt("WinWaitDelay", 0)



If ProcessExists("spotify.exe") Then

   $text = "Chrome Legacy Window"
   $title =  WinGetTitle ( "[CLASS:Chrome_WidgetWin_0]", $text  )

   $title = _CheckOpen($title)

   ConsoleWrite($title)
   if Not StringInStr(StringLower (_WinGetPath($title)), "spotify.exe")Then
	  Exit
   EndIf
      ConsoleWrite("CLICK")
    ControlClick( $title ,$text,"","left",1,600, 750)
   EndIf



;;Checks if the Spotify Window is open by checking the size Spotify has to by 1300 wide
Func _CheckOpen($title)
   $text = "Chrome Legacy Window"

   $size = WinGetClientSize($title,$text)

   if( @error <> 0 ) Then
	  $activ  = WinGetHandle("[active]")
	  Run(@AppDataDir & "\Spotify\Spotify.exe")
	  WinWait("[CLASS:Chrome_WidgetWin_0]",$text)
	  $title =  WinGetTitle ( "[CLASS:Chrome_WidgetWin_0]", $text  )
	  WinMove($title ,$text ,0,0,1300,800)
	  WinActivate ( $activ )
	  Return $title
   Elseif($size[0] <> 1300) Then
	  $activ  = WinGetHandle("[active]")
	  Run(@AppDataDir & "\Spotify\Spotify.exe")
	  WinWait("[CLASS:Chrome_WidgetWin_0]",$text)
	  $title =  WinGetTitle ( "[CLASS:Chrome_WidgetWin_0]", $text  )
	  WinMove($title ,$text ,0,0,1300,800)
	  WinActivate ( $activ )
	  Return $title
   ELSE
	  Return WinGetTitle($title, $text)
   EndIf
EndFunc

;Not my Code can get Path to Exe by Title with magic
 Func _WinGetPath($Title="", $strComputer='localhost')
    $win = WinGetTitle($Title)
    $pid = WinGetProcess($win)
   $wbemFlagReturnImmediately = 0x10
   $wbemFlagForwardOnly = 0x20
   $colItems = ""
   $objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\CIMV2")
   $colItems = $objWMIService.ExecQuery ("SELECT * FROM Win32_Process WHERE ProcessId = " & $pid, "WQL", _
         $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
   If IsObj($colItems) Then
      For $objItem In $colItems
         If $objItem.ExecutablePath Then Return $objItem.ExecutablePath
      Next
   EndIf
EndFunc

