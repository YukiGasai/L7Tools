#include <SendMessage.au3>
#include <WinAPI.au3>
Global $XPOS = 2000

Opt("WinWaitDelay", 0)
opt("PixelCoordMode",0)

if $CmdLine[0] <> 1 Then
   Exit
EndIf

If ProcessExists("spotify.exe") Then
   Change($CmdLine[1])
Else
   _CheckOpen("")
EndIf


Func Change($wahl)

   $text = "Chrome Legacy Window"
   $title =  WinGetTitle ( "[CLASS:Chrome_WidgetWin_0]", $text  )

   _CheckOpen($title)

   $hwnd = WinGetHandle($title, $text)
   if Not StringInStr(StringLower (_WinGetPath($title)), "spotify.exe")Then
	  Exit
   EndIf

	  ;VOL-
	  ;ControlSend  ( $title, $text,"","^{up}")
	  If $wahl == 1 then

		 For $i = 1273 to  1200 Step -3
			;ConsoleWrite( $i &":  " &MemoryReadPixel($i, 757, $hwnd) & "             -              ")
			if MemoryReadPixel($i, 757, $hwnd) == "B3B3B3" Then
			   ControlClick($title, $text, "", "left" , 1 , $i-1, 757)
			   ControlClick($title, $text, "", "left" , 1 , $i, 790)
			   Exit
			EndIf
		 Next

	  ;MUTE/UNMUTE
	  ElseIf $wahl == 2 then
		 ControlClick( $title, $text,"","left",1,1187, 758)

	  ;VOL+
	  ;ControlSend  ( $title, $text,"","^{down}")
      ElseIf $wahl == 3 then

		 For $i = 1200 to 1273 Step 3
			;ConsoleWrite( $i &":  " &MemoryReadPixel($i, 757, $hwnd) & "             -              ")
			if MemoryReadPixel($i, 757, $hwnd) == 404040 Then
			   ControlClick($title, $text, "", "left" , 1 , $i+1, 757)
			   ControlClick($title, $text, "", "left" , 1 , $i, 790)
			   Exit
			EndIf
		 Next

      ;Last Song
	  ;ControlSend  ( $title, $text,"","^{left
      ElseIf $wahl == 4 then
		 ControlClick( $title, $text,"","left",1,600, 750)


	  ;Pause/Play
	  ;ControlSend  ( $title, $text,"","{space}")
	  ElseIf $wahl == 5 then
		 ControlClick( $title, $text,"","left",1,650, 750)

	  ;Next Song
	  ;ControlSend  ( $title, $text,"","^{right}")
      ElseIf $wahl == 6 then
		 ControlClick( $title, $text,"","left",1,700, 750)

	  ;Show / Hide Window
	  ElseIf  $wahl == 7 then

		 $pos = WinGetPos($title, $text)
		 if( $pos[0] == $XPOS) Then
			WinMove ($title, $text, 0,0,1300,800)
			WinActivate($title,$text)
		 Else
			WinMove ($title, $text, $XPOS,0,1300,800)
		 EndIf

     ;Add song to liked list
  ElseIf $wahl == 8 Then
		 For $x = 0 To 500 Step 1
			if(MemoryReadPixel($x, 746,$hwnd) == "6994AE") Then
			   ControlClick($title, $text, "", "left", 1, $x, 746)
			   return
			EndIf
		 Next

	  ;Get Lyrics of Song
	  ElseIf $wahl == 9 Then

		 If $title <> "" Or $title <> "Spotify Premium" Or $title <> "Spotify Free" Then
			ShellExecute("https://www.google.com/search?q="& StringReplace($title,"&", "%26") & " lyrics")
		 EndIf

	  EndIf
   EndFunc


;;Checks if the Spotify Window is open by checking the size Spotify has to by 1300 wide
Func _CheckOpen($title)
   $text = "Chrome Legacy Window"

   $size = WinGetClientSize($title,$text)

   if( @error <> 0 or $title == "") Then
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




;Not my Code can get PixelColor behind Window with magic
;Needs WinAPI
Func MemoryReadPixel($x, $y, $handle)
   Local $pos = WinGetPos($handle)
   if($pos[0] == $XPOS)Then
	  WinMove($handle, "", 0,0)
   EndIf
   Local $hDC
   Local $iColor
   Local $sColor

   $hDC = _WinAPI_GetWindowDC($handle)
   $iColor = DllCall("gdi32.dll", "int", "GetPixel", "int", $hDC, "int", $x, "int", $y)
   $sColor = Hex($iColor[0], 6)
   _WinAPI_ReleaseDC($handle, $hDC)

   Return Hex("0x" & StringRight($sColor, 2) & StringMid($sColor, 3, 2) & StringLeft($sColor, 2),6)
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

