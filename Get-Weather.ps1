enum Units
{
	kelvin
	metric
	imperial #default
}


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

	$endpoint = $Global:SETTINGS.api.weather.endpoint
	$key = $Global:SETTINGS.api.weather.key
	$unitVal = if ($Unit -ne [Units]::kelvin) {"&units={0}" -f ($Unit -as [string])} else {""}
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