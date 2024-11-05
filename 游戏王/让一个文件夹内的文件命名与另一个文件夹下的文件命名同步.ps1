# 设定目标文件夹路径
$targetFolderPath = "\\Pc00\g\g盘娱乐\游戏\单机\03游戏王\01卡片收藏\00卡组童年"

# 设定源文件夹路径数组
$sourceFolderPaths = @(
    "\\Pc00\g\g盘娱乐\游戏\单机\03游戏王\01卡片收藏\01神魔"
    "\\Pc00\g\g盘娱乐\游戏\单机\03游戏王\01卡片收藏\02怪兽普通"
    "\\Pc00\g\g盘娱乐\游戏\单机\03游戏王\01卡片收藏\02怪兽融合"
    "\\Pc00\g\g盘娱乐\游戏\单机\03游戏王\01卡片收藏\02怪兽效果"
    "\\Pc00\g\g盘娱乐\游戏\单机\03游戏王\01卡片收藏\02怪兽仪式"  
    "\\Pc00\g\g盘娱乐\游戏\单机\03游戏王\01卡片收藏\02魔法"
    "\\Pc00\g\g盘娱乐\游戏\单机\03游戏王\01卡片收藏\02陷阱"
)

# 递归获取目标文件夹中的所有图片文件
$targetImageFiles = Get-ChildItem -Path $targetFolderPath -Recurse -Include "*.jpg", "*.png" -File

# 循环遍历目标文件夹中的图片文件
foreach ($targetImageFile in $targetImageFiles) {
    $targetImageName = $targetImageFile.Name
    $targetImageNumber = [regex]::Match($targetImageName, "\d+").Value

    # 循环遍历源文件夹
    foreach ($sourceFolderPath in $sourceFolderPaths) {
        # 递归获取源文件夹中的所有图片文件
        $sourceImageFiles = Get-ChildItem -Path $sourceFolderPath -Recurse -Include "*.jpg", "*.png" -File

        # 在源文件夹中查找匹配的图片文件
        $matchingSourceImageFile = $sourceImageFiles | Where-Object {
            $sourceImageNumber = [regex]::Match($_.Name, "\d+").Value
            $sourceImageNumber -eq $targetImageNumber
        }

        # 如果找到匹配的图片文件，则重命名目标文件夹中的图片文件
        if ($matchingSourceImageFile) {
            $newImageName = $matchingSourceImageFile.Name
            $newImagePath = Join-Path -Path $targetImageFile.Directory.FullName -ChildPath $newImageName

            # 检查目标文件名是否与源文件名相同，如果不同则进行重命名
            if ($targetImageName -ne $newImageName) {
                Rename-Item -Path $targetImageFile.FullName -NewName $newImageName
                Write-Host "Renamed '$targetImageName' to '$newImageName'"
            }
            break  # 跳出当前循环，处理下一个目标文件
        }
    }
}