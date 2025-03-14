# PowerShell-Obfuscated-Code

**WARNING: Use in a controlled/lab environment only!**

## Overview
This PowerShell script demonstrates how malicious actors may encode and decode a command using Base64 with UTF-16LE encoding. 

The encoded command downloads the 7-Zip installer from the official website and then silently installs it using the /S switch. The script then decodes the command and executes it via `Invoke-Expression`

#### This example is intended for educational and testing purposes only. It mimics techniques often used in obfuscated or malicious scripts, and therefore should only be run in a safe, isolated lab environment.

### How It Works

The script contains an original PowerShell command that:

- Downloads the 7-Zip installer from 7-Zip.org to C:\Temp\7z2409-x64.exe.
- Installs 7-Zip silently by running the installer with the /S argument.
- The original command is converted into a byte array using Unicode (UTF-16LE) encoding, then encoded into a Base64 string.
- The script decodes the Base64 string back to the original command.
- The decoded command is executed using Invoke-Expression.

### Prerequisites:

- Windows with PowerShell installed.
- Run the script in a controlled lab environment with appropriate permissions.
- Open an elevated PowerShell session.

## Line-By-Line Breakdown of the Script

```
$originalCommand = '(New-Object System.Net.WebClient).DownloadFile("https://www.7-zip.org/a/7z2409-x64.exe", "C:\Temp\7z2409-x64.exe"); Start-Process "C:\Temp\7z2409-x64.exe" -ArgumentList "/S" -Wait'
```

This line saves a command as text. That command downloads the 7-Zip installer from the web and runs it silently (with /S).

`(New-Object System.Net.WebClient)` creates a new instance of the .NET WebClient class. This object is used to download data from the Internet (or upload data) easily.

----

```
$bytes = [System.Text.Encoding]::Unicode.GetBytes($originalCommand)
```

This converts the text command into a series of numbers (bytes) using Unicode encoding (UTF-16LE).

----

```
$encodedCommand = [Convert]::ToBase64String($bytes)
```

This turns the byte array into a Base64 string. Base64 is a way to represent binary data (the bytes) as text.

----

```
$decodedCommand = [System.Text.Encoding]::Unicode.GetString([Convert]::FromBase64String($encodedCommand))
```

This reverses the Base64 encoding by converting the Base64 string back into the original text command.

----

```
Invoke-Expression $decodedCommand
```

This line runs the decoded command as if you had typed it into PowerShell. In this case, it downloads and silently installs 7-Zip.

## This process shows how you can obfuscate a command by encoding it and then decode it back for execution.

**NOTE: The use of `Invoke-Expression` is also generally seen as highly suspect or malicious, the same `Invoke-WebRequest`**
