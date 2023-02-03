#$cities = "Atlanta", "Charleston", "Houston"
#
#for ($i=0; $i -lt $cities.Count; $i++) {
#    $city = $cities[$i]
#    Write-Host "Processing city: $city"
#}

#$direccion = Split-Path $script:MyInvocation.MyCommand.Path
#Set-Location $direccion

#$queryFiles =   "Atlanta_QC",       "Charleston_QC",    "Houston_QC",
#"Jacksonville_QC",  "Norfolk_QC",       "Savannah_QC",
#"Linden_QC",        "Wilmington_QC",    "Mobile_QC"

# This method works as well:
#$queryFiles = Get-ChildItem -Path ".\Querys\QualityControl\" -Filter *.txt | Select-Object -ExpandProperty Name
#$queryFiles = $queryFiles -replace '.txt',''

$queryFiles = Get-ChildItem -Path ".\Querys\QualityControl" `
                            -Filter "*.txt" | `
                            ForEach-Object { $_.Name.Replace('.txt', '') }

for ($i=0; $i -lt $queryFiles.Count; $i++) {
    $csvFile = '.\Downloads\QualityControl\' + $queryFiles[$i]
    Write-Host $csvFile
}


#C:\automatic\csv_from_mysql_powershell\Querys\QualityControl