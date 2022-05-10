#Declare variables
$VMName = 'phs-dc-01'
$Switch = 'NATSwitch'
$InstallMedia = 'C:\ISOs\en_windows_server_2016_updated_feb_2018_x64_dvd_11636692.iso'
$Path = 'X:\hyper-v'
$VHDPath = 'X:\hyper-v\virtual hard disks\phs-dc-01.vhdx'
$VHDSize = '64424509440'

#Create New Virtual Machine
New-VM -Name $VMName -MemoryStartupBytes 8GB -BootDevice VHD -Path $Path -NewVHDPath $VHDPath -NewVHDSizeBytes $VHDSize  -Generation 2 -Switch $Switch  

#Set the memory to be non-dynamic
set-vm -Name "phs-dc-01" -DynamicMemory -ProcessorCount 2 -checkpointtype disabled 

#Add DVD Drive to Virtual Machine
Add-VMDvdDrive -VMName $VMName -ControllerNumber 0 -ControllerLocation 1 -Path $InstallMedia

#Mount Installation Media
$DVDDrive = Get-VMDvdDrive -VMName $VMName

#Configure Virtual Machine to Boot from DVD
Set-VMFirmware -VMName $VMName -FirstBootDevice $DVDDrive 