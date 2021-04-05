function Install-RequiredModule {
    Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
    Install-Module Microsoft.PowerShell.ConsoleGuiTools
    Install-Module Terminal-Icons
    if (-not $IsWindows) {
        #Install-Module Microsoft.PowerShell.UnixCompleters
    }
}

if (Get-Command 'less' -ErrorAction SilentlyContinue) {
    $env:PAGER = 'less -RnXmiS'
}

$PSReadLineOptions = @{
    EditMode                      = 'Emacs'
    PredictionSource              = 'History'
    HistoryNoDuplicates           = $true
    HistorySearchCursorMovesToEnd = $true
}
Set-PSReadLineOption @PSReadLineOptions
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
# https://github.com/dotnet/runtime/issues/802
#Set-PSReadLineKeyHandler -Key Alt+LeftArrow -Function BackwardWord
#Set-PSReadLineKeyHandler -Key Alt+RightArrow -Function ForwardWord
Set-PSReadlineKeyHandler -Key Ctrl+d -Function ViExit

Import-Module Terminal-Icons
if (-not $IsWindows) {
    #Import-Module Microsoft.PowerShell.UnixCompleters

    Set-Alias -Name ls -Value Get-ChildItem
    Set-Alias -Name cp -Value Copy-Item
    Set-Alias -Name mv -Value Move-Item
    Set-Alias -Name rm -Value Remove-Item
}

Invoke-Expression (&starship init powershell)
