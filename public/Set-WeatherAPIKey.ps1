function Set-WeatherAPIKey
{
   param
   (
      [string]$APIKey
   )

   $moduleRoot = Split-Path $PSScriptRoot -Parent

   #Save the API Key change
   $Global:WEATHER_SETTINGS.settings.api.weather.key = $APIKey
   $Global:WEATHER_SETTINGS.Save((Join-Path $moduleRoot "settings.xml"))

   #Re-import module for change to take effect
   Import-Module (Join-Path $moduleRoot "makl.weather.psm1") -Force -Global | Out-Null
}