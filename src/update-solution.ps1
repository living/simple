# Execute este script PowerShell para atualizar o formato da solução
$solutionPath = ".\Simple.sln"
$content = Get-Content $solutionPath
$updatedContent = $content -replace "Microsoft Visual Studio Solution File, Format Version 11.00", "Microsoft Visual Studio Solution File, Format Version 12.00"
$updatedContent = $updatedContent -replace "# Visual Studio 2010", "# Visual Studio Version 17`r`nVisualStudioVersion = 17.0.0.0`r`nMinimumVisualStudioVersion = 10.0.40219.1"
$updatedContent | Set-Content $solutionPath
