function Install-RequiredModule {
    Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
    Install-Module Microsoft.PowerShell.ConsoleGuiTools
    if (-not $IsWindows) {
        #Install-Module Microsoft.PowerShell.UnixCompleters
    }
    Install-Module -AllowClobber Get-ChildItemColor
}

Set-PSReadLineOption -HistoryNoDuplicates -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
# https://github.com/dotnet/runtime/issues/802
#Set-PSReadLineKeyHandler -Key Alt+LeftArrow -Function BackwardWord
#Set-PSReadLineKeyHandler -Key Alt+RightArrow -Function ForwardWord
Set-PSReadlineKeyHandler -Key Ctrl+d -Function ViExit

if (-not $IsWindows) {
    #Import-Module Microsoft.PowerShell.UnixCompleters

    Set-Alias -Name ls -Value Get-ChildItemColor -Option AllScope
    Set-Alias -Name rm -Value Remove-Item
    Set-Alias -Name cp -Value Copy-Item
    Set-Alias -Name mv -Value Move-Item
}

Invoke-Expression (&starship init powershell)
