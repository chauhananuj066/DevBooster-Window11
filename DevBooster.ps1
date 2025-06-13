Add-Type -AssemblyName PresentationFramework

$Form = New-Object System.Windows.Window
$Form.Title = "Windows 11 Dev Booster Tool"
$Form.Width = 400
$Form.Height = 500
$Form.WindowStartupLocation = "CenterScreen"

$stackPanel = New-Object System.Windows.Controls.StackPanel
$Form.Content = $stackPanel

$checkboxes = @{}
foreach ($option in @(
    "Clean Temp and Cache Files",
    "Disable SysMain, DiagTrack, WSearch",
    "Disable Background Apps",
    "Enable High Performance Power Plan",
    "Optimize Visual Effects",
    "Create System Restore Point"
)) {
    $cb = New-Object System.Windows.Controls.CheckBox
    $cb.Content = $option
    $cb.Margin = "10"
    $stackPanel.Children.Add($cb)
    $checkboxes[$option] = $cb
}

$btn = New-Object System.Windows.Controls.Button
$btn.Content = "Apply Selected Optimizations"
$btn.Margin = "20"
$btn.Padding = "10"
$btn.HorizontalAlignment = "Center"
$stackPanel.Children.Add($btn)

$btn.Add_Click({
    if ($checkboxes["Create System Restore Point"].IsChecked) {
        Checkpoint-Computer -Description "DevBoosterRestore" -RestorePointType "MODIFY_SETTINGS"
    }

    if ($checkboxes["Clean Temp and Cache Files"].IsChecked) {
        Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "C:\Windows\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue
    }

    if ($checkboxes["Disable SysMain, DiagTrack, WSearch"].IsChecked) {
        Get-Service SysMain, DiagTrack, WSearch | Stop-Service -Force -ErrorAction SilentlyContinue
        Set-Service SysMain -StartupType Disabled
        Set-Service DiagTrack -StartupType Disabled
        Set-Service WSearch -StartupType Disabled
    }

    if ($checkboxes["Disable Background Apps"].IsChecked) {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name GlobalUserDisabled -Value 1
    }

    if ($checkboxes["Enable High Performance Power Plan"].IsChecked) {
        powercfg -setactive SCHEME_MIN
    }

    if ($checkboxes["Optimize Visual Effects"].IsChecked) {
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name MenuShowDelay -Value "10"
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name VisualFXSetting -Value 2
    }

    [System.Windows.MessageBox]::Show("Optimizations Applied! Please restart your PC.", "Done", "OK", "Info")
})

$Form.ShowDialog()
