$COLORS = @{
"ray" = @(227,171,87);
"sun" = @(255,247,0);
"moon" = @(242,243,244);
"cloudd" = @(209,234,255); #day cloud
"cloudn" = @(113,126,138); #night cloud
"fog1" = @(219,200,204); #day fog
"fog2" = @(125,114,116); #night fog
"rain" = @(124,185,232);
"lightning" = @(255,255,51);
"snow" = @(255,255,250);
"star" = @(255,250,112)
}

$ICONS = @{

"01d" = @"
$(Set-RGBText "   \  |  /   " $COLORS["ray"])
$(Set-RGBText "     .-.     " $COLORS["sun"])
$(Set-RGBText "--" $COLORS["ray"])$(Set-RGBText "  (   )  " $COLORS["sun"])$(Set-RGBText "--" $COLORS["ray"])
$(Set-RGBText "     ``'``   " $COLORS["sun"])
$(Set-RGBText "   /  |  \   " $COLORS["ray"])
	 
"@;

"01n" = @"

$(Set-RGBText "        *     " $COLORS["star"])
$(Set-RGBText "     .-.  " $COLORS["moon"])$(Set-RGBText "*   " $COLORS["star"])
$(Set-RGBText "    (``'.)    " $COLORS["moon"])
$(Set-RGBText "     ``'``     " $COLORS["moon"])
	  
"@;

"02d" = @"
$(Set-RGBText "        \  |  /   " $COLORS["ray"])
$(Set-RGBText "          .-.     " $COLORS["sun"])
$(Set-RGBText "     .--." $COLORS["cloudd"])$(Set-RGBText "(   )  " $COLORS["sun"])$(Set-RGBText "--" $COLORS["ray"])
$(Set-RGBText "  .-(    )." $COLORS["cloudd"])$(Set-RGBText "'``" $COLORS["sun"])
$(Set-RGBText "((___.__)__)" $COLORS['cloudd'])$(Set-RGBText "  \" $COLORS["ray"])
 
"@;

"02n" = @"

$(Set-RGBText "          .-.  " $COLORS["moon"])
$(Set-RGBText "     .--." $COLORS["cloudn"])$(Set-RGBText "(``'.)" $COLORS["moon"])
$(Set-RGBText "  .-(    )." $COLORS["cloudn"])$(Set-RGBText "'``" $COLORS["moon"])
$(Set-RGBText "((___.__)__)" $COLORS['cloudn'])
 
"@;

"03d" = @"

$(Set-RGBText "       .--." $COLORS["fog1"])
$(Set-RGBText "    .-(    )." $COLORS["fog1"])
$(Set-RGBText "  ((___.__)__)" $COLORS['fog1'])


"@;

"03n" = @"

$(Set-RGBText "       .--." $COLORS["fog2"])
$(Set-RGBText "    .-(    )." $COLORS["fog2"])
$(Set-RGBText "  ((___.__)__)" $COLORS['fog2'])

   
"@;

"04d" = @"
$(Set-RGBText "               .--." $COLORS["fog2"])
$(Set-RGBText "     .--." $COLORS["fog1"])$(Set-RGBText "   .-(    )." $COLORS["fog2"])
$(Set-RGBText "  .-(    )." $COLORS["fog1"])$(Set-RGBText "((__.__)__)" $COLORS["fog2"])
$(Set-RGBText "((___.__)__)" $COLORS['fog1'])
 
"@;

"04n" = @"
$(Set-RGBText "               .--." $COLORS["fog2"])
$(Set-RGBText "     .--." $COLORS["fog2"])$(Set-RGBText "   .-(    )." $COLORS["fog2"])
$(Set-RGBText "  .-(    )." $COLORS["fog2"])$(Set-RGBText "((__.__)__)" $COLORS["fog2"])
$(Set-RGBText "((___.__)__)" $COLORS['fog2'])
 
"@;

"09d" = @"
$(Set-RGBText "               .--." $COLORS["fog2"])
$(Set-RGBText "     .--." $COLORS["fog1"])$(Set-RGBText "   .-(    )." $COLORS["fog2"])
$(Set-RGBText "  .-(    )." $COLORS["fog1"])$(Set-RGBText "((__.__)__)" $COLORS["fog2"])
$(Set-RGBText "((___.__)__)" $COLORS["fog1"])$(Set-RGBText " \  \  \" $COLORS["rain"])
$(Set-RGBText "   \  \  \  " $COLORS["rain"])
"@;

"09n" = @"
$(Set-RGBText "               .--." $COLORS["fog2"])
$(Set-RGBText "     .--." $COLORS["fog2"])$(Set-RGBText "   .-(    )." $COLORS["fog2"])
$(Set-RGBText "  .-(    )." $COLORS["fog2"])$(Set-RGBText "((__.__)__)" $COLORS["fog2"])
$(Set-RGBText "((___.__)__)" $COLORS["fog2"])$(Set-RGBText " \  \  \" $COLORS["rain"])
$(Set-RGBText "   \  \  \  " $COLORS["rain"])
"@;

"10d" = @"
$(Set-RGBText "        \  |  /   " $COLORS["ray"])
$(Set-RGBText "          .-.     " $COLORS["sun"])
$(Set-RGBText "     .--." $COLORS["cloudd"])$(Set-RGBText "(   )  " $COLORS["sun"])$(Set-RGBText "--" $COLORS["ray"])
$(Set-RGBText "  .-(    )." $COLORS["cloudd"])$(Set-RGBText "'``" $COLORS["sun"])
$(Set-RGBText "((___.__)__)" $COLORS['cloudd'])$(Set-RGBText "  \" $COLORS["ray"])
$(Set-RGBText "   \  \  \  " $COLORS["rain"])
"@;

"10n" = @"

$(Set-RGBText "          .-.  " $COLORS["moon"])
$(Set-RGBText "     .--." $COLORS["cloudn"])$(Set-RGBText "(``'.)" $COLORS["moon"])
$(Set-RGBText "  .-(    )." $COLORS["cloudn"])$(Set-RGBText "'``" $COLORS["moon"])
$(Set-RGBText "((___.__)__)" $COLORS['cloudn'])
$(Set-RGBText "   \  \  \  " $COLORS["rain"])
"@;

"11d" = @"
$(Set-RGBText "               .--." $COLORS["fog2"])
$(Set-RGBText "     .--." $COLORS["fog1"])$(Set-RGBText "   .-(    )." $COLORS["fog2"])
$(Set-RGBText "  .-(    )." $COLORS["fog1"])$(Set-RGBText "((__.__)__)" $COLORS["fog2"])
$(Set-RGBText "((___.__)__)" $COLORS["fog1"])$(Set-RGBText " _/   _/   " $COLORS["lightning"])
$(Set-RGBText "  _/   _/   " $COLORS["lightning"])$(Set-RGBText "/    /   " $COLORS["lightning"])
$(Set-RGBText " /    /   " $COLORS["lightning"])
"@;

"11n" = @"
$(Set-RGBText "               .--." $COLORS["fog2"])
$(Set-RGBText "     .--." $COLORS["fog2"])$(Set-RGBText "   .-(    )." $COLORS["fog2"])
$(Set-RGBText "  .-(    )." $COLORS["fog2"])$(Set-RGBText "((__.__)__)" $COLORS["fog2"])
$(Set-RGBText "((___.__)__)" $COLORS["fog2"])$(Set-RGBText " _/   _/   " $COLORS["lightning"])
$(Set-RGBText "  _/   _/   " $COLORS["lightning"])$(Set-RGBText "/    /   " $COLORS["lightning"])
$(Set-RGBText " /    /   " $COLORS["lightning"])
"@;

"13d" = @"
$(Set-RGBText "               .--." $COLORS["fog2"])
$(Set-RGBText "     .--." $COLORS["fog1"])$(Set-RGBText "   .-(    )." $COLORS["fog2"])
$(Set-RGBText "  .-(    )." $COLORS["fog1"])$(Set-RGBText "((__.__)__)" $COLORS["fog2"])
$(Set-RGBText "((___.__)__)" $COLORS["fog1"])$(Set-RGBText " *  *  *" $COLORS["snow"])
$(Set-RGBText "   *  *  *    *  *  *" $COLORS["snow"])
$(Set-RGBText "    *  *  * " $COLORS["snow"])
"@;

"13n" = @"
$(Set-RGBText "               .--." $COLORS["fog2"])
$(Set-RGBText "     .--." $COLORS["fog2"])$(Set-RGBText "   .-(    )." $COLORS["fog2"])
$(Set-RGBText "  .-(    )." $COLORS["fog2"])$(Set-RGBText "((__.__)__)" $COLORS["fog2"])
$(Set-RGBText "((___.__)__)" $COLORS["fog2"])$(Set-RGBText " *  *  *" $COLORS["snow"])
$(Set-RGBText "   *  *  *    *  *  *" $COLORS["snow"])
$(Set-RGBText "    *  *  * " $COLORS["snow"])
"@;

"50d" = @"

$(Set-RGBText "  ~~~~~~~~~~~~~~" $COLORS["fog1"])
$(Set-RGBText "   ~~~~~~~~~~~~~~" $COLORS["fog2"])
$(Set-RGBText "  ~~~~~~~~~~~~~~" $COLORS["fog1"])
$(Set-RGBText "   ~~~~~~~~~~~~~~" $COLORS["fog2"])
	
"@;

"50n" = @"

$(Set-RGBText "  ~~~~~~~~~~~~~~" $COLORS["fog2"])
$(Set-RGBText "   ~~~~~~~~~~~~~~" $COLORS["fog2"])
$(Set-RGBText "  ~~~~~~~~~~~~~~" $COLORS["fog2"])
$(Set-RGBText "   ~~~~~~~~~~~~~~" $COLORS["fog2"])

"@
}


function Get-WeatherIcon
{
	param
	(
		[string]$IconID
	)
	return $ICONS[$IconID]
}