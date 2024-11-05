@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

set "targetFolder=%cd%"
set "searchString=[澄空]"

for /r "%targetFolder%" %%F in (*) do (
    set "filename=%%~nxF"
    set "newFilename=!filename:%searchString%=!"

    if not "!filename!"=="!newFilename!" (
        pushd "%%~dpF"
        ren "%%~nxF" "!newFilename!"
        popd
        echo "文件 %%F 已重命名为 !newFilename!"
    )
)

echo "所有符合条件的文件已重命名完成。"

endlocal