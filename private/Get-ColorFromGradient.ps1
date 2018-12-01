#region Helper
function NormalizeOver-Range
{
   param
   (
      [double]$Value,
      [double]$Lo,
      [double]$Hi
   )
   return ($Value - $Lo) / ($Hi - $Lo)
}
#endregion

function Get-ColorFromGradient
{
   param
   (
      [double]$Value,
      [double]$Lo,
      [double]$Mid = $null,
      [double]$Hi,
      [hashtable]$Gradient = @{Lo = @(0,98,255); Mid = @(145,255,0); Hi = @(255,40,0)}
   )
   
   if (!$Mid) {$Mid = ($Hi + $Lo) / 2}

   #Normalize the value for the specific range
   #This will be the ratio of each Lo, Mid and Hi colors mixed into the result
   switch ($Value)
   {
      {$_ -le $Lo}  {$colorratio = @{Lo = 1; Mid = 0; Hi = 0}; break}
      {$_ -le $Mid} {$normal = NormalizeOver-Range $Value $Lo $Mid; $colorratio = @{Lo = (1-$normal); Mid = $normal; Hi = 0}; break}
      {$_ -le $Hi}  {$normal = NormalizeOver-Range $Value $Mid $Hi; $colorratio = @{Lo = 0; Mid = (1-$normal); Hi = $normal}; break}
      {$_ -gt $Hi}  {$colorratio = @{Lo = 0; Mid = 0; Hi = 1}}
   }

   #Mix the colors from each limit in the appropriate ratios
   $color = @(0, 0, 0)
   foreach ($limit in $Gradient.Keys)
   {
      for ($i = 0; $i -lt $color.Count; $i++)
      {
         $color[$i] += $colorratio[$limit] * $Gradient[$limit][$i]
      }
   }

   #Round the mixed colors to make a valid R,G,B tuple
   return ($color | % {[math]::Round($_)})
}