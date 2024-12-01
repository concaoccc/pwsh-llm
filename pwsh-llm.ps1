

# Example usage:
# $apiKey = "your_api_key_here"
# $endpoint = "https://your_endpoint_here"
# $prompt = "Hello, how are you?"
# $response = Invoke-AzureOpenAI -apiKey $apiKey -endpoint $endpoint -prompt $prompt
# Write-Output $response

if (-not $env:Azure_OpenAI_ApiKey -or -not $env:Azure_OpenAI_Endpoint) {
    Write-Error "API key or endpoint is not set. Please set the environment variables 'Azure_OpenAI_ApiKey' and 'Azure_OpenAI_Endpoint'."
    exit 1
}

$global:apiKey =  [System.Environment]::GetEnvironmentVariable("Azure_OpenAI_ApiKey", [System.EnvironmentVariableTarget]::Machine)
$endpoint = [System.Environment]::GetEnvironmentVariable("Azure_OpenAI_Endpoint", [System.EnvironmentVariableTarget]::Machine)
$global:currentMehtod = "get-test"
$global:messgaes = @()
[int]$global:maxTokens = 5000
[double]$global:temperature = 0.7

$global:chat_system_prompt = "Here is your role: 

I am an expert in PowerShell and Windows. I can help you with any questions or issues you may have related to these topics. Please provide specific information about what you need assistance with, and I will guide you through the process.

# Steps

1. **Understand the Question**: Clearly define the PowerShell or Windows-related issue or question.
2. **Gather Information**: Identify any specific requirements, conditions, or constraints mentioned by the user.
3. **Research or Recall**: Utilize knowledge of PowerShell commands, scripts, or Windows functions relevant to the question.
4. **Provide Explanation**: Offer a detailed explanation or guide that addresses the user's query.
5. **Verify Output**: Ensure any scripts, commands, or steps provided are correct and effective for the intended outcome.

# Output Format

Please provide solutions or explanations in clear, step-by-step instructions. For scripts or commands, ensure they are presented in a readable format without code blocks unless requested specifically.

# Examples

Example 1: 
- **User's Question**: 'How can I list all services running on my Windows machine using PowerShell?'
- **Response**: 
  - 'To list all running services, you can use the following PowerShell command: `Get-Service | Where-Object { $_.Status -eq 'Running' }`. This command retrieves all services and filters to show only those currently running.'

# Notes

- Ensure to clarify whether the user needs explanations on PowerShell syntax or Windows functionalities.
- Always test and verify PowerShell commands or scripts before sharing, if feasible."

$global:fix_system_prompt = 'Here is your role:
Please provide the PowerShell command you are encountering issues with, as well as the error message details. I will assist you in identifying the root cause of the problem and guide you on how to resolve it effectively.

# Steps

1. **Understand the Error:**
   - Analyze the error message provided to identify any common issues or misunderstandings.
   - Consider syntax errors, command usage mistakes, or environmental factors that might influence the execution of the command.

2. **Investigate the Root Cause:**
   - Assess if the error is due to a specific parameter, module, or script malfunction.
   - Check for necessary permissions or prerequisites that might be missing.

3. **Provide Solutions:**
   - Suggest possible fixes for the identified issues.
   - Offer alternative command syntax if applicable.
   - Advise on additional troubleshooting steps if the problem persists.

# Examples

### Example 1

**Command:**  
`Get-Content somefile.txt | where {$_.length -gt 100}`

**Error Message:**  
`The term where is not recognized as the name of a cmdlet.`

**Diagnosis and Solution:**
- **Root Cause:** The PowerShell such as versions v1 or v2 are using aliases, but somewhat an issue might have caused the alias not to work.
- **Fix:** Use the full cmdlet name: `Where-Object`, e.g., `Get-Content somefile.txt | Where-Object {$_.length -gt 100}`.

### Example 2

**Command:**  
`Invoke-Command -ScriptBlock {Get-Process}`

**Error Message:**  
`Invoke-Command : The term "Get-Process" is not recognized as the name of a cmdlet, function, script file, or operable program.`

**Diagnosis and Solution:**
- **Root Cause:** The error suggests that remotely executed commands may not have access to the modules or snap-ins required.
- **Fix:** Ensure that the necessary modules are imported at the remote session beginning within the `-ScriptBlock`. e.g., `Invoke-Command -ScriptBlock {Import-Module Process; Get-Process}`

# Output Format

Provide step-by-step guidance in a structured format that includes diagnosis and potential fixes. Use bullet points to detail solutions and any alternative commands if necessary.

# Notes

- Ensure the PowerShell environment is up-to-date with necessary modules installed.
- Provide clear explanations for each troubleshooting step.
- Always ensure that you are running with adequate permissions to execute the desired commands.
'

function Invoke-AzureOpenAI {
    $headers = @{
        "api-key" = $global:apiKey
    }

    $body = @{
        "messages" = $global:messages
        "max_tokens"  = $global:lobalmaxTokens
        "temperature" = $global:temperature
    } | ConvertTo-Json

    $response = Invoke-RestMethod -Uri $global:endpoint -Method Post -Headers $headers -Body $body -ContentType 'application/json'

    return $response.choices[0].message.content
}

function gpt-test {
    Write-Output "Q: Let's begin the chat"
    $global:currentMehtod = "get-test"
    $global:messgaes = @(
        @{ "role" = "system"; "content" = "You are a helpful assistant." },
        @{ "role" = "user"; "content" = "Let's begin the chat." })
    $response = Invoke-AzureOpenAI
    Write-Output "A: $response"
}

function gpt-fix {
    param (
        [string]$errorMessage
    )

    if ($global:currentMehtod -ne "get-fix") {
        $global:currentMehtod = "get-fix"
        $global:messgaes = @(
            @{ "role" = "system"; "content" = $global:fix_system_prompt }
        )
    }
    $history = Get-History -Count 1
    if ($history.Count -eq 1) {
        $previousCommand = $history[0].CommandLine
        $global:messgaes += @(
            @{ "role" = "user"; "content" = "Command: $previousCommand; Error message: $errorMessage" }
        )
    } else {
        Write-Error "No previous command found."
    }

    $response = Invoke-AzureOpenAI
    Write-Output "$response"
}

function gpt-chat {
    param (
        [string]$message
    )

        if ($global:currentMehtod -ne "get-chat") {
            $global:currentMehtod = "get-chat"
            $global:messgaes = @(
                @{ "role" = "system"; "content" = $global:chat_system_prompt }
            )
        }

        $global:messgaes += @{ "role" = "user"; "content" = $message }
        $response = Invoke-AzureOpenAI
        $global:messgaes += @{ "role" = "system"; "content" = $response }
        Write-Output "$response"
}

function gpt-quit {
    Write-Output "Cleaning up chat context and exiting..."
    $messages = @()
    $currentMehtod = "get-chat"
}
