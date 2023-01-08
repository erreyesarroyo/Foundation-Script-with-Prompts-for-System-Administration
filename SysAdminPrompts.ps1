

#begin error catching#
 try {

 #Used variable for switch statement#
$opt = Read-Host -Prompt 'Enter Number 1-5::: 1=Log Collection, 2=List of Files Out to C916Contents, 3=Current CPU and Memory Usage, 4=List of processes, 5=Exit'

switch($opt) {
"1" {
#Variable with log path#
#Oviusly the path need to fit your needs#
$Dirandfolder = "c:\Users\edwar\Desktop\WGU\PowerShell\Scripts\AUN1 — AUN1 TASK 1 SCRIPTING IN A POWER SHELL\Requirements1"
#Output/append date into file# 
Get-Date >> "C:\Users\edwar\Desktop\WGU\PowerShell\Scripts\AUN1 — AUN1 TASK 1 SCRIPTING IN A POWER SHELL\Requirements1\DailyLog.txt"
#Output/append logs into file# 
Get-ChildItem -Path $Dirandfolder -Filter "*.log" >> "C:\Users\edwar\Desktop\WGU\PowerShell\Scripts\AUN1 — AUN1 TASK 1 SCRIPTING IN A POWER SHELL\Requirements1\DailyLog.txt"
#final output at path C:\Users\edwar\Desktop\WGU\PowerShell\Scripts\AUN1 — AUN1 TASK 1 SCRIPTING IN A POWER SHELL\Requirements1\DailyLog.txt
}
"2"{
#Listing files#
Get-ChildItem -Path `
"c:\Users\edwar\Desktop\WGU\PowerShell\Scripts\AUN1 — AUN1 TASK 1 SCRIPTING IN A POWER SHELL\Requirements1" 
#directs the files to the folder on the new file. 
  | Format-Table -Property Name > `
  "C:\Users\edwar\Desktop\WGU\PowerShell\Scripts\AUN1 — AUN1 TASK 1 SCRIPTING IN A POWER SHELL\Requirements1\C916contents.txt"
}
"3"{ 
    #Get Computer Object in relation to memory and cpu#
    $CompObject =  Get-WmiObject -Class WIN32_OperatingSystem
    $Memory = ((($CompObject.TotalVisibleMemorySize - $CompObject.FreePhysicalMemory)*100)/ $CompObject.TotalVisibleMemorySize)
    #output Memory results in user friendly form and rounded to the hundredths for readability and used ` for readability
    Write-Host "Memory usage in Percentage:" ([Math]::Round($Memory, 2))
    #Output CPU current CPU results in percentage  
    Write-Host "CPU usage in Percentage:" (Get-WmiObject -ComputerName PAPIS -Class win32_processor -ErrorAction Stop `
       | Measure-Object -Property LoadPercentage -Average | Select-Object Average).Average
}
"4"{
    #List all the different running processes inside system#
Get-Process | Select-Object Name, ID, TotalProcessorTime `
#Sort the output by virtual size used least to greatest, and display it in grid format. 
    | Sort-Object TotalProcessorTime -Descending `
        | Format-Table
}
#exit script#
"5"{
    Exit
}
#if anything else other than 1-5 output the text below. 
default{
    "Option not availble"
}
}

}
#catch portion of the error portion of the script, more errors can be added#
catch [System.OutOfMemoryException] {
Write-Output "Out of Memory_Exception, please address and try again."    
}
