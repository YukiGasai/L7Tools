
$r = Get-NetFirewallRule -DisplayName 'LOLCHAT' 2> $null; 
if ($r) { 
    Remove-NetFirewallRule -DisplayName "LOLCHAT"
    write-host "found it"; 
} 
else { 
    New-NetFirewallRule -DisplayName "LOLCHAT" -Direction Outbound -Protocol TCP -Action Block -RemoteAddress 172.65.252.238
    write-host "did not find it" 
}