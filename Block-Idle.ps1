param($minutes = 720)

$myshell = New-Object -com "Wscript.Shell"

for ($i = 0; $i -lt $minutes; $i++) {
  Start-Sleep -Seconds 180
  $myshell.sendkeys("+")
}