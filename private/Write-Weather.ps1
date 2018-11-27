$e = [char]27
$FORMAT = @"

Current weather report for $e[38;2;132;222;2m{1}$e[0m, $e[38;2;132;222;2m{2}$e[0m

{3}

                 /---[Maximum]  {4:g3}{0}
                /		
    Temperature |----[Current]  {5:g3}{0}
                \
                 \---[Minimum]  {6:g3}{0}
				 

Last updated: {7:dd-MMM-yyyy HH:mm:ss}
				 
Data provided by $e[38;2;255;140;24m$($Global:SETTINGS.api.name)$e[0m

"@


function Write-Weather
{
	param
	(
		$WeatherData,
		[Units[]]$Unit
	)

	#Get the temperature unit
	switch ($Unit)
	{
		([Units]::kelvin)   {$unit_symbol = " K"; break}
		([Units]::metric)   {$unit_symbol = [char]176 + "C"; break}
		([Units]::imperial) {$unit_symbol = [char]176 + "F"; break}
		default             {$unit_symbol = ""}
	}
	
	$format_values = @(
		$unit_symbol,
		$WeatherData.name,
		$WeatherData.sys.country,
		(Get-WeatherIcon -IconID $WeatherData.weather[0].icon),
		$WeatherData.main.temp_max,
		$WeatherData.main.temp,
		$WeatherData.main.temp_min
		(Get-Date "1970-01-01 00:00:00").AddSeconds($WeatherData.dt).toLocalTime()
	)
	$report = $FORMAT -f $format_values
	if (!$Host.UI.SupportsVirtualTerminal)
	{
		#Strip colors if virtual terminal is not supported
		$report = $report -replace "$e\[\d{1,2}((;\d{1,3}){4})?m",""
	}
	
	Write-Host $report
}