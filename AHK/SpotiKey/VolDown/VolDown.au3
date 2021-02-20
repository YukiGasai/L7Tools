#include <WinAPI.au3>
Global $XPOS = 2000

Opt("WinWaitDelay", 0)
opt("PixelCoordMode",0)

If ProcessExists("spotify.exe") Then

   ;$oldWin = WinGetHandle("[active]")
   $text = "Chrome Legacy Window"
   $title =  WinGetTitle ( "[CLASS:Chrome_WidgetWin_0]", $text  )
   $title = _CheckOpen($title)
   if Not StringInStr(StringLower (_WinGetPath($title)), "spotify.exe")Then
	  Exit
   EndIf


		 ;VOL+
		 ;ControlSend  ( $title, $text,"","^{up}")
		 For $i = 1267 to  1197 Step -3
			;ConsoleWrite( $i &":  " &MemoryReadPixel($i, 757, $hwnd) & "             -              ")
			if MemoryReadPixel($i, 757, WinGetHandle($title, $text)) == "B3B3B3" Then
			   ControlClick($title, $text, "", "left" , 1 , $i-1, 757)
			   ControlClick($title, $text, "", "left" , 1 , $i, 790)
			   Exit
			EndIf
		 Next
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

