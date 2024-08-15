$PASSWORD_FOR_USERS   = "AnthonyPass"
$USER_FIRST_LAST_LIST = Get-Content .\names.txt

$password = ConvertTo-SecureString $PASSWORD_FOR_USERS -AsPlainText -Force
New-ADOrganizationalUnit -Name _USERS -ProtectedFromAccidentalDeletion $false

foreach ($n in $USER_FIRST_LAST_LIST) {
    $first = $n.Split(" ")[0]
    $last = $n.Split(" ")[1]

    # Capitalize the first letter of each name and make the rest lowercase
    $first = $first.Substring(0,1).ToUpper() + $first.Substring(1).ToLower()
    $last = $last.Substring(0,1).ToUpper() + $last.Substring(1).ToLower()

    # Concatenate first and last name and convert to lowercase
    $username = "$($first)$($last)".ToLower()

    Write-Host "Creating user: $($username)" -BackgroundColor Black -ForegroundColor Cyan
    
    New-AdUser -AccountPassword $password `
               -GivenName $first `
               -Surname $last `
               -DisplayName $username `
               -Name $username `
               -EmployeeID $username `
               -PasswordNeverExpires $true `
               -Path "ou=_USERS,$(([ADSI]`"").distinguishedName)" `
               -Enabled $true
}
