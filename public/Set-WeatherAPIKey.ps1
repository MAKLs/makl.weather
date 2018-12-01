function Set-WeatherAPIKey
{
   param
   (
      [string]$APIKey
   )

   $moduleRoot = Split-Path $PSScriptRoot -Parent

   #Change the API key
   $Global:WEATHER_SETTINGS.settings.api.weather.key = $APIKey

   #Save the change to disk
   $checking = $true
   $positiveResponses = [ValidateSet]::new("y","yes","yeah","yep")
   $negativeResponses = [ValidateSet]::new("n","no","nah","nope")
   while ($checking)
   {
      switch (Read-Host "Are you sure you'd like to permanently change your API key to ${APIKey}? (y/n)")
      {
         {$positiveResponses.ValidValues.Contains($_)}
         {
            Write-Host "Saving API key to disk for later sessions" -ForegroundColor Green
            $Global:WEATHER_SETTINGS.Save((Join-Path $moduleRoot "settings.xml"))
            $checking = $false
            break
         }
         {$negativeResponses.ValidValues.Contains($_)}
         {
            Write-Warning "API key change will only be in effect for this session"
            $checking = $false
            break
         }
         default
         {
            Write-Host "Invalid response. Please enter 'y' or 'n'"
         }
      }

   }
}