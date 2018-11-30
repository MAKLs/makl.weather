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
      $response = New-Object -Property @{lon = 0; lat = 0} -TypeName PSObject
   }
   return $response
}