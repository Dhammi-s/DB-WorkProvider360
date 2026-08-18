param(
    [switch]$GenerateScript
)

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
# CREATE OUTPUT FOLDER
# ----------------------------------------------------

$OutputFolder = Join-Path $PSScriptRoot "Output"

if(!(Test-Path $OutputFolder))
{
    New-Item -ItemType Directory -Path $OutputFolder | Out-Null
}

# ----------------------------------------------------
# PROCESS TENANTS
# ----------------------------------------------------

foreach($Agency in $Agencies)
{
    Write-Host ""
    Write-Host "========================================"
    Write-Host "Processing : $($Agency.AgencyName)"
    Write-Host "========================================"

    $TargetConnection = @"
Server=$($Agency.DbServer);
Database=$($Agency.DbName);
User ID=$($Agency.DbUser);
Password=$($Agency.DbPassword);
Encrypt=False;
TrustServerCertificate=True;
"@.Replace("`r","").Replace("`n","")

    if($GenerateScript)
    {
        $ScriptFile = Join-Path $OutputFolder "$($Agency.DbName).sql"

        Write-Host "Generating Script : $ScriptFile"

        & $sqlPackage `
            "/Action:Script" `
            "/SourceFile:$($Dacpac.FullName)" `
            "/TargetConnectionString:$TargetConnection" `
            "/OutputPath:$ScriptFile" `
            "/p:BlockOnPossibleDataLoss=False" `
            "/p:DropObjectsNotInSource=False"
    }
    else
    {
        Write-Host "Deploying : $($Agency.DbName)"

        & $sqlPackage `
            "/Action:Publish" `
            "/SourceFile:$($Dacpac.FullName)" `
            "/TargetConnectionString:$TargetConnection" `
            "/p:BlockOnPossibleDataLoss=False" `
            "/p:DropObjectsNotInSource=False"
    }

    if($LASTEXITCODE -eq 0)
    {
        if($GenerateScript)
        {
            Write-Host "Script Generated Successfully"
        }
        else
        {
            Write-Host "Deployment Successful"
        }
    }
    else
    {
        Write-Host "FAILED"
        exit $LASTEXITCODE
    }
}

Write-Host ""
Write-Host "========================================"

if($GenerateScript)
{
    Write-Host " ALL SQL SCRIPTS GENERATED SUCCESSFULLY"
    Write-Host " Output Folder : $OutputFolder"
}
else
{
    Write-Host " ALL DATABASES DEPLOYED SUCCESSFULLY"
}

Write-Host "========================================"
