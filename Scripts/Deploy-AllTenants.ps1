Import-Module SqlServer -ErrorAction Stop

Write-Host "========================================"
Write-Host " SaaS Database Deployment Started"
Write-Host "========================================"

# ----------------------------------------------------
# MASTER DATABASE CONNECTION
# ----------------------------------------------------

$MasterConnection = "Server=188.40.211.2;Database=db38045;User ID=db38045;Password=X%n3@4Wp7Pj+;Encrypt=True;TrustServerCertificate=True;"

# ----------------------------------------------------
# TEST MASTER CONNECTION
# ----------------------------------------------------

Write-Host ""
Write-Host "Testing Master Database..."

try {
    $cn = New-Object System.Data.SqlClient.SqlConnection($MasterConnection)
    $cn.Open()
    Write-Host "Connected Successfully"
    $cn.Close()
}
catch {
    Write-Host "Connection Failed"
    Write-Host $_.Exception.Message
    exit 1
}

# ----------------------------------------------------
# READ ALL ACTIVE AGENCIES
# ----------------------------------------------------

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
ORDER BY AgencyId
"@

Write-Host "Total Agencies : $($Agencies.Count)"

# ----------------------------------------------------
# FIND DACPAC
# ----------------------------------------------------

$Dacpac = Get-ChildItem -Recurse -Filter *.dacpac | Select-Object -First 1

if ($null -eq $Dacpac)
{
    throw "DACPAC file not found."
}

Write-Host ""
Write-Host "DACPAC:"
Write-Host $Dacpac.FullName

# ----------------------------------------------------
# FIND SQLPACKAGE
# ----------------------------------------------------

$sqlPackage = (Get-Command sqlpackage -ErrorAction Stop).Source

Write-Host ""
Write-Host "SqlPackage:"
Write-Host $sqlPackage

# ----------------------------------------------------
# DEPLOY
# ----------------------------------------------------

foreach ($Agency in $Agencies)
{
    Write-Host ""
    Write-Host "========================================"
    Write-Host "Deploying : $($Agency.AgencyName)"
    Write-Host "========================================"

    $TargetConnection = $Agency.ConnectionString

    if ([string]::IsNullOrWhiteSpace($TargetConnection))
    {
        Write-Host "Connection string is empty."
        continue
    }

    Write-Host "Publishing..."

    & $sqlPackage `
        "/Action:Publish" `
        "/SourceFile:$($Dacpac.FullName)" `
        "/TargetConnectionString:$TargetConnection" `
        "/p:BlockOnPossibleDataLoss=False" `
        "/p:DropObjectsNotInSource=False"

    if ($LASTEXITCODE -eq 0)
    {
        Write-Host "SUCCESS"
    }
    else
    {
        Write-Host "FAILED"
        Write-Host "SqlPackage Exit Code : $LASTEXITCODE"
        exit $LASTEXITCODE
    }
}

Write-Host ""
Write-Host "========================================"
Write-Host " ALL DEPLOYMENTS COMPLETED"
Write-Host "========================================"
