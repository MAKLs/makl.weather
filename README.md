# makl.weather
PowerShell module for getting the current weather report

## Installation
 1. Install **makl.weather** from the PowerShell Gallery:
	```powershell
	Install-Module makl.weather
	```
 2. Visit [OpenWeatherMap](https://openweathermap.org/) and create an account to obtain an API key.
 3. Set **makl.weather**'s API key with:
	```powershell
	 Set-WeatherAPIKey -APIKey <OpenWeatherMap_APIKey>
	```

## Usage
```powershell
Get-Weather  #weather report for current location
Get-Weather -Coordinates  40.440,-70.976  #weather report for latitude,longitude
Get-Weather -City Pittsburgh -Country US  #weather report for city
```