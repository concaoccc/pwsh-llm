# Set endpoint and API key into environment variables
if (-not ([System.Environment]::GetEnvironmentVariable("Azure_OpenAI_ApiKey", [System.EnvironmentVariableTarget]::Machine)) -or 
    -not ([System.Environment]::GetEnvironmentVariable("Azure_OpenAI_Endpoint", [System.EnvironmentVariableTarget]::Machine))) {
    $endpoint = Read-Host -Prompt "Enter your Azure OpenAI Endpoint"
    $apiKey = Read-Host -Prompt "Enter your Azure OpenAI API Key"
    [System.Environment]::SetEnvironmentVariable("Azure_OpenAI_ApiKey", $apiKey, [System.EnvironmentVariableTarget]::Machine)
    [System.Environment]::SetEnvironmentVariable("Azure_OpenAI_Endpoint", $endpoint, [System.EnvironmentVariableTarget]::Machine)
}

$sourcePath = "pwsh-llm.ps1"
$destinationPath = "$HOME\Documents\PowerShell\pwsh-llm.ps1"
Copy-Item -Path $sourcePath -Destination $destinationPath -Force

# Copy pwsh-llm.ps1 to ~\Documents\PowerShell\pwsh-llm.ps1
$PowerShell_profile_path = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
$Windows_PowerShell_profile_path = "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

function Append_powershell_profile($profile_path) {
    if (-not (Test-Path -Path $Windows_PowerShell_profile_path)) {
        New-Item -Path $Windows_PowerShell_profile_path -ItemType File
        $importLine = "`n. `$HOME\Documents\PowerShell\pwsh-llm.ps1"
        Add-Content -Path $Windows_PowerShell_profile_path -Value $importLine
    } elseif (-not (Get-Content -Path $Windows_PowerShell_profile_path -Raw).Contains("pwsh-llm")) {
        $importLine = "`n. `$HOME\Documents\PowerShell\pwsh-llm.ps1"
        Add-Content -Path $Windows_PowerShell_profile_path -Value $importLine
    }
}

Append_powershell_profile $PowerShell_profile_path
Append_powershell_profile $Windows_PowerShell_profile_path