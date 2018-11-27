enum Units
{
	kelvin
	metric
	imperial #default
}


function Get-Weather
{
	param
	(
		[string]$City="Philadelphia",
		[string]$CountryCode="US",
		
		[Units[]]
		$Unit=[Units]::imperial,
		
		[switch]$PassThru
	)
	
	$unitVal = if ($Unit -ne [Units]::kelvin) {"&units={0}" -f ($Unit -as [string])} else {""}
	$endpoint = $Global:SETTINGS.api.endpoint
	$key = $Global:SETTINGS.api.key
	$query = "?q={0},{1}{2}" -f $City,$CountryCode,$unitVal
	$request = $endpoint + $query + ("&APPID={0}" -f $key)
	
	try
	{
		$weatherData = Invoke-RestMethod $request
	}
	catch
	{
		Write-Warning "Unable to connect to endpoint: $endpoint"
		return $null
	}
	
	Write-Weather -WeatherData $weatherData -Unit $Unit
	if ($PassThru) {return $weatherData}
	#else {Write-Weather -WeatherData $weatherData}
}