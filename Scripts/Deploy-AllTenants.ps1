Import-Module SqlServer -ErrorAction Stop

Write-Host "========================================"
Write-Host " SaaS Database Deployment Started"
Write-Host "========================================"

# MASTER DATABASE CONNECTION
$MasterConnection = "Server=188.40.211.2;Database=db38045;User ID=db38045;Password=X%n3@4Wp7Pj+;Encrypt=True;TrustServerCertificate=True;"

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

if($null -eq $Dacpac)
{
    throw "DACPAC file not found."
}

Write-Host ""
Write-Host "DACPAC : $($Dacpac.FullName)"

$sqlPackage = (Get-Command sqlpackage).Source

Write-Host "SqlPackage : $sqlPackage"

foreach($Agency in $Agencies)
{
    Write-Host ""
    Write-Host "========================================"
    Write-Host "Deploying : $($Agency.AgencyName)"
    Write-Host "========================================"

    $arguments = @(
        "/Action:Publish"
        "/SourceFile:$($Dacpac.FullName)"
        "/TargetConnectionString:$($Agency.ConnectionString)"
        "/p:BlockOnPossibleDataLoss=False"
    )

    $process = Start-Process `
        -FilePath $sqlPackage `
        -ArgumentList $arguments `
        -Wait `
        -NoNewWindow `
        -PassThru

    if($process.ExitCode -eq 0)
    {
        Write-Host "SUCCESS"
    }
    else
    {
        Write-Host "FAILED"
        Write-Host "ExitCode : $($process.ExitCode)"
        exit $process.ExitCode
    }
}

Write-Host ""
Write-Host "========================================"
Write-Host " Deployment Completed"
Write-Host "========================================"
