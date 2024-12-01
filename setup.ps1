# set endpoint and api key into environment variables
if (-not ([System.Environment]::GetEnvironmentVariable("Azure_OpenAI_ApiKey", [System.EnvironmentVariableTarget]::Machine)) -or -not ([System.Environment]::GetEnvironmentVariable("Azure_OpenAI_Endpoint", [System.EnvironmentVariableTarget]::Machine))) {
    $endpoint = Read-Host -Prompt "Enter your Azure OpenAI Endpoint"
    $apiKey = Read-Host -Prompt "Enter your Azure OpenAI API Key"
    [System.Environment]::SetEnvironmentVariable("Azure_OpenAI_ApiKey", $apiKey, [System.EnvironmentVariableTarget]::Machine)
    [System.Environment]::SetEnvironmentVariable("Azure_OpenAI_Endpoint", $endpoint, [System.EnvironmentVariableTarget]::Machine)
}

$sourcePath = "pwsh-llm.ps1"
$destinationPath = "$HOME\Documents\PowerShell\pwsh-llm.ps1"
Copy-Item -Path $sourcePath -Destination $destinationPath -Force

# copy pwsh-llm.ps1 to ~\Documents\PowerShell\pwsh-llm.ps1
$PowerShell_profile_path = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
if (-not (Get-Content -Path $PowerShell_profile_path -Raw).Contains("pwsh-llm")) {
    $importLine = "`n. `$HOME\Documents\PowerShell\pwsh-llm.ps1"
    Add-Content -Path $PowerShell_profile_path -Value $importLine
}