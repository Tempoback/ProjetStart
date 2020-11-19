#Vérification de la présence du fichier
if ((Test-Path "C:\Scripts\ListeUsers.csv") -eq $False)
{
    Write-Warning "Impossible de trouver le fichier CSV nécessaire"
}

else
{
    #Récupération de la liste des Users 
    $ADUsers = Import-Csv -Path C:\Scripts\ListeUsers.csv -Delimiter ";"
    #[System.String]$password = $_.Password
    #$user = $firstname.substring(0,1).ToLower() + $lastname.ToLower()

    $ADUsers | ForEach-Object {

        #Déclaration des variables CSV
        $firstnameCSV = $_.name
        $lastnameCSV = $_.lastname
        $userCSV = $_.username

        #Déclaration des variables AD
        $user = Get-ADUser -F {SamAccountName -eq $userCSV} -Properties *
        $DisplayName = $user.DisplayName
        $GivenName = $user.GivenName
        $Surname = $user.Surname

        #Vérification du DisplayName
        if ($DisplayName -eq "$firstnameCSV $lastnameCSV")
        {
            Write-Warning "Compte $userCSV : DisplayName OK"
        }
        else
        {
            Set-ADUser -Identity $userCSV `
            -DisplayName "$firstnameCSV $lastnameCSV" `

            Write-Warning "Compte $userCSV : DisplayName  modifié"
        }

        #Vérification du Prénom
        if ($GivenName -eq "$firstnameCSV")
        {
            Write-Warning "Compte $userCSV : GivenName OK"
        }
        else
        {
      
            Set-ADUser -Identity $userCSV `
            -GivenName "$firstnameCSV" `

            Write-Warning "Compte $userCSV : GivenName modifié"
        }
        
        #Vérification du Nom
        if ($Surname -eq "$lastnameCSV")
        {
            Write-Warning "Compte $userCSV : Surname OK"
        }
        else
        {
      
            Set-ADUser -Identity $userCSV `
            -GivenName "$lastnameCSV" `

            Write-Warning "Compte $userCSV : Surname modifié"
        }
    }
}
