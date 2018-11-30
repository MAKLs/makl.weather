$FORMAT = @(
"",
""
"Current weather report for $(Set-RGBText "{3}" 132,222,2), $(Set-RGBText "{4}" 132,222,2)",
"",
"Temperature: {9:g3}{5}",
"Pressure   : {10:g4} {6}",
"Humidity   : {11:g3}%",
"Coverage   : {12:g2}%",
"Wind       : {13:g3} {7} $(Set-RGBText "{8}" 255,51,51)",
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
   $report_values = @(
      (Get-Date "1970-01-01 00:00:00").AddSeconds($WeatherData.dt).toLocalTime(),
      $Global:WEATHER_SETTINGS.api.weather.name,
      $Global:WEATHER_SETTINGS.api.location.name
      $(if($WeatherData.name) {$WeatherData.name} else {$WeatherData.coord.lat}),
      $(if($WeatherData.sys.country) {$WeatherData.sys.country} elseif ($WeatherData.name) {$WeatherData.name} else {$WeatherData.coord.lon}),
      $unit_symbol["temperature"],
      $unit_symbol["pressure"],
      $unit_symbol["wind"],
      (Get-DirectionIcon -Direction $WeatherData.wind.deg),
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