# Reference: http://windowsitpro.com/azure/use-powershell-change-subnet-and-ip-arm-vm

Login-AzureRmAccount
Set-AzureRmContext -SubscriptionName 'tim-2017'

$RGname = 'pluralsight1'
$VNetRG = 'pluralsight1'
$VMName = 'win01' 
$NICName = 'win01199'
$VNetName = 'vnet1' 
$TarSubnetName = 'frontend' #Target subnet name

$VM = Get-AzureRmVM -Name $VMName -ResourceGroupName $RGname

$VNET = Get-AzureRmVirtualNetwork -Name $VNetName -ResourceGroupName $VNetRG
$TarSubnet = Get-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $VNET -Name $TarSubnetName

$NIC = Get-AzureRmNetworkInterface -Name $NICName -ResourceGroupName $RGname
$NIC.IpConfigurations[0].Subnet.Id = $TarSubnet.Id
Set-AzureRmNetworkInterface -NetworkInterface $NIC

#Once the subnet has been set and that applied can apply the static IP address
$NIC = Get-AzureRmNetworkInterface -Name $NICName -ResourceGroupName $RGname
$NIC.IpConfigurations[0].PrivateIpAddress = '10.1.1.20'
$NIC.IpConfigurations[0].PrivateIPAllocationMethod = 'Static'
#$NIC.DnsSettings.DnsServers = '10.1.1.10'
Set-AzureRmNetworkInterface -NetworkInterface $NIC