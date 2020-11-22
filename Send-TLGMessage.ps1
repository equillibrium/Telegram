
<#PSScriptInfo

.VERSION 1.0.0

.GUID b2176298-83d6-498c-a83f-459943e805e0

.AUTHOR Alexander Myltsev

.COMPANYNAME TASS

.COPYRIGHT 2020 Alexander M. Myltsev

.TAGS telegram

.LICENSEURI

.PROJECTURI https://github.com/equillibrium/Telegram/blob/main/README.md

.ICONURI

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES
Initial release

.PRIVATEDATA

#>

<# 

.DESCRIPTION 
Sends Telegram Message to user, channel or group by Telegram ID 

#>

[CmdletBinding()]

Param(
    [parameter(Mandatory=$true,HelpMessage="Enter message text",ValueFromPipeline=$true)]
    [string]$Text,

    [parameter(Mandatory=$true,HelpMessage="Enter an ID of Telegram User, Channel or group")]
    [string]$RecieverID,

    [parameter(Mandatory=$true,HelpMessage="Enter Telegram Bot API Token recieved from @BotFather")]
    [string]$BotToken,

    [parameter(Mandatory=$false,HelpMessage="Specifying this parameter sends a message without sound norification")]
    [switch]$DisableNotification,

    [parameter(Mandatory=$false,HelpMessage="Specifying this parameter enables Proxy if Telegram servers are not accessable")]
    [switch]$UseProxy,

    [parameter(Mandatory=$false,HelpMessage="Enter proxy address i.e. http://proxy.tlg.org")]
    [string]$ProxyAddress,

    [parameter(Mandatory=$false,HelpMessage="Enter proxy port i.e. 1234")]
    [string]$ProxyPort,

    [parameter(Mandatory=$false,HelpMessage="Enter proxy user name")]
    [string]$ProxyUserName,

    [parameter(Mandatory=$false,HelpMessage="Enter proxy password")]
    [string]$ProxyPassword
)

#region Construct payload
$payload = @{
    "chat_id" = $RecieverID;
    "text" = $Text;
    "disable_notification" = $($DisableNotification.ToBool());
    "parse_mode" = "HTML"
}
#endregion Construct payload

#region Construct Proxy Settings
if ($UseProxy) {
    $ProxySecPass = ConvertTo-SecureString "$ProxyPassword" -AsPlainText -Force
    $ProxyCredentials = New-Object System.Management.Automation.PSCredential -ArgumentList "$ProxyUserName",$ProxySecPass
}
#endregion Construct Proxy Settings

#region Construct WebRequest
$WebRequestOBJ = @{
    "Uri" = ("https://api.telegram.org/bot{0}/sendMessage" -f $BotToken)
    "Method" = "Post"
    "ContentType" = "application/json;charset=utf-8"
    "Body" = (ConvertTo-Json -Compress -InputObject $payload)
}

# Add Proxy Parameters if UseProxy is specified
if ($UseProxy) {
    $WebRequestOBJ += @{
        "Proxy" = "$ProxyAddress`:$ProxyPort"
        "ProxyCredential" = $ProxyCredentials
    }
}
#endregion Construct WebRequest

#region Invoke WebRequest to Send Message
Invoke-WebRequest @WebRequestOBJ | Select-Object -ExpandProperty StatusDescription
#endregion Invoke WebRequest to Send Message