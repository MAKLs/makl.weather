function Set-DatumColor
{
   param
   (
      [ValidateSet("Temperature","WindSpeed")]
      [DatumTypes[]]$DatumType,

      [double]$Value,

      [Units[]]$SourceUnit
   )

   $valueKelvin = ConvertTo-Kelvin -DatumType $DatumType -Value $Value -SourceUnit $SourceUnit
   switch ($DatumType)
   {
      ([DatumTypes]::Temperature)   {$gradparams = @{Lo = 266; Mid = 289; Hi = 310}; break}
      ([DatumTypes]::WindSpeed)     {$gradparams = @{Lo = 3; Mid = 6; Hi = 15; Gradient = @{Lo = @(145,255,0); Mid = @(255,255,51); Hi = @(255,40,0)}}; break}
      default                       {$gradparams = @{Lo = $valueKelvin; Mid = $valueKelvin; Hi = $valueKelvin}}
   }
   $color = Get-ColorFromGradient -Value $valueKelvin @gradparams
   
   return Set-RGBText -Text ("{0:g3}" -f $Value) -ForegroundRGB $color
}