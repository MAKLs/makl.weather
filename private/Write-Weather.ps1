$FORMAT = @(
"",
""
"Current weather report for $(Set-RGBText "{3}" 132,222,2), $(Set-RGBText "{4}" 132,222,2)",
"",
"Temperature: {6:g3}{5}",
"Pressure:    {7:g3}",
"Humidity:    {8:g3}%",
"Coverage:    {9:g2}%",
"Wind    :    {10:g3}",
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
		([Units]::kelvin)   {$unit_symbol = " K"; break}
		([Units]::metric)   {$unit_symbol = [char]176 + "C"; break}
		([Units]::imperial) {$unit_symbol = [char]176 + "F"; break}
		default             {$unit_symbol = ""}
	}
	$weatherIcon = Get-WeatherIcon -IconID $WeatherData.weather[0].icon
	$report_values = @(
		(Get-Date "1970-01-01 00:00:00").AddSeconds($WeatherData.dt).toLocalTime(),
		$Global:SETTINGS.api.weather.name,
		$Global:SETTINGS.api.location.name
		$WeatherData.name,
		$WeatherData.sys.country,
		$unit_symbol,
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