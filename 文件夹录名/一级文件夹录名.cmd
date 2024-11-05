@echo off
setlocal enabledelayedexpansion

rem 获取当前文件夹名
for %%A in ("%CD%") do set "folderName=%%~nxA"

rem 创建输出文件
set "outputFile=output.txt"
if exist "%outputFile%" del "%outputFile%"

rem 遍历当前文件夹中的文件和文件夹
for /d %%D in (*) do (
    rem 排除CMD程序自身和输出文件夹
    if /i not "%%D"=="%folderName%" if /i not "%%D"=="%outputFile%" (
        rem 写入文件夹名到输出文件
        echo %%D >> "%outputFile%"
    )
)

rem 遍历当前文件夹中的文件
for %%F in (*) do (
    rem 排除CMD程序自身和输出文件
    if /i not "%%F"=="%~nx0" if /i not "%%F"=="%outputFile%" (
        rem 判断是否为文件
        if exist "%%F" (
            rem 写入文件名到输出文件
            echo %%F >> "%outputFile%"
        )
    )
)

rem 输出结果
echo 文件和文件夹名已成功存储到 %outputFile% 文件中。

endlocal