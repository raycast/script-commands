# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle System Appearance
# @raycast.mode silent
# @raycast.packageName Toggle System Appearance

# Optional parameters:
# @raycast.platform Windows
# @raycast.icon 🌑
# @raycast.iconDark 🌕
# @raycast.description Toggle the system appearance, between light and dark mode. Works only for Windows platform.

# Documentation:
# @raycast.author Ondrej Holan
# @raycast.authorURL https://github.com/ondrejholan

# @raycast.author Luke Humberdross 
# @raycast.authorURL https://github.com/lukejjh

$k = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
$v = (Get-ItemProperty -Path $k).SystemUsesLightTheme -bxor 1

Set-ItemProperty -Path $k -Name "SystemUsesLightTheme" -Value $v
Set-ItemProperty -Path $k -Name "AppsUseLightTheme" -Value $v
