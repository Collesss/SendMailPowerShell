#Setting
$User = ''
$Password = ''
$Server = ""
$SearchBaseOU = ""
$DistinguishedNameGroup = ""
#Setting


#Get Credential
$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential $User,$SecurePassword

#Get Group
$Group = Get-ADGroup -LDAPFilter "(DistinguishedName=${DistinguishedNameGroup})" -Server $Server -Credential $Credential

#Find Enabled User not include searched group
$UserAdd = Get-ADUser -LDAPFilter "(&(!memberOf=${DistinguishedNameGroup})(!userAccountControl:1.2.840.113556.1.4.803:=2))" -SearchBase $SearchBaseOU -Server $Server -Credential $Credential

#Check variable $UserAdd on null 
if($UserAdd)
{
    #Add find User in searched group
    Add-ADGroupMember -Identity $Group -Members $UserAdd -Server $Server -Credential $Credential
}

#Find Disabled User include searched group
$UserDelete = Get-ADUser -LDAPFilter "(&(memberOf=${DistinguishedNameGroup})(userAccountControl:1.2.840.113556.1.4.803:=2))" -SearchBase $SearchBaseOU -Server $Server -Credential $Credential

#Check variable $UserDelete on null 
if($UserDelete)
{
    #Remove find User in searched group
    Remove-ADGroupMember -Identity $Group -Members $UserDelete -Server $Server -Credential $Credential -Confirm:$false
}