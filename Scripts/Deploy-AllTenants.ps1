Import-Module SqlServer

# Read Master Connection
$MasterConnection = $env:MASTER_DB_CONNECTION

# Read All Active Agencies
$Agencies = Invoke-Sqlcmd `
    -ConnectionString $MasterConnection `
    -Query "
SELECT
    AgencyId,
    AgencyName,
    ConnectionString
FROM Agencies
WHERE IsActive = 1
AND IsArchived = 0
"

foreach($Agency in $Agencies)
{

    Write-Host ""
    Write-Host "================================"
    Write-Host "Deploying : $($Agency.AgencyName)"
    Write-Host "================================"

    try
    {

        SqlPackage.exe `
        /Action:Publish `
        /SourceFile:"DatabaseProject\bin\Release\Database.dacpac" `
        /TargetConnectionString:$Agency.ConnectionString

        Write-Host "Deployment Successful"

    }
    catch
    {

        Write-Host "Deployment Failed"

    }

}
