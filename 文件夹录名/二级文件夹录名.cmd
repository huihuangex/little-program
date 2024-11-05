@echo off
setlocal enabledelayedexpansion

REM 获取当前文件夹路径
set "current_dir=%cd%"

REM 获取CMD程序的文件名（不包括扩展名）
set "cmd_filename=%~n0"

REM 获取输出文档的文件名
set "output_file=output.txt"

REM 创建输出文档
if exist "%output_file%" del "%output_file%"

REM 遍历文件夹获取文件夹名并保存到数组
set "folder_index=0"
for /d %%i in (*) do (
    REM 排除CMD程序自身的文件夹名
    if /i not "%%~nxi"=="%cmd_filename%" (
        set "folders[!folder_index!]=%%~nxi"
        set /a "folder_index+=1"
        
        REM 输出文件夹名
        echo %%~nxi >> "%output_file%"

        REM 输出一级子文件夹名
        for /d %%j in ("%%~nxi\*") do (
            echo    %%~nxj >> "%output_file%"
        )
    )
)

REM 完成提示
echo 文件夹名已保存到 %output_file%
pause
exit