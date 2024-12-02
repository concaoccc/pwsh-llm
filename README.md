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
    gpt-fix -errorMessage "Your error message here"
    ```

- **gpt-chat**: Start a chat session with the assistant.
    ```powershell
    gpt-chat -message "Your message here"
    ```

- **gpt-quit**: Quit the chat session and clean up the context.
    ```powershell
    gpt-quit
    ```

- **Show-GptHelp**: Display available commands.
    ```powershell
    Show-GptHelp
    ```
## Contributing
Feel free to submit issues or pull requests if you have any improvements or suggestions.

## 
This project is licensed under the MIT License.

