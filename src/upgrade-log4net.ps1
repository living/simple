# PowerShell script para atualizar referências
$projectFiles = Get-ChildItem -Path "\" -Filter "*.csproj" -Recurse
foreach ($file in $projectFiles) {
    $content = Get-Content $file.FullName -Raw
    
    # Atualiza a referência HintPath
    $updatedContent = $content -replace "log4net\..*\\log4net\.dll", "log4net.2.0.15\lib\net45\log4net.dll"
    
    # Atualiza referência direta
    $updatedContent = $updatedContent -replace '<Reference Include="log4net,.*?">', '<Reference Include="log4net, Version=2.0.15.0, Culture=neutral, PublicKeyToken=669e0ddf0bb1aa2a, processorArchitecture=MSIL">'
    
    # Salva o arquivo
    if ($content -ne $updatedContent) {
        Set-Content $file.FullName $updatedContent
        Write-Host "Atualizado: $($file.FullName)"
    }
}
