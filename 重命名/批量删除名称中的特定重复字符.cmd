@echo off
setlocal enabledelayedexpansion

rem 设置要去除的特定字符
set "specialChars=#PSPKK"

rem 遍历当前文件夹中的文件
for %%F in (*) do (
    rem 检查文件名是否含有特定字符
    set "fileName=%%~nxF"
    set "newFileName=!fileName:%specialChars%=!"

    rem 判断是否需要重命名
    if not "!fileName!"=="!newFileName!" (
        rem 重命名文件
        ren "%%F" "!newFileName!"
        echo 文件 "%%F" 重命名为 "!newFileName!"
    )
)

rem 输出结果
echo 所有含有特定字符的文件已重命名完成。

endlocal