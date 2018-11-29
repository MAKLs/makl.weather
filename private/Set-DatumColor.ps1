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
      ([DatumTypes]::Temperature)   {$gradparams = @{Lo = 273; Mid = $null; Hi = 300}; break}
      ([DatumTypes]::WindSpeed)     {$gradtparams = @{Lo = 3; Mid = 6; Hi = 15}; break}
      default                       {$gradparams = @{Lo = $valueKelvin; Mid = $valueKelvin; Hi = $valueKelvin}}
   }
   $color = Get-ColorFromGradient -Value $valueKelvin @gradparams
   
   return Set-RGBText -Text ("{0:g3}" -f $Value) -ForegroundRGB $color
}