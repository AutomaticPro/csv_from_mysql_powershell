# Import File_with_Function.ps1
. .\Download_and_Connection.ps1

Write-Host 'XLSX from CSV from Mysql MODULE Activated...!'
Write-Host -ForegroundColor Yellow 'Previous files csv files will be removed...!'

$direccion = Split-Path $script:MyInvocation.MyCommand.Path
Set-Location $direccion

# region Create conection to Mysql. Getting Connection Credentials
$config_txt = Get-Content $direccion\config.txt
$Servidor   = "server="     + $config_txt[0].Replace('set DB_HOST=','')     + ";"
$Usuario    = "uid="        + $config_txt[1].Replace('set DB_USER=','')     + ";"
$PasswordDB = "pwd="        + $config_txt[2].Replace('set DB_PASSWORD=','') + ";"
$BaseDeDatos= "database="   + $config_txt[3].Replace('set DB_DATABASE=','') + ";"
$Puerto     = "port="       + "3306"                                        + ";"
$PoolingVar = "pooling="    + "false"                                       + ";"
$Conversor  = "convert zero datetime=" + "True"

[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
$Connection = New-Object MySql.Data.MySqlClient.MySqlConnection
$ConnectionString =      $Servidor      + $Puerto + `
                         $Usuario       + $PasswordDB + `
                         $BaseDeDatos   + `
                         $PoolingVar    + $Conversor

# $ConnectionString = "server=" + "localhost" + ";port=3306;uid=" + "root" + ";pwd=dispatch20" + ";database="+"tmxportal"
$Connection.ConnectionString = $ConnectionString
# endregion

$Connection.Open()

#region QualityControl. This is for deliver to QA
    $queryFiles = Get-ChildItem -Path ".\Querys\QualityControl" -Filter "*.txt" | `
                                ForEach-Object { $_.Name.Replace('.txt', '') }

        for ($i=0; $i -lt $queryFiles.Count; $i++) {
            $csvFile = "QualityControl\" + $queryFiles[$i]
            Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection
        }
#region QualityControl. This is for deliver to QA


.\Downloads\QualityControl\

#region Production\customer.
    $queryFiles = Get-ChildItem -Path ".\Querys\Production\customer" -Filter "*.txt" | `
                                ForEach-Object { $_.Name.Replace('.txt', '') }

    for ($i=0; $i -lt $queryFiles.Count; $i++) {
        $csvFile = "Production\customer\" + $queryFiles[$i]
        Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection
    }
#region QualityControl. This is for deliver to QA


#region Production\driver.
    $queryFiles = Get-ChildItem -Path ".\Querys\Production\driver" -Filter "*.txt" | `
                                ForEach-Object { $_.Name.Replace('.txt', '') }

    for ($i=0; $i -lt $queryFiles.Count; $i++) {
        $csvFile = "Production\driver\" + $queryFiles[$i]
        Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection
    }
#region QualityControl. This is for deliver to QA

$Connection.Close()

# Informative Only
Write-Host -ForegroundColor Green 'Download Completed...!'

#The NoTypeInformation parameter removes the #TYPE information header from the CSV output
#and is not required in PowerShell 6.
# -Encoding Default   PONE EN FORMATO ANSI AL ARCHIVO CSV para powershell version  5
# -Encoding utf8NoBOM   PONE EN UN FORMATO UTF8 SIMILAR AL ANSI AL ARCHIVO CSV para powershell version  7
# -Delimiter ','   SE PUEDE SELECCIONAR EL DELIMITADOR , PERO EL DEFAULT YA ES "," POR ESO NO
# -Delimiter "`t"  SELECCIONA DELIMITADOR TAB