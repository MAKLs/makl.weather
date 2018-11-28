$FORMAT = @(
"",
""
"Current weather report for $(Set-RGBText "{3}" 132,222,2), $(Set-RGBText "{4}" 132,222,2)",
"",
"Temperature: {8:g3}{5}",
"Pressure   : {9:g4} {6}",
"Humidity   : {10:g3}%",
"Coverage   : {11:g2}%",
"Wind       : {12:g3} {7}",
"",
"",
"Last updated: {0:dd-MMM-yyyy HH:mm:ss}",
"",	 
"Weather data provided by $(Set-RGBText "{1}" 255,140,24)",
"Location data provided by $(Set-RGBText "{2}" 80,161,255)",
"",
""
)


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
		([Units]::kelvin)   
		{
			$unit_symbol = @{temperature = " K"; pressure = "hPa"; wind = "m/s"}
			break
		}
		([Units]::metric)   
		{
			$unit_symbol = @{temperature = [char]176 + "C"; pressure = "hPa"; wind = "m/s"}
			break
		}
		([Units]::imperial) 
		{
			$unit_symbol = @{temperature = [char]176 + "F"; pressure = "hPa"; wind = "mph"}
			break
		}
		default
		{
			$unit_symbol = @{temperature = ""; pressure = ""; wind = ""}
		}
	}
	
	$weatherIcon = Get-WeatherIcon -IconID $WeatherData.weather[0].icon
	$report_values = @(
		(Get-Date "1970-01-01 00:00:00").AddSeconds($WeatherData.dt).toLocalTime(),
		$Global:SETTINGS.api.weather.name,
		$Global:SETTINGS.api.location.name
		$WeatherData.name,
		$WeatherData.sys.country,
		$unit_symbol["temperature"],
		$unit_symbol["pressure"],
		$unit_symbol["wind"],
		$WeatherData.main.temp,
		$WeatherData.main.pressure,
		$WeatherData.main.humidity,
		$WeatherData.clouds.all,
		$WeatherData.wind.speed
	)
	$report = (EmbedInto-WeatherIcon -IconString $weatherIcon -ToEmbed $FORMAT -IconOffset 4 -Padding 3) -f $report_values
	
	if (!$Host.UI.SupportsVirtualTerminal)
	{
		#Strip colors if virtual terminal is not supported
		$report = Remove-TerminalColors $report
	}
	
	Write-Host $report
}