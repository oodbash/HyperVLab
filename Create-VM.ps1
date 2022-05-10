#Declare variables
$VMName = 'phs-dc-01'
$Switch = 'NATSwitch'
$InstallMedia = 'C:\ISOs\en-us_windows_server_2019_updated_aug_2021_x64_dvd_a6431a28.iso'
$Path = 'X:\hyper-v'
$VHDPath = 'X:\hyper-v\Virtual Hard Disks\phs-dc-01.vhdx'
$VHDSize = '64424509440'
#Create New Virtual Machine
New-VM -Name $VMName -MemoryStartupBytes 8GB -BootDevice VHD -NewVHDPath $VHDPath -NewVHDSizeBytes $VHDSize  -Generation 2 -Switch $Switch  
#Set the memory to be non-dynamic
set-vm -Name "phs-dc-01" -DynamicMemory -ProcessorCount 2 -checkpointtype disabled 
#Add DVD Drive to Virtual Machine
Add-VMDvdDrive -VMName $VMName -ControllerNumber 0 -ControllerLocation 1 -Path $InstallMedia
#Mount Installation Media
$DVDDrive = Get-VMDvdDrive -VMName $VMName
#Configure Virtual Machine to Boot from DVD
$VMFW = Get-VMFirmware -VMName $VMName
$dvd=$vmfw.bootorder[2] 
$pxe=$vmfw.bootorder[0] 
$hdd=$vmfw.bootorder[1] 
Set-VMFirmware -vmname $VMName -BootOrder $dvd,$hdd,$pxe
