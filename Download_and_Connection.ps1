# Function to Download from mysql to csv on .\Downloads path
function Export-MySqlToCsv {
    param (
        [string]$csvFile,
        [string]$direccion,
        [MySql.Data.MySqlClient.MySqlConnection]$Connection
    )

    $Query = Get-Content "$direccion\Querys\$csvFile.txt"

    $Command    = New-Object MySql.Data.MySqlClient.MySqlCommand($Query, $Connection)
    $DataAdapter= New-Object MySql.Data.MySqlClient.MySqlDataAdapter($Command)
    $DataSet    = New-Object System.Data.DataSet
    $RecordCount = $dataAdapter.Fill($dataSet, "data")
    Write-Host "Records for new file: $RecordCount"

    $DataSet.Tables[0] | Export-Csv -Path "$direccion\Downloads\$csvFile.csv" `
                                            -Encoding utf8NoBOM `
                                            -UseQuotes Never  `
                                            -Delimiter "`," `
                                            -NoTypeInformation `
                                            -Force
}

# Sample implementation:
#$csvFile = 'QualityControl\Atlanta_QC'
#Export-MySqlToCsv -csvFile $csvFile -direccion $direccion -Connection $Connection