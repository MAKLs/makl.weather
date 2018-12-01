#region Global enumerations
enum Units
{
   kelvin
   metric
   imperial #default
}

enum DatumTypes
{
   Temperature
   Pressure
   WindSpeed
   CloudCover
}
#endregion


function Get-Weather
{
   [cmdletbinding(DefaultParameterSetName = "coord")]
   param
   (
      [Parameter(ParameterSetName = "coord")]
      [array]$Coordinates = @(),
      
      [Parameter(ParameterSetName = "city")]
      [string]$City="Philadelphia",
      
      [Parameter(ParameterSetName = "city")]
      [string]$CountryCode="US",
      
      [Parameter(ParameterSetName = "coord")]
      [Parameter(ParameterSetName = "city")]
      [Units[]]
      $Unit=[Units]::imperial,
      
      [Parameter(ParameterSetName = "coord")]
      [Parameter(ParameterSetName = "city")]
      [switch]$PassThru
   )

   #Set up query parameters
   $endpoint = $Global:WEATHER_SETTINGS.settings.api.weather.endpoint
   $key = $Global:WEATHER_SETTINGS.settings.api.weather.key
   $unitVal = if ($Unit -ne [Units]::kelvin) {"&units={0}" -f ($Unit -as [string])} else {""}

   #Build the weather API query
   if ($PSCmdlet.ParameterSetName -eq "coord")
   {
      if ($Coordinates.Count -ne 2)
      {
         $Coordinates = Get-MyLocation
         $Coordinates = @($Coordinates.lat, $Coordinates.lon)
      }
      $query = "?lat={0}&lon={1}{2}" -f ($Coordinates + ,$unitVal)
   }
   elseif ($PSCmdlet.ParameterSetName -eq "city")
   {
      $query = "?q={0},{1}{2}" -f $City,$CountryCode,$unitVal
   }
   $request = $endpoint + $query + ("&APPID={0}" -f $key)
   
   #Make a request to the weather API to get the weather data
   try
   {
      $weatherData = Invoke-RestMethod $request
   }
   catch
   {
      Write-Host "Unable to get weather data from endpoint: `n`t$endpoint" -ForegroundColor $Host.PrivateData.ErrorForegroundColor
      Write-Host $_ -ForegroundColor $Host.PrivateData.ErrorForegroundColor
      return $null
   }
   
   #Print out the weather report and optionally return the raw weather data
   Write-Weather -WeatherData $weatherData -Unit $Unit
   if ($PassThru) {return $weatherData}
}