Import-Module SqlServer -ErrorAction Stop

Write-Host "========================================"
Write-Host " SaaS Database Deployment Started"
Write-Host "========================================"

# ----------------------------------------------------
# MASTER DATABASE
# ----------------------------------------------------

$MasterConnection = "Server=188.40.211.2;Database=db38045;User ID=db38045;Password=X%n3@4Wp7Pj+;Encrypt=True;TrustServerCertificate=True;"

# ----------------------------------------------------
# TEST MASTER CONNECTION
# ----------------------------------------------------

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
    Write-Host "Connection Failed"
    Write-Host $_.Exception.Message
    exit 1
}

# ----------------------------------------------------
# GET AGENCIES
# ----------------------------------------------------

Write-Host ""
Write-Host "Reading Agencies..."

$Agencies = Invoke-Sqlcmd `
    -ConnectionString $MasterConnection `
    -Query @"

SELECT
    AgencyId,
    AgencyName,
    DbServer,
    DbName,
    DbUser,
    DbPassword
FROM Agencies
WHERE IsActive = 1
AND IsArchived = 0
ORDER BY AgencyId

"@

Write-Host "Total Agencies : $($Agencies.Count)"

# ----------------------------------------------------
# FIND DACPAC
# ----------------------------------------------------

$Dacpac = Get-ChildItem -Recurse -Filter *.dacpac | Select-Object -First 1

if($null -eq $Dacpac)
{
    throw "DACPAC Not Found."
}

Write-Host ""
Write-Host "DACPAC : $($Dacpac.FullName)"

# ----------------------------------------------------
# FIND SQLPACKAGE
# ----------------------------------------------------

$sqlPackage = (Get-Command sqlpackage -ErrorAction Stop).Source

Write-Host "SqlPackage : $sqlPackage"

# ----------------------------------------------------
# DEPLOY
# ----------------------------------------------------

foreach($Agency in $Agencies)
{

    Write-Host ""
    Write-Host "========================================"
    Write-Host "Deploying : $($Agency.AgencyName)"
    Write-Host "========================================"

    $TargetConnection = @"
Server=$($Agency.DbServer);
Database=$($Agency.DbName);
User ID=$($Agency.DbUser);
Password=$($Agency.DbPassword);
Encrypt=False;
TrustServerCertificate=True;
"@.Replace("`r","").Replace("`n","")

    Write-Host "Database : $($Agency.DbName)"

    & $sqlPackage `
        "/Action:Publish" `
        "/SourceFile:$($Dacpac.FullName)" `
        "/TargetConnectionString:$TargetConnection" `
        "/p:BlockOnPossibleDataLoss=False" `
        "/p:DropObjectsNotInSource=False"

    if($LASTEXITCODE -eq 0)
    {
        Write-Host "SUCCESS"
    }
    else
    {
        Write-Host "FAILED"
        exit $LASTEXITCODE
    }

}

Write-Host ""
Write-Host "========================================"
Write-Host " ALL DATABASES DEPLOYED SUCCESSFULLY"
Write-Host "========================================"
