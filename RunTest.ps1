###### this is a example of moving and editing json files and objects

#1 read a Json-formatted string from a file
#2 convert the Json-formatted string to a Json-object in memory
#3 modify the Json-object
#4 covert the Json-object to a Json-formatted string
#5 save the Json-formatted string back to the SAME file


#### 1. read a Json-formatted string from a file
$inputFile  = 'C:\dev\PSJsonTesting\newItems.json'  # JSON file with old and new items
$updateFile = 'C:\dev\PSJsonTesting\test.json'      # JSON fila that will be updated with new items

#### 2. convert the Json-formatted strings to Json-objects so you can start working with this ONLY in memory
$inputObj = Get-Content -Path $inputFile -encoding utf8 | ConvertFrom-Json # Load the InPut JSON file into a powerhshell object
$outputObj = Get-Content -Path $updateFile -encoding utf8 | ConvertFrom-Json  # Load the OutPut JSON file into a powerhshell object

#### 3. modify the Json-object
# loop through all items in the inputObj$inputObj.Users array
# and add them to the outputObj$outputObj.Users array if they do not exist in the $outputObj.Users array
foreach ($user in $inputObj.Users) 
{
    $UserNameCurrentInLoop = $user.UserName #we set this only for the logging and logic purpose

    if (!($user.UserName -in $outputObj.Users.UserName)) #if NOT in array we are going to add the User to the $outputObj.Users array
    {     

        #we kow freia is a new user, and as a example we change the name of freia from testName4 to FreiaTheBeautiful 
        if ($UserNameCurrentInLoop -eq "freia") {
             $user.Name ="FreiaTheBeautiful"
        }

        Write-Host "Adding $UserNameCurrentInLoop to Json file $updateFile" #we log what we are doing
        $outputObj.Users += $user # add the user to the outputObj$outputObj.Users array
    }
    else {
        Write-Host "User $UserNameCurrentInLoop already exists" #we log the user that already exists
    }
}

#### 4. covert the Json-object to a Json-formatted string
$outputObj = ConvertTo-Json -InputObject $outputObj # convert the memory Json-object to a Json-formatted memory string

#### 5. save the result Json-Object string back to the SAME file overwriting it with new data set
$outputObj | Out-File -Path $updateFile -Encoding UTF8  # save the Json-formatted string to the file overwriting it with new data

