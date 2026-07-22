Import-Module SqlServer -ErrorAction Stop

Write-Host "========================================"
Write-Host " SaaS Database Deployment Started"
Write-Host "========================================"

# ===========================
# MASTER DATABASE CONNECTION
# ===========================

$MasterConnection = "Server=188.40.211.2;Database=db38045;User ID=db38045;Password=X%n3@4Wp7Pj+;Encrypt=True;TrustServerCertificate=True;"

# ===========================
# TEST CONNECTION
# ===========================

Write-Host ""
Write-Host "Testing Master Database..."

try
{
    $cn = New-Object System.Data.SqlClient.SqlConnection($MasterConnection)
    $cn.Open()

    Write-Host "Connected Successfully"

    $cn.Close()
}
catch
{
    Write-Host ""
    Write-Host "Connection Failed"
    Write-Host $_.Exception.Message
    exit 1
}

# ===========================
# READ AGENCIES
# ===========================

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

# ===========================
# FIND DACPAC
# ===========================

$Dacpac = Get-ChildItem -Recurse -Filter *.dacpac | Select-Object -First 1

if($null -eq $Dacpac)
{
    Write-Host "DACPAC Not Found"
    exit 1
}

Write-Host ""
Write-Host "DACPAC : $($Dacpac.FullName)"

# ===========================
# DEPLOY
# ===========================

foreach($Agency in $Agencies)
{

    Write-Host ""
    Write-Host "-------------------------------------"
    Write-Host "Agency : $($Agency.AgencyName)"
    Write-Host "-------------------------------------"

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

        Write-Host $_.Exception.Message

    }

}

Write-Host ""
Write-Host "========================================"
Write-Host " Deployment Completed"
Write-Host "========================================"
