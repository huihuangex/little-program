@echo off
setlocal enabledelayedexpansion

set "targetFolder=%cd%"
set "searchString=[720p]"

for %%F in ("%targetFolder%\*%searchString%*") do (
    set "filename=%%~nxF"
    set "newFilename=!filename:%searchString%=!"

    if not "!filename!"=="!newFilename!" (
        ren "%%F" "!newFilename!"
        echo "文件 %%F 已重命名为 !newFilename!"
    )
)

echo "所有符合条件的文件已重命名完成。"

endlocal