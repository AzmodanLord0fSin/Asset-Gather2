###############################################################################################################
# Asset gathering script for Holysov, Daimler Buses                                                           #
# Version: 0.1                                                                                                #
# Copyright: All rights reserved                                                                              #
# Author: Tobias Knobloch, Acurity - Lutz und Grub AG                                                         # 
# Date: 2023-07-31                                                                                            # 
# Description: This script gathers all relevant information about the asset and writes it to a csv file.      #
# Usage: Run the script on the asset you want to gather information from.                                     #
# Requirements: Powershell 5.1                                                                                #
###############################################################################################################

# execute this script in the whole subnet
#Get-NetNeighbor -AddressFamily IPv4 | Select-Object -ExpandProperty IPAddress | ForEach-Object {Invoke-Command -ComputerName $_ -FilePath C:\Temp\Holysov_Asset_V0.ps1}

# get ip adress

$ip = Get-NetIPAddress -AddressFamily IPv4 | Select-Object -ExpandProperty IPAddress

# get hostname
$hostname = hostname

#get logged in user
$user = Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty UserName

#get mac adress
$mac = Get-NetAdapter | Select-Object -ExpandProperty MacAddress

# get OS
$os = Get-CimInstance Win32_OperatingSystem | Select-Object -ExpandProperty Caption

# get nic vendor
#$nic = Get-NetAdapter | Select-Object -ExpandProperty Manufacturer

# get domain
$domain = Get-WmiObject Win32_ComputerSystem | Select-Object -ExpandProperty Domain

# get default gateway
$gateway = Get-NetRoute -DestinationPrefix

# get subnet mask
$subnet = Get-NetIPAddress -AddressFamily IPv4 | Select-Object -ExpandProperty PrefixLength

# get dhcp server
$dhcp = Get-NetIPConfiguration | Select-Object -ExpandProperty DNSServer

# get dns server
$dns = Get-NetIPConfiguration | Select-Object -ExpandProperty DNSServer

# get wins server
$wins = Get-NetIPConfiguration | Select-Object -ExpandProperty WINSserver

# get NetBIOS over TCP/IP
$netbios = Get-NetIPConfiguration | Select-Object -ExpandProperty NetBIOSoverTCPEnabled

# get bootup time
$bootup = Get-CimInstance Win32_OperatingSystem | Select-Object -ExpandProperty LastBootUpTime



# write to file
$ip + ";" + $hostname + ";" + $user + ";" + $mac + ";" + $os + ";" + $domain + ";" + $gateway + ";" + $subnet + ";" + $dhcp + ";" + $dns + ";" + $wins + ";" + $netbios + ";" + $bootup | Out-File -FilePath C:\Temp\asset1.csv -NoNewline
 

 