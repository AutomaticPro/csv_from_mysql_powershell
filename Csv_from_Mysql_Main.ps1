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
    $csvFile = 'QualityControl\Atlanta_QC'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'QualityControl\Charleston_QC'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'QualityControl\Houston_QC'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'QualityControl\Jacksonville_QC'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'QualityControl\Norfolk_QC'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'QualityControl\Savannah_QC'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'QualityControl\Linden_QC'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'QualityControl\Wilmington_QC'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'QualityControl\Mobile_QC'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection
# endregion

# region Production\customer.
    $csvFile = 'Production\customer\Atlanta_customer'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'Production\customer\Charleston_customer'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'Production\customer\Houston_customer'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'Production\customer\Jacksonville_customer'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'Production\customer\Savannah_customer'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'Production\customer\Norfolk_customer'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'Production\customer\Linden_customer'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'Production\customer\Wilmington_customer'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'Production\customer\Mobile_customer'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection
# endregion

# region Production\driver.
    $csvFile = 'Production\driver\Atlanta_driver'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'Production\driver\Charleston_driver'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'Production\driver\Houston_driver'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'Production\driver\Jacksonville_driver'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'Production\driver\Savannah_driver'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'Production\driver\Norfolk_driver'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'Production\driver\Linden_driver'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'Production\driver\Wilmington_driver'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

    $csvFile = 'Production\driver\Mobile_driver'
    Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection

# endregion

$Connection.Close()

# Informative Only
Write-Host -ForegroundColor Green 'Download Completed...!'

#The NoTypeInformation parameter removes the #TYPE information header from the CSV output
#and is not required in PowerShell 6.
# -Encoding Default   PONE EN FORMATO ANSI AL ARCHIVO CSV para powershell version  5
# -Encoding utf8NoBOM   PONE EN UN FORMATO UTF8 SIMILAR AL ANSI AL ARCHIVO CSV para powershell version  7
# -Delimiter ','   SE PUEDE SELECCIONAR EL DELIMITADOR , PERO EL DEFAULT YA ES "," POR ESO NO
# -Delimiter "`t"  SELECCIONA DELIMITADOR TAB