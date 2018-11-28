function Get-MyLocation ()
{
   $endpoint = $Global:SETTINGS.api.location.endpoint
   try
   {
      $response = Invoke-RestMethod $endpoint
   }
   catch
   {
      Write-Warning "Unable to connect to endpoint: $endpoint"
      return $null
   }
   return New-Object -Property @{lon = $response.lon; lat = $response.lat} -TypeName PSObject
}
