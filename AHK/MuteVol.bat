set arg1=%1
shift
for /F "TOKENS=1,2,*" %%a in ('tasklist /FI "IMAGENAME eq %arg1%"') do nircmd muteappvolume /%%b 2
