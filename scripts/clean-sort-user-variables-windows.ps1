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

        # Remove whitespace and trailing backslashes
        $value = $entry.Trim().TrimEnd('\')

        if (-not $value) {
            continue
        }

        # Case-insensitive duplicate detection
        $key = $value.ToLower()

        if ($seen.ContainsKey($key)) {
            continue
        }

        $seen[$key] = $true

        if ($RemoveMissing) {
            # Expand environment-variable references ONLY for the
            # existence check. The original $value is preserved.
            $expandedValue = [Environment]::ExpandEnvironmentVariables($value)

            if (-not (Test-Path -LiteralPath $expandedValue)) {
                Write-Host "Removing missing: $value" -ForegroundColor Red
                continue
            }
        }

        # Keep the original value, including %SOMEVAR% references
        $clean += $value
    }

    return $clean | Sort-Object
}


# ============================================================
# Read User Environment Variable directly from the registry
# ============================================================
$regPath = "HKCU:\Environment"

$property = Get-ItemProperty `
    -Path $regPath `
    -Name $VariableName `
    -ErrorAction SilentlyContinue

if ($null -eq $property) {
    Write-Error "User environment variable '$VariableName' does not exist."
    exit 1
}

# Read the literal stored value.
# This preserves references such as %SOMEVAR%.
$original = $property.$VariableName

if ($null -eq $original) {
    Write-Error "Unable to read value of user environment variable '$VariableName'."
    exit 1
}


# ============================================================
# Split into entries
# ============================================================
$beforeEntries = $original -split ';'


# ============================================================
# Clean
# ============================================================
$afterEntries = Clean-VariableValue `
    -Entries $beforeEntries `
    -RemoveMissing:$RemoveMissing

$after = $afterEntries -join ';'


# ============================================================
# Display results
# ============================================================
Write-Host "`n================================"
Write-Host "Variable: $VariableName"
Write-Host "================================"


Write-Host "`n--- BEFORE ---"
Write-Host "Entries: $($beforeEntries.Count)"
Write-Host "Characters: $($original.Length)"

$beforeEntries | ForEach-Object {
    Write-Host $_
}


Write-Host "`n--- AFTER ---"
Write-Host "Entries: $($afterEntries.Count)"
Write-Host "Characters: $($after.Length)"

$afterEntries | ForEach-Object {
    Write-Host $_
}


Write-Host "`n--- SUMMARY ---"
Write-Host "Removed entries: $($beforeEntries.Count - $afterEntries.Count)"
Write-Host "Characters saved: $($original.Length - $after.Length)"


# ============================================================
# Check whether anything actually changed
# ============================================================
if ($original -eq $after) {
    Write-Host "`nNo changes are necessary." -ForegroundColor Green
    exit 0
}


# ============================================================
# Confirm before writing
# ============================================================
$answer = Read-Host "`nWrite changes to User variable '$VariableName'? (Y/N)"

if ($answer -eq "Y") {
    Set-ItemProperty `
        -Path $regPath `
        -Name $VariableName `
        -Value $after `
        -Type ExpandString

    Write-Host "`nUpdated $VariableName successfully." -ForegroundColor Green
}
else {
    Write-Host "`nNo changes made." -ForegroundColor Yellow
}