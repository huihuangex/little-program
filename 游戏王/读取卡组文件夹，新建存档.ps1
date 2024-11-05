# 获取当前目录路径
$currentFolderPath = Get-Location

# 获取当前目录中的所有文件名（包括子文件夹）
$fileNames = Get-ChildItem -Path $currentFolderPath -Recurse | Where-Object { $_.PSIsContainer -eq $false -and $_.Name -notlike "*.ps1" } | ForEach-Object {
    $fileNameWithDigits = $_.Name -replace "\D", ""
    $fileNameWithDigits
}

# 输出文件名到文本文件
$outputFilePath = Join-Path -Path $currentFolderPath -ChildPath "Output.txt"
$fileNames | Out-File -FilePath $outputFilePath -Encoding UTF8

Write-Host "文件名已输出到 $outputFilePath"