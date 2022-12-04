# HyperVLab

## https://www.thomasmaurer.ch/2016/05/set-up-a-hyper-v-virtual-switch-using-a-nat-network/

## Install Hyper-V role
  
  Install-WindowsFeature -Name Hyper-V -IncludeManagementTools

## Create a new Hyper-V Virtual Switch

  New-VMSwitch –SwitchName “NATSwitch” –SwitchType Internal

## Configure the NAT Gateway IP Address

  New-NetIPAddress –IPAddress 192.168.0.1 -PrefixLength 16 -InterfaceAlias "vEthernet (NATSwitch)"
  
## Now you can configure the NAT rule

  New-NetNat –Name PHSnetwork –InternalIPInterfaceAddressPrefix 192.168.1.0/24
  New-NetNat –Name PTAnetwork –InternalIPInterfaceAddressPrefix 192.168.2.0/24
  New-NetNat –Name FEDnetwork –InternalIPInterfaceAddressPrefix 192.168.3.0/24
  
## Create a new NAT forwarding.
## This example creates a mapping between port 82 of the Virtual Machine host to port 80 of a Virtual Machine with an IP address of 172.21.21.3.

  Add-NetNatStaticMapping -NatName "PHSnetwork" -Protocol TCP -ExternalIPAddress 0.0.0.0 -InternalIPAddress 172.16.0.3 -InternalPort 3389 -ExternalPort 82

  
