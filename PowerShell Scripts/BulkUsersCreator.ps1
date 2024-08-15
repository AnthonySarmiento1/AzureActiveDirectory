$PASSWORD_FOR_USERS   = "Anthony123$"
$USER_FIRST_LAST_LIST = Get-Content .\names.txt

$password = ConvertTo-SecureString $PASSWORD_FOR_USERS -AsPlainText -Force

# Create Organizational Unit if it does not already exist
if (-not (Get-ADOrganizationalUnit -Filter { Name -eq "_USERS" } -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "_USERS" -ProtectedFromAccidentalDeletion $false
}

foreach ($n in $USER_FIRST_LAST_LIST) {
    $parts = $n.Split(" ", 2) # Split into 2 parts: first and last names
    if ($parts.Length -lt 2) {
        Write-Host "Skipping invalid entry: $n" -ForegroundColor Red
        continue
    }
    
    $first = $parts[0]
    $last = $parts[1]

    # Capitalize the first letter of each name and make the rest lowercase
    $first = $first.Substring(0,1).ToUpper() + $first.Substring(1).ToLower()
    $last = $last.Substring(0,1).ToUpper() + $last.Substring(1).ToLower()

    # Concatenate first and last name with a space and convert to lowercase for the username
    $username = "$($first)$($last)".ToLower()

    Write-Host "Creating user: $($username)" -BackgroundColor Black -ForegroundColor Cyan
    
    New-ADUser -AccountPassword $password `
               -GivenName $first `
               -Surname $last `
               -DisplayName "$($first) $($last)" ` # Include space here for display name
               -Name $username `
               -EmployeeID $username `
               -PasswordNeverExpires $true `
               -Path "ou=_USERS,$(([ADSI]"").distinguishedName)" `
               -Enabled $true
}

