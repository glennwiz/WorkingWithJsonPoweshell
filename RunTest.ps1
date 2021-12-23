#1 read a Json-formatted string from a file
#2 convert the Json-formatted string to a Json-object
#3 modify the Json-object
#4 covert the Json-object to a Json-formatted string
#5 save the Json-formatted string back to the SAME file


#### 1. read a Json-formatted string from a file
$inputFile  = 'C:\dev\PSJsonTesting\newItems.json'  # JSON fila som skal lastes inn med nye items
$updateFile = 'C:\dev\PSJsonTesting\test.json'      # JSON fila som skal oppdateres

#### 2. convert the Json-formatted strings to Json-objects so you can start working with this ONLY in memory
$inputJson = Get-Content -Path $inputFile -encoding utf8 | ConvertFrom-Json # Laster inn inputfila i minne
$updateJson = Get-Content -Path $updateFile -encoding utf8 | ConvertFrom-Json  # Laster inn updatefila i minne

#### 3. modify the Json-object
# loop through all items in the inputJson.listeMedUsers file 
# and add them to the updateJson.listeMedUsers file if they do not exist in the updateJson.listeMedUsers file
foreach ($user in $inputJson.listeMedUsers) 
{
    if (!($user.Name -in $updateJson.listeMedUsers.Name)) #if NOT in array add item
    {
        Write-Host "Adding $user.Name to $updateJson.listeMedUsers"
        $updateJson.listeMedUsers += $user
    }
}

#### 4. covert the Json-object to a Json-formatted string
$updateJson = ConvertTo-Json -InputObject $updateJson # convert the memory Json-object to a Json-formatted memory string

#### 5. save the result Json-Object string back to the SAME file overwriting it with new data set
$updateJson | Out-File -Path $updateFile -Encoding UTF8  # save the Json-formatted string to the file overwriting it with new data

