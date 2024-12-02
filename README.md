# pwsh-llm

A PowerShell script to help you call Large Language Models (LLM) in your terminal.

## Overview

This project provides a set of PowerShell functions to interact with Azure OpenAI services. It includes functions to start chat sessions, get assistance with fixing errors, and more.

## Setup

To set up this tool, you need to run the `setup.ps1` script. This script will prompt you to enter your Azure OpenAI Endpoint and API Key, and it will set these values as environment variables for the entire machine. It will also copy the `pwsh-llm.ps1` script to your PowerShell profile directory and update your PowerShell profile to import this script automatically.

### Steps to Setup

1. Open a PowerShell terminal.
2. Run the `setup.ps1` script:
    ```powershell
    .\setup.ps1
    ```
3. Follow the prompts to enter your Azure OpenAI Endpoint and API Key.
4. Reopen the terminal

## Usage

After setting up, you can use the following functions provided by the `pwsh-llm.ps1` script:

### Functions

- **gpt-test**: Start a test chat session.
    ```powershell
    gpt-test
    ```

- **gpt-fix**: Provide an error message to get assistance in fixing the issue.
    ```powershell
    gpt-fix "Your error message here"
    ```

- **gpt-chat**: Start a chat session with the assistant.
    ```powershell
    gpt-chat "Your message here"
    ```

- **gpt-quit**: Quit the chat session and clean up the context.
    ```powershell
    gpt-quit
    ```

- **Show-GptHelp**: Display available commands.
    ```powershell
    Show-GptHelp
    ```
### Example
```powershell
PS C:\Users\*> gpt-test
Q: Let's begin the chat
A: Sure, I'm here to help! What do you need assistance with today?
PS C:\Users\concao> gpt-chat "how to login Azure"
To log in to Azure using PowerShell, you can use the `Connect-AzAccount` cmdlet. Here are the steps to log in:

1. **Install Azure PowerShell Module**: If you haven't already installed the Azure PowerShell module, you need to do that first. Open your PowerShell and run the following command:

   
   Install-Module -Name Az -AllowClobber -Force

2. **Import the Module**: Once the module is installed, you should import it into your PowerShell session:

   
   Import-Module Az
   

3. **Log in to Azure**: Use the `Connect-AzAccount` cmdlet to log in to your Azure account. Simply run:


   Connect-AzAccount


   This command will open a new window prompting you to enter your Azure credentials. After entering your username and password, you will be logged in.

4. **Verify Login**: To verify that you have successfully logged in, you can run:

   Get-AzContext
   

   This command will display information about the current Azure session, including the account and subscription details.

code Example:
Here is a full example of the steps combined:

# Step 1: Install the Azure PowerShell module (if not already installed)
Install-Module -Name Az -AllowClobber -Force

# Step 2: Import the Azure PowerShell module
Import-Module Az

# Step 3: Log in to your Azure account
Connect-AzAccount

# Step 4: Verify the login
Get-AzContext


### Notes:
- If you encounter any issues during installation, make sure you are running PowerShell as an administrator.
- Ensure that your network allows access to Azure services and that there are no firewall rules blocking the authentication process.
- For organizations using multi-factor authentication (MFA), the login prompt will include steps for completing MFA.

If you have any specific requirements or encounter any issues, please provide those details for further assistance.
```
## Contributing
Feel free to submit issues or pull requests if you have any improvements or suggestions.

## 
This project is licensed under the MIT License.

