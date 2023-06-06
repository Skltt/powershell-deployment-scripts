class Shortcut {
    [string]$name
    [string]$url

    Shortcut([string]$name, [string]$url) {
        $this.name = $name
        $this.url = $url
    }

    [void]CreateShortcut() {
        $wshShell = New-Object -ComObject "WScript.Shell"
        $urlShortcut = $wshShell.CreateShortcut(
            (Join-Path $wshShell.SpecialFolders.Item("AllUsersDesktop") "$($this.name).url")
        )
        $urlShortcut.TargetPath = $this.url
        $urlShortcut.Save()
    }
}

$shortcuts = @(

    [Shortcut]::new("AT Browser", "http://10.2.1.2/login_cgi2.htm"),
    [Shortcut]::new("Mitel Queue", "http://10.20.4.12:3000/ecc"),
    [Shortcut]::new("Dashboards", "https://dashboards.autotrakk.com/itc-login/index.html")
)

foreach ($shortcut in $shortcuts) {
    $shortcut.CreateShortcut()
}