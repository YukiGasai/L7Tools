;Mute unmute  Spotify
Numpad2::
	;Run,  %A_WorkingDir%\SpotiKey.au3 0
	Run,  %A_WorkingDir%\ee.exe
Return

;Volume up on Spotify
Numpad1::
	Run,  %A_WorkingDir%\SpotiKey.au3 1
Return

;Volume down on Spotify
Numpad3::
	Run,  %A_WorkingDir%\SpotiKey.au3 2
Return

;Get Next Song
Numpad6::
	Run,  %A_WorkingDir%\SpotiKey.au3 3
Return

;Get Previous Song
Numpad4::
	Run,  %A_WorkingDir%\SpotiKey.au3 4
Return

;Pause
Numpad5::
	Run,  %A_WorkingDir%\SpotiKey.au3 5
Return

;hide/ hide Spotify
Numpad7::
	Run,  %A_WorkingDir%\SpotiKey.au3 6
Return

;Get Lyrics
Numpad9::
	Run,  %A_WorkingDir%\SpotiKey.au3 7
Return

;Run Spotify
Numpad8::
	Run,  %APPDATA%\Spotify\Spotify.exe
Return


;Discord

~d & WheelUP::
	Run, nircmd.exe changeappvolume discord.exe 0.01
Return

~d & WheelDown::
	Run, nircmd.exe changeappvolume discord.exe -0.01
Return

;Spotify

~s & WheelUP::
	Run, nircmd.exe changeappvolume spotify.exe 0.01
Return

~s & WheelDown::
	Run, nircmd.exe changeappvolume spotify.exe -0.01
Return

;Chrome

~c & WheelUP::
	Run, nircmd.exe changeappvolume chrome.exe 0.01
Return

~c & WheelDown::
	Run, nircmd.exe changeappvolume chrome.exe -0.01
Return