name: Deploy SaaS Databases

on:
  workflow_dispatch:

jobs:
  deploy:
    runs-on: windows-latest

    env:
      MASTER_CONNECTION_STRING: ${{ secrets.MASTER_CONNECTION_STRING }}

    steps:

      # -----------------------------------------
      # Checkout Repository
      # -----------------------------------------

      - name: Checkout Repository
        uses: actions/checkout@v4

      # -----------------------------------------
      # Setup .NET
      # -----------------------------------------

      - name: Setup .NET
        uses: actions/setup-dotnet@v4
        with:
          dotnet-version: '10.0.x'

      # -----------------------------------------
      # Install SqlServer PowerShell Module
      # -----------------------------------------

      - name: Install SqlServer Module
        shell: powershell
        run: |
          Install-Module SqlServer `
            -Force `
            -AllowClobber `
            -Scope CurrentUser

      # -----------------------------------------
      # Run Deployment
      # -----------------------------------------

      - name: Deploy Databases
        shell: powershell
        run: |
          .\Deploy-AllTenants.ps1
