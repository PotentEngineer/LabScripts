<#
.DESCRIPTION
    This script creates a c:\temp\capture folder if it doesn't exist and then starts a Wireshark capture with the appropriate parameters

    Wireshark paremeters
    Start WireShark trace
    RingBuffer: 4
    File size: 100 MB
    Start capture immediately
    Save .pcappng to c:\temp\capture
.PARAMETER <Parameter_Name>
    N/A
.INPUTS
    N/A
.OUTPUTS
    .pcappng files saved to c:\temp\capture
.NOTES
    Version:        1.0
    Author:         Daniel Ratliff
    Creation Date:  Tuesday, March 12th 2024, 11:02:58 am
    File: Start-WiresharkCapture.ps1
    Copyright (c) 2024 Humana Inc.
HISTORY:
Date      	          By	Comments
----------	          ---	----------------------------------------------------------

.LINK
    https://www.wireshark.org/docs/wsug_html_chunked/ChCustCommandLine.html

.COMPONENT
    Wireshark must be installed

.EXAMPLE
    Start-WiresharkCapture.ps1
#>
if (Test-Path 'C:\Program Files\Wireshark\Wireshark.exe') { # Check if Wireshark is installed
    if (!(Test-Path c:\temp\capture)) { # Check if c:\temp\capture exists
        New-Item -Path c:\temp -Name capture -ItemType Directory -Force # Create capture directory
    }
    
    $WSProcess = (Get-Process -Name Wireshark -ErrorAction SilentlyContinue)

    if ($WSProcess -eq $null) {
        # Gather the interface number
        $IntAlias = Get-NetIPInterface -AddressFamily IPv4 -ConnectionState Connected -Dhcp Enabled | Select-Object -ExpandProperty InterfaceAlias
        $IntListraw = & "C:\Program Files\Wireshark\Wireshark.exe" -D | Out-String
        $IntList = ($IntListraw.Split("`n"))
        $wsIntName = $IntList | Select-String -SimpleMatch ('(' + $IntAlias + ')')
        $wsIntNumber = $wsIntName.ToString()[0]

        Write-Output 'Wireshark not running, starting Wireshark.'

        # Start the capture
        & "C:\Program Files\Wireshark\Wireshark.exe" -i $wsIntNumber -b filesize:100000 -k -w "C:\temp\capture\$($env:username)-$($env:computername)-DMS.pcapng"
    } elseif ($WSProcess.count -ge 2) {
        Write-Warning 'Multiple Wireshark processes running, killing, and starting Wireshark!'
        Stop-Process -Name dumpcap -Force
        Start-Sleep -Seconds 5
        Stop-Process -Name wireshark -Force
        
        # Gather the interface number
        $IntAlias = Get-NetIPInterface -AddressFamily IPv4 -ConnectionState Connected -Dhcp Enabled | Select-Object -ExpandProperty InterfaceAlias
        $IntListraw = & "C:\Program Files\Wireshark\Wireshark.exe" -D | Out-String
        $IntList = ($IntListraw.Split("`n"))
        $wsIntName = $IntList | Select-String -SimpleMatch ('(' + $IntAlias + ')')
        $wsIntNumber = $wsIntName.ToString()[0]

        # Start the capture
        & "C:\Program Files\Wireshark\Wireshark.exe" -i $wsIntNumber -b filesize:100000 -k -w "C:\temp\capture\$($env:username)-$($env:computername)-DMS.pcapng"
    } else {
        Write-Warning 'Wireshark is already running, not starting a new instance!'
    }
}