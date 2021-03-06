$FORMAT = @(
"",
""
"Current weather report for $(Set-RGBText "{3}" 132,222,2), $(Set-RGBText "{4}" 132,222,2)",
"",
"Condition  : {9}"
"Temperature: {10}{5}",
"Pressure   : {11:g4} {6}",
"Humidity   : {12:g3}%",
"Coverage   : {13:g2}%",
"Wind       : {14} {7} $(Set-RGBText "{8}" 255,51,51)",
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
      ([Units]::kelvin)   {$unit_symbol = @{temperature = " K"; pressure = "hPa"; wind = "m/s"}; break}
      ([Units]::metric)   {$unit_symbol = @{temperature = [char]176 + "C"; pressure = "hPa"; wind = "m/s"}; break}
      ([Units]::imperial) {$unit_symbol = @{temperature = [char]176 + "F"; pressure = "hPa"; wind = "mph"}; break}
      default             {$unit_symbol = @{temperature = ""; pressure = ""; wind = ""}}
   }
   $weatherIcon = Get-WeatherIcon -IconID $WeatherData.weather[0].icon
   #TODO Organize report values better... perhaps in a hashtable and splat
   #     into FORMAT for better readability
   $report_values = @(
      (Get-Date "1970-01-01 00:00:00").AddSeconds($WeatherData.dt).toLocalTime(),
      $Global:WEATHER_SETTINGS.settings.api.weather.name,
      $Global:WEATHER_SETTINGS.settings.api.location.name
      $(if($WeatherData.name) {$WeatherData.name} else {$WeatherData.coord.lat}),
      $(if($WeatherData.sys.country) {$WeatherData.sys.country} elseif ($WeatherData.name) {$WeatherData.name} else {$WeatherData.coord.lon}),
      $unit_symbol["temperature"],
      $unit_symbol["pressure"],
      $unit_symbol["wind"],
      (Get-DirectionIcon -Direction $WeatherData.wind.deg),
      $WeatherData.weather[0].description,
      (Set-DatumColor -DatumType ([DatumTypes]::Temperature) -Value $WeatherData.main.temp -SourceUnit $Unit),
      $WeatherData.main.pressure,
      $WeatherData.main.humidity,
      $WeatherData.clouds.all,
      (Set-DatumColor -DatumType ([DatumTypes]::WindSpeed) -Value $WeatherData.wind.speed -SourceUnit $Unit)
   )
   #Embed the weather icon into the report and format the values into it
   $report = (EmbedInto-WeatherIcon -IconString $weatherIcon -ToEmbed $FORMAT -IconOffset 4 -Padding 1) -f $report_values
   
   if (!$Host.UI.SupportsVirtualTerminal)
   {
      #Strip colors if virtual terminal is not supported
      $report = Remove-TerminalColors $report
   }
   
   Write-Host $report -ForegroundColor White
}