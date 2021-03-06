# Telegram
Powershell tools for Telegram Messenger
# Sponsor the project
If any of the scripts that I have created helped you, please consider donating to support the work.
Don't hesitate to request any features or ask for an advice on implementing the tools that I provide.
Any amount helps my projects a lot! Thank you very much!

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/paypalme/equillibrium45)

# Send-TLGMessage How-to-use
This script lets you send a message using Telegram - fast, cool and secure messenger.
You can use it to send a message when a script is finished, when your SCCM OSD Task Sequence ended or encountered an error, when there's a new application version found (i.e. by you other site-crawling script) - pretty much any notification can be done using this tool.
How to use it:
1. Install [Telegram](https://telegram.org) and register an account.
2. Get yourself a Telegram bot using [@BotFather](https://t.me/BotFather) inside Telegram
3. Get your Bot API token from [@BotFather](https://t.me/BotFather)
4. Create a goup or channel or use existing chats to get your messages.
5. Get you chat, group or channel ID using [this guide](https://stackoverflow.com/questions/32423837/telegram-bot-how-to-get-a-group-chat-id#:~:text=Go%20to%20the%20group%2C%20click,dummy%20message%20to%20the%20bot.&text=4%2D%20Look%20for%20%22chat%22,(with%20the%20negative%20sign))
6. Use Send-TLGMessage script with the parameters that you've got above:
Install-Script -Name "Send-TLGMessage" -Force
# Script parameters
## Text
Enter text to send. This Value can be piped from another command, like:

```(gwmi win32_computersystemproduct).IdentifyingNumber | Send-TLGMessage -RecieverID ID -BotToken TOKEN ```

## RecieverID
Enter a Telgram chat, group or channel ID. Use [this guide](https://stackoverflow.com/questions/32423837/telegram-bot-how-to-get-a-group-chat-id#:~:text=Go%20to%20the%20group%2C%20click,dummy%20message%20to%20the%20bot.&text=4%2D%20Look%20for%20%22chat%22,(with%20the%20negative%20sign)) to find the ID

## BotToken
Get you bot token from [@BotFather](https://t.me/BotFather), follow their guide

## DisableNotification
If you add that parameter to a script, the message will be sent without sound notification (silently).

## UseProxy
If you add that parameter to a script, yuo can specify Telegram HTTP proxy settings, if Telegram servers are not directly accessable in your country

## ProxyAddress
Enter proxy address ie https://tlg.proxy.com or 22.344.556.123

## ProxyPort
Enter proxy port i.e. 1234

## ProxyUserName
Enter user name for proxy server authentication

## ProxyPassword
Enter password for proxy server authentication
