#requires -RunAsAdministrator

Write-Host " Available VPNs " -BackgroundColor White -ForegroundColor Black
Get-VpnConnection | Select-Object -ExpandProperty Name

$vpnName = Read-Host -Prompt "`nType the name of a VPN connection to auto-connect to" -

$taskProperties = [ordered]@{
    "TemplatePath"    = "$($PSScriptRoot)\Task Template.xml"
    "{{author}}"      = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
    "{{description}}" = "Automatically connects to $($vpnName)."
    "{{name}}"        = "\Microsoft\VPN Auto-Connect ($($vpnName))"
    "{{userSid}}"     = [System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value
    "{{exePath}}"     = "Rasdial.exe"
    "{{arguments}}"   = $vpnName
}

$taskXml = Get-Content -Path $taskProperties.TemplatePath -Raw
# replace XML placeholders with values from $taskProperties
foreach ($placeholderKey in $taskProperties.Keys) {
    $taskXml = $taskXml -replace $placeholderKey, $taskProperties[$placeholderKey]
}

Register-ScheduledTask -TaskName $taskProperties["{{name}}"] -Xml $taskXml -Force