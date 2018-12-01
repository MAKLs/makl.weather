function Get-DirectionIcon
{
   param
   (
      [double]$Direction,

      [ValidateSet("Degree","Radian")]
      [string]$Unit = "Degree"
   )
   
   #Set the values for a full rotation and sectors of 1/8 rotation
   switch ($Unit)
   {
      "Degree" {$rot = 360}
      "Radian" {$rot = 2 * [math]::PI}
   }
   $sect = $rot / 8
   
   #Group directions into the appropriate bucket
   switch ([int32][math]::round($Direction % $rot / $sect) % 8)
   {
      0 {return "N"}
      1 {return "NE"}
      2 {return "E"}
      3 {return "SE"}
      4 {return "S"}
      5 {return "SW"}
      6 {return "W"}
      7 {return "NW"}
   }
}