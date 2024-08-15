# Define the number of unique names to generate
$numberOfNames = 1000

# Define the output file
$outputFile = ".\names.txt"

# Function to generate a random name
function Generate-RandomName {
    $consonants = @('b','c','d','f','g','h','j','k','l','m','n','p','q','r','s','t','v','w','x','z')
    $vowels = @('a','e','i','o','u')

    if ($consonants.Count -eq 0 -or $vowels.Count -eq 0) {
        throw "Consonants or vowels array is empty."
    }

    $nameLength = Get-Random -Minimum 3 -Maximum 9
    $name = ""

    for ($i = 0; $i -lt $nameLength; $i++) {
        if ($i % 2 -eq 0) {
            $index = Get-Random -Minimum 0 -Maximum ($consonants.Count - 1)
            $name += $consonants[$index]
        } else {
            $index = Get-Random -Minimum 0 -Maximum ($vowels.Count - 1)
            $name += $vowels[$index]
        }
    }

    return $name.Substring(0,1).ToUpper() + $name.Substring(1).ToLower()
}

# Initialize a hashset to store unique names
$uniqueNames = [System.Collections.Generic.HashSet[string]]::new()

# Generate unique names
while ($uniqueNames.Count -lt $numberOfNames) {
    $firstName = Generate-RandomName
    $lastName = Generate-RandomName
    $fullName = "$firstName $lastName"

    $uniqueNames.Add($fullName) | Out-Null
}

# Write unique names to the output file
$uniqueNames | Out-File -FilePath $outputFile -Encoding UTF8

Write-Host "Generated $($uniqueNames.Count) unique names and saved to $outputFile" -ForegroundColor Green
