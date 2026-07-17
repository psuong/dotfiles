param(
    [Parameter(Mandatory = $true)]
    [string]$VariableName,
    [switch]$RemoveMissing
)

function Clean-VariableValue {
    param(
        [string[]]$Entries,
        [switch]$RemoveMissing
    )

    $seen = @{}
    $clean = @()

    foreach ($entry in $Entries) {
        $value = $entry.Trim().TrimEnd('\')

        if (-not $value) {
            continue
        }

        $key = $value.ToLower()

        if ($seen.ContainsKey($key)) {
            continue
        }

        $seen[$key] = $true

        if ($RemoveMissing) {
            if (-not (Test-Path -LiteralPath $value)) {
                Write-Host "Removing missing: $value" -ForegroundColor Red
                continue
            }
        }

        $clean += $value
    }

    return $clean | Sort-Object
}


# Read User variable
$original = [Environment]::GetEnvironmentVariable(
    $VariableName,
    "User"
)

if ($null -eq $original) {
    Write-Error "User environment variable '$VariableName' does not exist."
    exit 1
}

$beforeEntries = $original -split ';'

# Clean
$afterEntries = Clean-VariableValue `
    -Entries $beforeEntries `
    -RemoveMissing:$RemoveMissing

$after = $afterEntries -join ';'


# Display results
Write-Host "`n================================"
Write-Host "Variable: $VariableName"
Write-Host "================================"

Write-Host "`n--- BEFORE ---"
Write-Host "Entries: $($beforeEntries.Count)"
Write-Host "Characters: $($original.Length)"
$beforeEntries | ForEach-Object { Write-Host $_ }


Write-Host "`n--- AFTER ---"
Write-Host "Entries: $($afterEntries.Count)"
Write-Host "Characters: $($after.Length)"
$afterEntries | ForEach-Object { Write-Host $_ }


Write-Host "`n--- SUMMARY ---"
Write-Host "Removed entries: $($beforeEntries.Count - $afterEntries.Count)"
Write-Host "Characters saved: $($original.Length - $after.Length)"


# Confirm before writing
$answer = Read-Host "`nWrite changes to User variable '$VariableName'? (Y/N)"

if ($answer -eq "Y") {
    [Environment]::SetEnvironmentVariable(
        $VariableName,
        $after,
        "User"
    )

    Write-Host "Updated $VariableName successfully."
}
else {
    Write-Host "No changes made."
}