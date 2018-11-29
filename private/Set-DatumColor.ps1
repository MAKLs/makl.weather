$LIMITS = @{
Temperature = @{Lo = 273; Mid = $null; Hi = 300};
WindSpeed   = @{Lo = 3; Mid = 6; Hi = 15}
}

function Set-DatumColor
{
   param
   (
      [ValidateSet("Temperature","WindSpeed")]
      [string]$ValueType,

      [double]$Value,

      [Units[]]$SourceUnit
   )

   $valueKelvin = ConvertTo-Kelvin -ValueType $ValueType -Value $Value -SourceUnit $SourceUnit
   $limitparams = $LIMITS[$ValueType]
   $color = Get-ColorFromGradient -Value $valueKelvin @limitparams
   
   return Set-RGBText -Text ("{0:g3}" -f $Value) -ForegroundRGB $color
}