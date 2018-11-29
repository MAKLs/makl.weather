#region Helper functions for each value type
function ConvertTo-Temperature
{
   param
   (
      [double]$Temperature,
      [Units[]]$Unit
   )
   
   switch ($Unit)
   {
      ([Units]::metric)   {return $Temperature + 273.15}
      ([Units]::imperial) {return ($Temperature + 459.67) * 5 / 9}
      default             {return $Temperature}
   }
}

function ConvertTo-Speed
{
   param
   (
      [double]$Speed,
      [Units[]]$Unit
   )
   
   switch ($Unit)
   {
      ([Units]::imperial) {return $Speed * 0.44704}
      default             {return $Speed}
   }   
}
#endregion


#region Wrapper function for different value types
function ConvertTo-Kelvin
{
   param
   (
      [ValidateSet("Temperature","WindSpeed")]
      [string]$ValueType,

      [double]$Value,

      [Units[]]$SourceUnit
   )
   
   #OpenWeatherMaps API only changes units for these types
   switch ($ValueType)
   {
      "Temperature"   {return ConvertTo-Temperature -Temperature $Value -Unit $SourceUnit}
      "WindSpeed"     {return ConvertTo-Speed -Speed $Value -Unit $SourceUnit}
   }
}
#endregion