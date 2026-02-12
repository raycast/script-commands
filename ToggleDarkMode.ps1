# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Darkmode Toggle
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🌑
# @raycast.iconDark 🌕
# @raycast.description Dark mode Toggle,


# Documentation:
# @raycast.author Ondrej Holan, Luke Humberdross 

# @raycast.authorURL https://raycast.com/Strynion


$k = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
$v = (Get-ItemProperty -Path $k).SystemUsesLightTheme -bxor 1

Set-ItemProperty -Path $k -Name "SystemUsesLightTheme" -Value $v
Set-ItemProperty -Path $k -Name "AppsUseLightTheme" -Value $v