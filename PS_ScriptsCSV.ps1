Clear-Host

if ((Test-Path "C:\Scripts\ListeUsers.csv") -eq $False)
{
    
    Write-Warning "Impossible de trouver le fichier CSV nécessaire"
}

else
{
    #Récupération de la liste des Users 
    $ADUsers = Import-Csv -Path C:\Scripts\ListeUsers.csv -Delimiter ";"
    $ADUsers | ForEach-Object {

	    #Déclaration des variables
	    $user = $_.username
        $password = $_.password
        $name = $_.name
	    $lastname = $_.lastname
        $phone = $_.phone
	    $mail = $_.mail
	    $service = $_.service
        $poste = $_.poste

	    #Condition : Si le compte existe déjà : 
	    if (Get-ADUser -F {SamAccountName -eq $user})

	    {
		    #Affichage d'un message d'avertissement indiquant que le compte existe déjà
	        Write-Warning "Le user $user existe déja. Création de compte annulée." 
	    }

        else

	    {
            if ($poste -eq "" -and $service -eq "")

            {
                $UO = "OU=NewUsers, DC=beertobeer, DC=adds"
            }

            elseif ($poste -eq "")

            {
                $UO = "OU=Users, OU=$service, OU=beertobeer-Reims, DC=beertobeer, DC=adds"
            }

            else

            {
                $UO = "OU=Users, OU=$poste, OU=$service, OU=beertobeer-Reims, DC=beertobeer, DC=adds"
            }

		    #Sécurisation du MDP
		    $password2 = ConvertTo-SecureString $password -AsPlainText -Force
		
		    #Création de l'utilisateur
		    New-ADUser `
		    -SamAccountName "$user" `
		    -UserPrincipalName "$user@beertobeer.adds" `
		    -Surname "$lastname" `
            -Name "$name $lastname" `
		    -GivenName "$name" `
		    -DisplayName "$name $lastname" `
            -OfficePhone "$phone" `
            -EmailAddress "$mail" `
            -Office "$service" `
            -Path $UO `
		    -AccountPassword $password2 `
		    -ChangePasswordAtLogon $True `
		    -Enabled $True `

            Write-Warning "Création de l'utilisateur réussie"

            if ($service -eq "SAV")
            {
            Add-ADGroupMember -Identity "Groupe $service" -Members $user -PassThru
            }
            else
            {
            Add-ADGroupMember -Identity "Groupe $poste $service" -Members $user -PassThru
            }   

            if ($service -eq "Produit A" -or $service -eq "Produit B" -or $service -eq "SAV")
            {
            
                $user = "$user RDS"
                $UORDS = "OU=Users, OU=$service, OU=beertobeer - Reims RDS, DC=beertobeer, DC=adds"

                New-ADUser `
		        -SamAccountName "$user" `
		        -UserPrincipalName "$user@beertobeer.adds" `
		        -Surname "$lastname" `
                -Name "$name $lastname" `
		        -GivenName "$name" `
		        -DisplayName "$name $lastname" `
                -OfficePhone "$phone" `
                -EmailAddress "$mail" `
                -Office "$service" `
                -Path $UORDS `
		        -AccountPassword $password2 `
		        -ChangePasswordAtLogon $True `
		        -Enabled $True `

                Add-ADGroupMember -Identity "$service RDS" -Members $user -PassThru
                Write-Warning "Création de l'utilisateur RDS réussie"    
	    }
    }

}
}
