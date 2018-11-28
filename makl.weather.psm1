$public = Get-ChildItem -Path (Join-Path $PSScriptRoot "public") -Recurse -Filter *.ps1
$private = Get-ChildItem -Path (Join-Path $PSScriptRoot "private") -Recurse -Filter *.ps1

#Load public functions
foreach ($import in $private)
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

#Load settings
$Global:SETTINGS = ([xml](Get-Content (Join-Path $PSScriptRoot "settings.xml"))).settings
$Global:SETTINGS.data.cache = [string](Join-Path $PSScriptRoot $Global:SETTINGS.data.cache)

#catch {Write-Warning "Could not load module settings"}

#Export only public functions
Export-ModuleMember -Function $public.BaseName