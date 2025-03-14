# WARNING: Use in a controlled/lab environment only!

# This command that downloads 7-Zip and then installs it silently.
$originalCommand = '(New-Object System.Net.WebClient).DownloadFile("https://www.7-zip.org/a/7z2409-x64.exe", "C:\Temp\7z2409-x64.exe"); Start-Process "C:\Temp\7z2409-x64.exe" -ArgumentList "/S" -Wait'

# Convert the original command to a byte array using Unicode (UTF-16LE) encoding.
$bytes = [System.Text.Encoding]::Unicode.GetBytes($originalCommand)

# Encode the byte array into a Base64 string.
$encodedCommand = [Convert]::ToBase64String($bytes)

# Decode the Base64 string back to the original command.
$decodedCommand = [System.Text.Encoding]::Unicode.GetString([Convert]::FromBase64String($encodedCommand))

# Execute the decoded command.
Invoke-Expression $decodedCommand
