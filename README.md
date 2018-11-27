# makl.weather
PowerShell module for getting the current weather report

##Installation
```powershell
Install-Module makl.weather
```
## Usage
```powershell
Get-Weather  #weather report for current location
Get-Weather -Coordinates  40.440,-70.976  #weather report for latitude,longitude
Get-Weather -City Pittsburgh -Country US  #weather report for city
```