# Define function to get floor based on VLAN
function GetFloorFromVlan($vlan) {
    if ($vlan -ge 164 -and $vlan -le 165) { return "Basement" }
    if ($vlan -ge 166 -and $vlan -le 169) { return "First" }
    if ($vlan -ge 170 -and $vlan -le 173) { return "Second" }
    if ($vlan -ge 175 -and $vlan -le 178) { return "Third" }
    if ($vlan -ge 180 -and $vlan -le 181) { return "Fourth" }
    if ($vlan -ge 182 -and $vlan -le 183) { return "Fifth" }
    return ""
}

# Read host names from file
$hostnames = Get-Content "./ComputerNames.txt"

# Create output file
$outputPath = "output.csv"
"Hostname,IP Address,Floor" | Out-File -FilePath $outputPath -Encoding utf8 -Force

# Loop through each host name
for ($i = 0; $i -lt $hostnames.Count; $i++) {
    $hostname = $hostnames[$i]

    # Ping host to get IP address
    Write-Progress -Activity "Pinging $hostname" -PercentComplete (($i+1)/$hostnames.Count*100)
    $ip = Test-Connection -ComputerName $hostname -Count 1 -ErrorAction SilentlyContinue | Select-Object -ExpandProperty IPV4Address

    if ($ip -ne $null) {
        # Get VLAN and floor
        $vlan = ($ip.GetAddressBytes()[2] -shl 8) + $ip.GetAddressBytes()[3]
        $floor = GetFloorFromVlan $vlan

        # Output to CSV file
        "$hostname,$ip,$floor" | Out-File -FilePath $outputPath -Encoding utf8 -Append
    }
}

Write-Progress -Activity "Done." -Completed
