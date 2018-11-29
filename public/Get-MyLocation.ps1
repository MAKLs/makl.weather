function Get-MyLocation ()
{
   $endpoint = $Global:WEATHER_SETTINGS.api.location.endpoint
   try
   {
      $response = Invoke-RestMethod $endpoint
   }
   catch
   {
      Write-Host "Unable to get location data from endpoint: `n`t$endpoint" -ForegroundColor $Host.PrivateData.WarningForegroundColor
      Write-Host $_ -ForegroundColor $Host.PrivateData.WarningForegroundColor
      $response = @{lon = 0; lat = 0}
   }
   finally
   {
      $response =  New-Object -Property @{lon = $response.lon; lat = $response.lat} -TypeName PSObject
   }
   return $response
}