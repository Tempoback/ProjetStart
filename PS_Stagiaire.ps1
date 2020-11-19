Clear-Host

[STRING]$firstname = Read-Host "Quel est votre prénom ?"    
[STRING]$lastname = Read-Host "Quel est votre nom ?"
$user = $firstname.substring(0,1).ToLower() + $lastname.ToLower()
$password = "BEERtobeer123"
$password2 = ConvertTo-SecureString $password -AsPlainText -Force

if (Get-ADUser -F {SamAccountName -eq $user})

    {
	    #Affichage d'un message d'avertissement indiquant que le compte existe déjà
	    Write-Warning "Le user $user existe déja. Création de compte annulée." 

    }

else 

{

    New-ADUser `
        -SamAccountName "$user" `
		-UserPrincipalName "$user@beertobeer.adds" `
		-Surname "$lastname" `
        -Name "$firstname $lastname" `
		-GivenName "$firstname" `
		-DisplayName "$firstname $lastname" `
        -Office "Informatique" `
        -Path "OU=Users, OU=Stagiaire, OU=SI, OU=BeerToBeer-Reims, DC=beertobeer, DC=adds" `
		-AccountPassword $password2 `
		-ChangePasswordAtLogon $True `a
		-Enabled $True `

    clear-Host
    Write-Warning "Création de compte réussie !"
    Write-Host ""
    Write-Host "Votre login est $user@beertobeer.adds"
    Write-Host "Votre mot de passe est $password. Vous devrez le changer à votre première connexion."
    Write-Host ""
    Write-Host ""
}
