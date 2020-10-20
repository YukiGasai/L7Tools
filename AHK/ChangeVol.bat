set arg1=%1
set arg2=%2
shift
shift
for /F "TOKENS=1,2,*" %%a in ('tasklist /FI "IMAGENAME eq %arg1%"') do nircmd changeappvolume /%%b %arg2%

