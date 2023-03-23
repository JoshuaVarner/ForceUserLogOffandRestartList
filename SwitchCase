# Define the file path and name of the input file
$inputFilePath = "$($PWD)\hosts.txt"

# Define the file path and name of the output file
$outputFilePath = "$($PWD)\output.csv"

# Define the VLANs for each floor
$basementVlans = @(164, 165)
$firstFloorVlans = @(166, 167, 168, 169)
$secondFloorVlans = @(170, 171, 173, 174)
$thirdFloorVlans = @(175, 177, 178, 179)
$fourthFloorVlans = @(180, 181)
$fifthFloorVlans = @(182, 183)

# Define the function to get the floor based on the VLAN
function Get-FloorFromVlan($vlan) {
    switch ($vlan) {
        { $basementVlans -contains $_ } { return "Basement" }
        { $firstFloorVlans -contains $_ } { return "First Floor" }
        { $secondFloorVlans -contains $_ } { return "Second Floor" }
        { $thirdFloorVlans -contains $_ } { return "Third Floor" }
        { $fourthFloorVlans -contains $_ } { return "Fourth Floor" }
        { $fifthFloorVlans -contains $_ } { return "Fifth Floor" }
        default { return "Unknown" }
    }
}

# Get the list of hosts from the input file
$hosts = Get-Content $inputFilePath

# Create an empty array to store the output data
$output
