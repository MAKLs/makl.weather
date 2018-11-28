function EmbedInto-WeatherIcon
{
   param
   (
      [string]$IconString,
      [array]$ToEmbed,
      [int32]$IconOffset=0,
      [int32]$Padding=0
   )

   $IconArray = $IconString -split ([char]13 + [char]10)
   $ColorlessIconArray = $IconArray | % {Remove-TerminalColors $_}
   $IconWidth = ($ColorlessIconArray| Measure-Object -Property Length -Maximum).Maximum
   $EmbeddedIcon = @()
   
   $maxIndex = (@($ToEmbed.Length,($IconArray.Length + [math]::abs($IconOffset))) | Measure-Object -Maximum).Maximum
   
   switch ($IconOffset)
   {
      {$_ -lt 0} {$icon_i = 0; $embed_i = $_; break}
      {$_ -gt 0} {$icon_i = -$_; $embed_i = 0; break}
      default   {$icon_i = 0; $embed_i = 0}
   }
   
   for ($i = 0; $i -lt $maxIndex; $i++)
   {
      $iconLine = $(if ($icon_i -lt 0 -or $icon_i -ge $IconArray.Count) {""} else {$IconArray[$icon_i]})
      $colorlessIconLine = Remove-TerminalColors $iconLine
      $padLine = " " * $(if ($iconLine.Length -eq 0) {0} else {$IconWidth - $colorlessIconLine.Length + $Padding})
      $embedLine = $(if ($embed_i -lt 0 -or $embed_i -ge $ToEmbed.Count) {""} else {$ToEmbed[$embed_i]})
      
      $EmbeddedIcon += ,($iconLine + $padLine + $embedLine)
      
      $icon_i++
      $embed_i++
   }
   return $EmbeddedIcon -join ([char]13 + [char]10)
}