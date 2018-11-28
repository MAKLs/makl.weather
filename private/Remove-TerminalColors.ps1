function Remove-TerminalColors
{
   param
   (
      [string]$InputString
   )
   $e = [char]27
   $pattern = "$e\[\d{1,2}((;\d{1,3}){4})?m"
   return $InputString -replace $pattern,""
}