Import-Module SqlServer -ErrorAction Stop

$MasterConnection = $env:MASTER_DB_CONNECTION

Write-Host "Reading Agencies..."

$Agencies = Invoke-Sqlcmd `
-ConnectionString $MasterConnection `
-Query @"
SELECT
AgencyId,
AgencyName,
ConnectionString
FROM Agencies
WHERE IsActive=1
AND IsArchived=0
"@

$Dacpac = Get-ChildItem -Recurse -Filter *.dacpac | Select-Object -First 1

if($null -eq $Dacpac)
{
    throw "DACPAC file not found."
}

Write-Host "DACPAC : $($Dacpac.FullName)"

foreach($Agency in $Agencies)
{

    Write-Host ""
    Write-Host "========================================="
    Write-Host "Deploying $($Agency.AgencyName)"
    Write-Host "========================================="

    try
    {

        SqlPackage.exe `
        /Action:Publish `
        /SourceFile:$Dacpac.FullName `
        /TargetConnectionString:$Agency.ConnectionString

        Write-Host "SUCCESS"

    }

    catch
    {

        Write-Host "FAILED"

        Write-Host $_

    }

}
