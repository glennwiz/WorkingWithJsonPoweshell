#1 read a Json-formatted string from a file
#2 convert the Json-formatted string to a Json-object
#3 modify the Json-object
#4 covert the Json-object to a Json-formatted string
#5 save the Json-formatted string back to the SAME file


#### 1. read a Json-formatted string from a file
$inputFile  = 'C:\dev\PSJsonTesting\newItems.json'  # JSON fila som skal lastes inn med nye items
$updateFile = 'C:\dev\PSJsonTesting\test.json'      # JSON fila som skal oppdateres

#### 2. convert the Json-formatted strings to Json-objects so you can start working with this ONLY in memory
$inputObj = Get-Content -Path $inputFile -encoding utf8 | ConvertFrom-Json # Laster inn inputfila i minne
$outputObj = Get-Content -Path $updateFile -encoding utf8 | ConvertFrom-Json  # Laster inn updatefila i minne to a 

#### 3. modify the Json-object
# loop through all items in the inputObj$inputObj.listeMedUsers array
# and add them to the outputObj$outputObj.listeMedUsers array if they do not exist in the outputObj$outputObj.listeMedUsers array
foreach ($user in $inputObj.listeMedUsers) 
{
    if (!($user.Name -in $outputObj.listeMedUsers.Name)) #if NOT in array add item
    {
        Write-Host "Adding $user.Name to $outputObj.listeMedUsers"
        $outputObj.listeMedUsers += $user
    }
}

#### 4. covert the Json-object to a Json-formatted string
$outputObj = ConvertTo-Json -InputObject $outputObj # convert the memory Json-object to a Json-formatted memory string

#### 5. save the result Json-Object string back to the SAME file overwriting it with new data set
$outputObj | Out-File -Path $updateFile -Encoding UTF8  # save the Json-formatted string to the file overwriting it with new data

