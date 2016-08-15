$Sub1          = "*********************"

$RG1           = "OnPremisesRG"
$Location1     = "WestEurope"

$RG4           = "CloudRG"
$Location4     = "NorthEurope"

$VNetName1     = "OnPremisesNet"
$FESubName1    = "FrontEnd"
$BESubName1    = "Backend"
$GWSubName1    = "GatewaySubnet"
$VNetPrefix11  = "10.11.0.0/16"
$VNetPrefix12  = "10.12.0.0/16"
$FESubPrefix1  = "10.11.0.0/24"
$BESubPrefix1  = "10.12.0.0/24"
$GWSubPrefix1  = "10.12.255.0/27"
$DNS1          = "8.8.8.8"
$GWName1       = "OnPremisesGW"
$GWIPName1     = "OnPremisesGWIP"
$GWIPconfName1 = "gwipconf1"
$Connection14  = "OnPremisestoCloud"
$Connection15  = "OnPremisestoVNet5"

$VnetName4     = "CloudNet"
$FESubName4    = "FrontEnd"
$BESubName4    = "Backend"
$GWSubName4    = "GatewaySubnet"
$VnetPrefix41  = "10.41.0.0/16"
$VnetPrefix42  = "10.42.0.0/16"
$FESubPrefix4  = "10.41.0.0/24"
$BESubPrefix4  = "10.42.0.0/24"
$GWSubPrefix4  = "10.42.255.0/27"
$DNS4          = "8.8.8.8"
$GWName4       = "CloudGW"
$GWIPName4     = "CloudGWIP"
$GWIPconfName4 = "gwipconf4"
$Connection41  = "CloudtoOnPremises"



Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionName $Sub1
New-AzureRmResourceGroup -Name $RG1 -Location $Location1

$fesub1 = New-AzureRmVirtualNetworkSubnetConfig -Name $FESubName1 -AddressPrefix $FESubPrefix1
$besub1 = New-AzureRmVirtualNetworkSubnetConfig -Name $BESubName1 -AddressPrefix $BESubPrefix1
$gwsub1 = New-AzureRmVirtualNetworkSubnetConfig -Name $GWSubName1 -AddressPrefix $GWSubPrefix1

New-AzureRmVirtualNetwork -Name $VNetName1 -ResourceGroupName $RG1 -Location $Location1 -AddressPrefix $VNetPrefix11,$VNetPrefix12 -Subnet $fesub1,$besub1,$gwsub1

$gwpip1    = New-AzureRmPublicIpAddress -Name $GWIPName1 -ResourceGroupName $RG1 -Location $Location1 -AllocationMethod Dynamic

$OnPremises     = Get-AzureRmVirtualNetwork -Name $VNetName1 -ResourceGroupName $RG1
$subnet1   = Get-AzureRmVirtualNetworkSubnetConfig -Name "GatewaySubnet" -VirtualNetwork $OnPremises
$gwipconf1 = New-AzureRmVirtualNetworkGatewayIpConfig -Name $GWIPconfName1 -Subnet $subnet1 -PublicIpAddress $gwpip1

New-AzureRmVirtualNetworkGateway -Name $GWName1 -ResourceGroupName $RG1 -Location $Location1 -IpConfigurations $gwipconf1 -GatewayType Vpn -VpnType RouteBased -GatewaySku Standard -
 
Write-host "Creating resource group"
New-AzureRmResourceGroup -Name $RG4 -Location $Location4 
$fesub4 = New-AzureRmVirtualNetworkSubnetConfig -Name $FESubName4 -AddressPrefix $FESubPrefix4
$besub4 = New-AzureRmVirtualNetworkSubnetConfig -Name $BESubName4 -AddressPrefix $BESubPrefix4
$gwsub4 = New-AzureRmVirtualNetworkSubnetConfig -Name $GWSubName4 -AddressPrefix $GWSubPrefix4

New-AzureRmVirtualNetwork -Name $VnetName4 -ResourceGroupName $RG4 -Location $Location4 -AddressPrefix $VnetPrefix41,$VnetPrefix42 -Subnet $fesub4,$besub4,$gwsub4

$gwpip4    = New-AzureRmPublicIpAddress -Name $GWIPName4 -ResourceGroupName $RG4 -Location $Location4 -AllocationMethod Dynamic
$Cloud     = Get-AzureRmVirtualNetwork -Name $VnetName4 -ResourceGroupName $RG4
$subnet4   = Get-AzureRmVirtualNetworkSubnetConfig -Name "GatewaySubnet" -VirtualNetwork $Cloud
$gwipconf4 = New-AzureRmVirtualNetworkGatewayIpConfig -Name $GWIPconfName4 -Subnet $subnet4 -PublicIpAddress $gwpip4

New-AzureRmVirtualNetworkGateway -Name $GWName4 -ResourceGroupName $RG4 -Location $Location4 -IpConfigurations $gwipconf4 -GatewayType Vpn -VpnType RouteBased -GatewaySku Standard

$OnPremisesgw = Get-AzureRmVirtualNetworkGateway -Name $GWName1 -ResourceGroupName $RG1
$Cloudgw = Get-AzureRmVirtualNetworkGateway -Name $GWName4 -ResourceGroupName $RG4



New-AzureRmVirtualNetworkGatewayConnection -Name $Connection14 -ResourceGroupName $RG1 -VirtualNetworkGateway1 $OnPremisesgw -VirtualNetworkGateway2 $Cloudgw -Location $Location1 -ConnectionType Vnet2Vnet -SharedKey 'AzureA1b2C3'
New-AzureRmVirtualNetworkGatewayConnection -Name $Connection41 -ResourceGroupName $RG4 -VirtualNetworkGateway1 $Cloudgw -VirtualNetworkGateway2 $OnPremisesgw -Location $Location4 -ConnectionType Vnet2Vnet -SharedKey 'AzureA1b2C3'
