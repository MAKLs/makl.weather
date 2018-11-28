function Set-RGBText
{
   param
   (
      [Parameter(ValueFromPipeline=$true)]
      [string]$Text,
      [array]$ForegroundRGB,
      [array]$BackgroundRGB
   )

   $e = [char]27
   $eStr = "$e[{0}m{1}$e[0m"
   $fargs = @()
   $bargs = @()

   if ($ForegroundRGB)
   {
      $fargs += @(38,2,$ForegroundRGB[0],$ForegroundRGB[1],$ForegroundRGB[2])
   }
   if ($BackgroundRGB)
   {
      $bargs += @(48,2,$BackgroundRGB[0],$BackgroundRGB[1],$BackgroundRGB[2])
   }

   return ($eStr -f (($fargs+$bargs) -join ";"),$Text)
}