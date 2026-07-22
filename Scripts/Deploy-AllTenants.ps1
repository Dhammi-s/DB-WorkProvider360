Import-Module SqlServer -ErrorAction Stop

Write-Host "======================================="
Write-Host " SaaS Database Deployment Started"
Write-Host "======================================="

# Read Secret
$MasterConnection = $env:MASTER_DB_CONNECTION

if ([string]::IsNullOrWhiteSpace($MasterConnection))
{
    throw "MASTER_DB_CONNECTION secret is empty."
}

Write-Host "Master Connection Secret Loaded"
Write-Host "Connection String Length: $($MasterConnection.Length)"

# Test SQL Connection
Write-Host ""
Write-Host "Testing Master Database Connection..."

try
{
    $cn = New-Object System.Data.SqlClient.SqlConnection($MasterConnection)
    $cn.Open()

    Write-Host "Master Database Connected Successfully"

    $cn.Close()
}
catch
{
    Write-Host ""
    Write-Host "======================================="
    Write-Host "FAILED TO CONNECT MASTER DATABASE"
    Write-Host "======================================="
    Write-Host $_.Exception.Message
    throw
}

Write-Host ""
Write-Host "Reading Agencies..."

$Agencies = Invoke-Sqlcmd `
-ConnectionString $MasterConnection `
-Query @"
SELECT
AgencyId,
AgencyName,
ConnectionString
FROM Agencies
WHERE IsActive = 1
AND IsArchived = 0
"@

Write-Host "Total Agencies : $($Agencies.Count)"

$Dacpac = Get-ChildItem -Recurse -Filter *.dacpac | Select-Object -First 1

if ($null -eq $Dacpac)
{
    throw "DACPAC file not found."
}

Write-Host ""
Write-Host "DACPAC Found:"
Write-Host $Dacpac.FullName

foreach($Agency in $Agencies)
{
    Write-Host ""
    Write-Host "======================================="
    Write-Host "Agency : $($Agency.AgencyName)"
    Write-Host "======================================="

    try
    {
        SqlPackage.exe `
            /Action:Publish `
            /SourceFile:$Dacpac.FullName `
            /TargetConnectionString:$Agency.ConnectionString

        Write-Host "Deployment Successful"
    }
    catch
    {
        Write-Host "Deployment Failed"
        Write-Host $_.Exception.Message
    }
}

Write-Host ""
Write-Host "======================================="
Write-Host "Deployment Completed"
Write-Host "======================================="
