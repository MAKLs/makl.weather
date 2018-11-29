$public = Get-ChildItem -Path (Join-Path $PSScriptRoot "public") -Recurse -Filter *.ps1
$private = Get-ChildItem -Path (Join-Path $PSScriptRoot "private") -Recurse -Filter *.ps1

#Load public functions
foreach ($import in $public)
{
   try {. $import.FullName}
   catch {Write-Warning ("Failed to import public function {0}" -f $import.BaseName)}
   Write-Host ("Imported public function {0}" -f $import.BaseName)
}

#Load private functions
foreach ($import in $private)
{
   try {. $import.FullName}
   catch {Write-Warning ("Failed to import private function {0}" -f $import.BaseName)}
   Write-Host ("Imported private function {0}" -f $import.BaseName)
}

#Load WEATHER_SETTINGS
try
{
   $Global:WEATHER_SETTINGS = ([xml](Get-Content (Join-Path $PSScriptRoot "settings.xml"))).settings
   $Global:WEATHER_SETTINGS.data.cache = [string](Join-Path $PSScriptRoot $Global:WEATHER_SETTINGS.data.cache)
}
catch 
{
   Write-Warning "Could not load module settings"
}

#Export only public functions
Export-ModuleMember -Function $public.BaseName