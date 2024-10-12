<#
.DESCRIPTION
    This script starts a Perfmon trace using the provided Genesys Cloud .XML
.INPUTS
	DataCollectorSet stored in XML
.OUTPUTS
    Perfmon files are saved to C:\perflogs\admin\Genesys Cloud
.NOTES
    Version:        0.1
    Author:         Daniel Ratliff
    Creation Date:  Thursday, April 11th 2024, 2:43:19 pm
    File: Start-PerfMonCapture.ps1
    Copyright (c) 2024 Humana Inc.
HISTORY:
Date      	          By	Comments
----------	          ---	----------------------------------------------------------

.LINK
    https://www.aussierobsql.com/using-powershell-to-setup-performance-monitor-data-collector-sets/
    https://www.jonathanmedd.net/2010/11/managing-perfmon-data-collector-sets-with-powershell.html
    https://rabiachrafi.wordpress.com/2016/07/11/using-powershell-to-stopstart-perfmon-data-collectors/
.EXAMPLE
    Start-PerfMonCapture.ps1
#
#>

$DCSTemplate = @"
<?xml version="1.0" encoding="UTF-16"?>
<DataCollectorSet>
	<Status>0</Status>
	<Duration>0</Duration>
	<Description>
	</Description>
	<DescriptionUnresolved>
	</DescriptionUnresolved>
	<DisplayName>
	</DisplayName>
	<DisplayNameUnresolved>
	</DisplayNameUnresolved>
	<SchedulesEnabled>-1</SchedulesEnabled>
	<LatestOutputLocation>C:\PerfLogs\Admin\Genesys Cloud\WKMJ0G3T9P_20240412-000008</LatestOutputLocation>
	<Name>GenesysCloud</Name>
	<OutputLocation>C:\PerfLogs\Admin\Genesys Cloud\WKMJ0G3T9P_20240412-000009</OutputLocation>
	<RootPath>%systemdrive%\PerfLogs\Admin\Genesys Cloud</RootPath>
	<Segment>-1</Segment>
	<SegmentMaxDuration>3600</SegmentMaxDuration>
	<SegmentMaxSize>0</SegmentMaxSize>
	<SerialNumber>9</SerialNumber>
	<Server>
	</Server>
	<Subdirectory>
	</Subdirectory>
	<SubdirectoryFormat>3</SubdirectoryFormat>
	<SubdirectoryFormatPattern>yyyyMMdd\-NNNNNN</SubdirectoryFormatPattern>
	<Task>
	</Task>
	<TaskRunAsSelf>0</TaskRunAsSelf>
	<TaskArguments>
	</TaskArguments>
	<TaskUserTextArguments>
	</TaskUserTextArguments>
	<UserAccount>SYSTEM</UserAccount>
	<Security>O:BAG:S-1-12-1-1498203301-1140415803-2758401208-2674046123D:AI(A;;FA;;;SY)(A;;FA;;;BA)(A;;0x1200a9;;;LU)(A;;0x1301ff;;;S-1-5-80-2661322625-712705077-2999183737-3043590567-590698655)(A;ID;0x1f019f;;;BA)(A;ID;0x1f019f;;;SY)(A;ID;FR;;;AU)(A;ID;FR;;;LS)(A;ID;FR;;;NS)(A;ID;FA;;;BA)</Security>
	<StopOnCompletion>0</StopOnCompletion>
	<TraceDataCollector>
		<DataCollectorType>1</DataCollectorType>
		<Name>DataCollector02</Name>
		<FileName>DataCollector02</FileName>
		<FileNameFormat>0</FileNameFormat>
		<FileNameFormatPattern>
		</FileNameFormatPattern>
		<LogAppend>0</LogAppend>
		<LogCircular>0</LogCircular>
		<LogOverwrite>0</LogOverwrite>
		<LatestOutputLocation>C:\PerfLogs\Admin\Genesys Cloud\WKMJ0G3T9P_20240412-000008\DataCollector02.etl</LatestOutputLocation>
		<Guid>{00000000-0000-0000-0000-000000000000}</Guid>
		<BufferSize>8</BufferSize>
		<BuffersLost>0</BuffersLost>
		<BuffersWritten>0</BuffersWritten>
		<ClockType>1</ClockType>
		<EventsLost>0</EventsLost>
		<ExtendedModes>0</ExtendedModes>
		<FlushTimer>0</FlushTimer>
		<FreeBuffers>0</FreeBuffers>
		<MaximumBuffers>0</MaximumBuffers>
		<MinimumBuffers>0</MinimumBuffers>
		<NumberOfBuffers>0</NumberOfBuffers>
		<PreallocateFile>0</PreallocateFile>
		<ProcessMode>0</ProcessMode>
		<RealTimeBuffersLost>0</RealTimeBuffersLost>
		<SessionName>DataCollector02</SessionName>
		<SessionThreadId>0</SessionThreadId>
		<StreamMode>1</StreamMode>
	</TraceDataCollector>
	<ConfigurationDataCollector>
		<DataCollectorType>2</DataCollectorType>
		<Name>DataCollector03</Name>
		<FileName>DataCollector03</FileName>
		<FileNameFormat>0</FileNameFormat>
		<FileNameFormatPattern>
		</FileNameFormatPattern>
		<LogAppend>0</LogAppend>
		<LogCircular>0</LogCircular>
		<LogOverwrite>0</LogOverwrite>
		<LatestOutputLocation>C:\PerfLogs\Admin\Genesys Cloud\WKMJ0G3T9P_20240412-000008\DataCollector03.xml</LatestOutputLocation>
		<QueryNetworkAdapters>0</QueryNetworkAdapters>
		<FileMaxCount>0</FileMaxCount>
		<FileMaxTotalSize>0</FileMaxTotalSize>
		<FileMaxRecursiveDepth>0</FileMaxRecursiveDepth>
		<RegistryMaxRecursiveDepth>0</RegistryMaxRecursiveDepth>
		<SystemStateFile>
		</SystemStateFile>
	</ConfigurationDataCollector>
	<PerformanceCounterDataCollector>
		<DataCollectorType>0</DataCollectorType>
		<Name>DataCollector01</Name>
		<FileName>DataCollector01</FileName>
		<FileNameFormat>0</FileNameFormat>
		<FileNameFormatPattern>
		</FileNameFormatPattern>
		<LogAppend>0</LogAppend>
		<LogCircular>0</LogCircular>
		<LogOverwrite>0</LogOverwrite>
		<LatestOutputLocation>C:\PerfLogs\Admin\Genesys Cloud\WKMJ0G3T9P_20240412-000008\DataCollector01.blg</LatestOutputLocation>
		<DataSourceName>
		</DataSourceName>
		<SampleInterval>1</SampleInterval>
		<SegmentMaxRecords>0</SegmentMaxRecords>
		<LogFileFormat>3</LogFileFormat>
		<Counter>\Memory\% Committed Bytes In Use</Counter>
		<Counter>\Memory\Available MBytes</Counter>
		<Counter>\Memory\Cache Faults/sec</Counter>
		<Counter>\Memory\Page Faults/sec</Counter>
		<Counter>\Memory\Pages/sec</Counter>
		<Counter>\PhysicalDisk(*)\% Disk Time</Counter>
		<Counter>\PhysicalDisk(*)\% Idle Time</Counter>
		<Counter>\PhysicalDisk(*)\Avg. Disk Bytes/Transfer</Counter>
		<Counter>\PhysicalDisk(*)\Avg. Disk Queue Length</Counter>
		<Counter>\PhysicalDisk(*)\Current Disk Queue Length</Counter>
		<Counter>\PhysicalDisk(*)\Disk Transfers/sec</Counter>
		<Counter>\Process(*)\% Privileged Time</Counter>
		<Counter>\Process(*)\% Processor Time</Counter>
		<Counter>\Process(*)\% User Time</Counter>
		<Counter>\Process(*)\Elapsed Time</Counter>
		<Counter>\Process(*)\Handle Count</Counter>
		<Counter>\Process(*)\ID Process</Counter>
		<Counter>\Process(*)\IO Data Bytes/sec</Counter>
		<Counter>\Process(*)\Working Set</Counter>
		<Counter>\Process(*)\Working Set - Private</Counter>
		<Counter>\Process(*)\Working Set Peak</Counter>
		<Counter>\Processor(*)\% C1 Time</Counter>
		<Counter>\Processor(*)\% C2 Time</Counter>
		<Counter>\Processor(*)\% C3 Time</Counter>
		<Counter>\Processor(*)\% Idle Time</Counter>
		<Counter>\Processor(*)\% Interrupt Time</Counter>
		<Counter>\Processor(_Total)\% Processor Time</Counter>
		<Counter>\Processor(*)\% Processor Time</Counter>
		<Counter>\Process(*)\Priority Base</Counter>
		<Counter>\Thread(*)\Priority Base</Counter>
		<Counter>\Thread(*)\Elapsed Time</Counter>
		<Counter>\Thread(*)\Priority Current</Counter>
		<Counter>\Thread(*)\Thread State</Counter>
		<CounterDisplayName>\Memory\% Committed Bytes In Use</CounterDisplayName>
		<CounterDisplayName>\Memory\Available MBytes</CounterDisplayName>
		<CounterDisplayName>\Memory\Cache Faults/sec</CounterDisplayName>
		<CounterDisplayName>\Memory\Page Faults/sec</CounterDisplayName>
		<CounterDisplayName>\Memory\Pages/sec</CounterDisplayName>
		<CounterDisplayName>\PhysicalDisk(*)\% Disk Time</CounterDisplayName>
		<CounterDisplayName>\PhysicalDisk(*)\% Idle Time</CounterDisplayName>
		<CounterDisplayName>\PhysicalDisk(*)\Avg. Disk Bytes/Transfer</CounterDisplayName>
		<CounterDisplayName>\PhysicalDisk(*)\Avg. Disk Queue Length</CounterDisplayName>
		<CounterDisplayName>\PhysicalDisk(*)\Current Disk Queue Length</CounterDisplayName>
		<CounterDisplayName>\PhysicalDisk(*)\Disk Transfers/sec</CounterDisplayName>
		<CounterDisplayName>\Process(*)\% Privileged Time</CounterDisplayName>
		<CounterDisplayName>\Process(*)\% Processor Time</CounterDisplayName>
		<CounterDisplayName>\Process(*)\% User Time</CounterDisplayName>
		<CounterDisplayName>\Process(*)\Elapsed Time</CounterDisplayName>
		<CounterDisplayName>\Process(*)\Handle Count</CounterDisplayName>
		<CounterDisplayName>\Process(*)\ID Process</CounterDisplayName>
		<CounterDisplayName>\Process(*)\IO Data Bytes/sec</CounterDisplayName>
		<CounterDisplayName>\Process(*)\Working Set</CounterDisplayName>
		<CounterDisplayName>\Process(*)\Working Set - Private</CounterDisplayName>
		<CounterDisplayName>\Process(*)\Working Set Peak</CounterDisplayName>
		<CounterDisplayName>\Processor(*)\% C1 Time</CounterDisplayName>
		<CounterDisplayName>\Processor(*)\% C2 Time</CounterDisplayName>
		<CounterDisplayName>\Processor(*)\% C3 Time</CounterDisplayName>
		<CounterDisplayName>\Processor(*)\% Idle Time</CounterDisplayName>
		<CounterDisplayName>\Processor(*)\% Interrupt Time</CounterDisplayName>
		<CounterDisplayName>\Processor(_Total)\% Processor Time</CounterDisplayName>
		<CounterDisplayName>\Processor(*)\% Processor Time</CounterDisplayName>
		<CounterDisplayName>\Process(*)\Priority Base</CounterDisplayName>
		<CounterDisplayName>\Thread(*)\Priority Base</CounterDisplayName>
		<CounterDisplayName>\Thread(*)\Elapsed Time</CounterDisplayName>
		<CounterDisplayName>\Thread(*)\Priority Current</CounterDisplayName>
		<CounterDisplayName>\Thread(*)\Thread State</CounterDisplayName>
	</PerformanceCounterDataCollector>
	<DataManager>
		<Enabled>0</Enabled>
		<CheckBeforeRunning>0</CheckBeforeRunning>
		<MinFreeDisk>0</MinFreeDisk>
		<MaxSize>0</MaxSize>
		<MaxFolderCount>0</MaxFolderCount>
		<ResourcePolicy>0</ResourcePolicy>
		<ReportFileName>report.html</ReportFileName>
		<RuleTargetFileName>report.xml</RuleTargetFileName>
		<EventsFileName>
		</EventsFileName>
	</DataManager>
</DataCollectorSet>
"@

$DCSName = 'GenesysCloud'
$DCSCheck = logman query $DCSName # Query if DCS already exists

if ($DCSCheck[1] -like "*$($DCSName)") {
    Write-Output 'DCS found!'
	if ($DCSCheck[2] -like '*Running') {
		Write-Output 'Trace running, exiting...'
	} else {
		Write-Output 'Trace not running, starting...'
		$DCS.Start($false)
	}
} else {
    Write-Output 'DCS not found, creating...'
    
    # Create the Data Collector Set
    $DCS = New-Object -COM Pla.DataCollectorSet
    $DCS.DisplayName = $DCSName
    $DCS.SetXml($DCSTemplate)
    $DCS.Commit("$DCSName" , $null , 0x0003)

    # Start the data collection
    Write-Output 'Starting the DCS!'
    $DCS.start($false)
}