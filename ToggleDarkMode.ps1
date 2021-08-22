$k = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
$v = (Get-ItemProperty -Path $k).SystemUsesLightTheme -bxor 1

Set-ItemProperty -Path $k -Name "SystemUsesLightTheme" -Value $v
Set-ItemProperty -Path $k -Name "AppsUseLightTheme" -Value $v