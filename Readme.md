     Tools: 
          powershell version 7
          mysql connector

     String connection to DB:
          .\Config.txt
          Privacy only Config_sample.txt is available on this repository 
    
    Mysql Queries:
        .\Querys\*.txt 
        Queries does not require semicolon ; at the end

Previuos Execution Commands First Time only:

    Unblock-File .\Csv_from_MySql_Main.ps1
    Unblock-File .\Download_and_Connection.ps1
     
Execution Command:

    pwsh .\Csv_from_MySql_Main.ps1

Results: 

    .\Downloads\Production\customer\*.csv
    .\Downloads\Production\driver\*.csv
    .\Downloads\QualityControl\*.csv
    Privacy .csv files are not available on this repo

Commands execution: Powershell Command Line interface