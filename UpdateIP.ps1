
#Perform Prerequisite Setup Steps First
#Download latest Windows Azure PowerShell Module: http://go.microsoft.com/?linkid=9811175&clcid=0x409 
Import-Module "C:\Program Files (x86)\Microsoft SDKs\Windows Azure\PowerShell\Azure\Azure.psd1"

#Execute: Get-AzurePublishSettingsFile; Save .publishsettings file locally 
#Get-AzurePublishSettingsFile  

#Variables
$Path = "C:\Scripts"
$DynDNS = "xxx.no-ip.com"
$AzureSubscriptionName = "Windows Azure MSDN - Visual Studio Ultimate"  
$AzurePublishSettingsFile = "$Path\Windows Azure MSDN - Visual Studio Ultimate-11-19-2013-credentials.publishsettings" 

#Execute: Import-AzurePublishSettingsFile; reference local .publishsettings file 
Import-AzurePublishSettingsFile -PublishSettingsFile $AzurePublishSettingsFile  
Set-AzureSubscription -SubscriptionName $AzureSubscriptionName  
Select-AzureSubscription -SubscriptionName $AzureSubscriptionName  

#Get IP based on the Domain Name
[string]$IP = ([System.Net.DNS]::GetHostAddresses($DynDNS)).IPAddressToString

#Get AzureVnetConfiguration
Get-AzureVnetConfig -ExportToFile "$Path\AzurevNetConfigCurrent.xml" | Out-Null

[xml]$xml = Get-Content "$Path\AzurevNetConfigCurrent.xml"
[string]$AzureIP =  $xml.NetworkConfiguration.VirtualNetworkConfiguration.LocalNetworkSites.LocalNetworkSite.VPNGatewayAddress

#Check if the IPs are still the same
if($IP -ne $AzureIP)
{
  #IP Changed, we need to update
  Write-host "IP Update In Progress..."

  #Update the configuration file
  $xml.NetworkConfiguration.VirtualNetworkConfiguration.LocalNetworkSites.LocalNetworkSite.VPNGatewayAddress =  $IP
  $xml.Save("$Path\AzurevNetConfigNew.xml")

  #Upload the configuration file to Azure
  $Ret = Set-AzureVNetConfig -ConfigurationPath "$Path\AzurevNetConfigNew.xml"
  if($Ret.OperationStatus -eq "Succeeded")
  {
   Write-host "IP Updated Successfully"
  }
  else
  {
   Write-host "IP Update Failed"
  }

  # Dial-in to Azure gateway (optional and only if this script is running on the RRAS server)
  #Connect-VpnS2SInterface -Name xxx.xxx.xxx.xxx

}
else
{
#IP didn't change, nothing to do
Write-host "IP Already Up To Date"
}





