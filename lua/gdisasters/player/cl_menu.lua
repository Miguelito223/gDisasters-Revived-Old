
-- SV MENU 
gDisasters_gDisastersSetupTime = CurTime()

local function AddControlCB(CPanel, label, command)
	return CPanel:CheckBox( label, command )
end
local function AddControlLabel( CPanel, label )
	return  CPanel:Help( label )
end
	
local function CreateTickboxConVariable(CPanel, desc, convarname)
	local CB = AddControlCB(CPanel, desc, convarname)
	
 
	CB.OnChange = function( panel, bVal ) 
	if (CurTime() - gDisasters_gDisastersSetupTime) < 1 then return end 

		if( (LocalPlayer():IsAdmin() or LocalPlayer():IsSuperAdmin() )and !Created ) then
			if( ( bVal and 1 or 0 ) == cvars.Number( convarname ) ) then return end
			net.Start( "gdisasters_clmenu_vars" );
				net.WriteString( convarname );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end
	timer.Simple(0.1, function()
	
		if( CB ) then
			CB:SetValue( GetConVar(( convarname )):GetFloat() );
		end
	end)
	
	return CB 
	
end


	
local function CreateSliderConVariable(CPanel, desc, minvar, maxvar, dp, convarname)
	local CB = CPanel:NumSlider(    desc, "", minvar, maxvar, dp );
	
 	CB.Scratch.ConVarChanged = function() end	
	CB.OnValueChanged = function( panel, val )
		if (CurTime() - gDisasters_gDisastersSetupTime) < 1 then return end 
		
		
		if( (LocalPlayer():IsAdmin() or LocalPlayer():IsSuperAdmin() )and !Created ) then
			if ( tonumber(val) ) == cvars.Number( convarname )  then return end
			net.Start( "gdisasters_clmenu_vars" );
				net.WriteString( convarname );
				net.WriteFloat(tonumber(val) );
			net.SendToServer();
		end
		
	end
		

 
	--[[timer.Simple(0.1, function()
		
		if( CB ) then
			CB:SetValue( GetConVar(( convarname )):GetFloat() );
		end
	end)
	
	return CB --]]
	
end

local function gDisastersSVSettings( CPanel )

	CreateTickboxConVariable(CPanel, "Enable Water Related Damage"  , "gdisasters_envdynamicwater_candamageconstraints");
	CreateTickboxConVariable(CPanel, "Enable Tornado Related Damage" ,"gdisasters_envtornado_candamageconstraints");
	CreateTickboxConVariable(CPanel, "Enable Custom Tornado Speed" ,"gdisasters_envtornado_manualspeed");
	CreateTickboxConVariable(CPanel, "Enable Atmosphere"  , "gdisasters_atmosphere");
	CreateTickboxConVariable(CPanel, "Disable Map Tornadoes"  , "gdisasters_getridmaptor");
	CreateTickboxConVariable(CPanel, "Enable Autospawn"  , "gdisasters_autospawn");
	CreateTickboxConVariable(CPanel, "Enable Hud"  , "gdisasters_hud_enabled");
	CreateTickboxConVariable(CPanel, "Enable Day And Night Cycle"  , "gdisasters_dnc_enable");

	
	SVMenuCreated = false;

	AddControlLabel( CPanel, "The day and night cycle requires a map RESTART to take effect." )

end

-- ADVANCED SV MENU
local function gDisastersSVADVSettings( CPanel )

	CreateSliderConVariable(CPanel, "Tornado Simulation Quality", 0.10, 0.50, 2, "gdisasters_envtornado_simquality" );
	CreateSliderConVariable(CPanel, "Earthquake Simulation Quality", 0.10, 0.50, 2, "gdisasters_envearthquake_simquality" );
	CreateSliderConVariable(CPanel,"Water Simulation Quality", 0.10, 0.50, 2, "gdisasters_envdynamicwater_simquality");
	CreateSliderConVariable(CPanel,"Wind Simulation Quality", 0.10, 0.50, 2, "gdisasters_wind_physics_simquality")
	CreateSliderConVariable(CPanel, "Tornado Speed", 2, 20, 2, "gdisasters_envtornado_speed" );
	CreateSliderConVariable(CPanel, "Hud Type", 1, 3, 0, "gdisasters_hud_type" );
	CreateSliderConVariable(CPanel,"Max CPPPS ", 0, 1000, 0,"gdisasters_antilag_maximum_safe_collisions_per_second_per_prop");
	CreateSliderConVariable(CPanel,"Max CAPS (s) ", 0, 1000, 0,"gdisasters_antilag_maximum_safe_collisions_per_second_average" );
	CreateSliderConVariable(CPanel,"Antilag Mode (s) ", 0, 2, 0,"gdisasters_antilag_mode" );
	
	AddControlLabel( CPanel, "Don't mess with these settings unless you know what you're doing .\n\nAbbreviation references below.\n\nPD NC BT: Post Damage No Collide Base Time\n\nCPPPS: Collisions Per Prop Per Second\n\nCAPS:Collisions Average Per Second" )
	-----------------
	
end

local function gDisastersGraphicsSettings( CPanel )

end


local function gDisastersAudioSettings( CPanel )
	CreateSliderConVariable(CPanel, "Light Wind Volume", 0,1, "" );
	CreateSliderConVariable(CPanel, "Moderate Wind Volume", 0,1, "" );
	CreateSliderConVariable(CPanel, "Heavy Wind Volume", 0,1, "" );
end



local function gDisastersADVGraphicsSettings( CPanel )

	gDisasters_gDisastersADVGraphicsSettings_SetupTime = CurTime() 

		
	local function AddControlCB(CPanel, label, command)
		return CPanel:CheckBox( label, command )
	end
	local function AddControlLabel( CPanel, label )
	
		return  CPanel:Help( label )
	end
	
	function AddComboBox( CPanel, title, listofitems, convar)
		
		local combobox, label = CPanel:ComboBox( title, convar)
		
		
		for k, item in pairs(listofitems) do
			combobox:AddChoice(item)
		end
		
		return combobox
	end
			
		
	

	local WQ = CPanel:NumSlider(     "Water Quality", "", 1, 3, 0 );

	local dr_ns_label =  AddControlLabel( CPanel, "Section dedicated to Doppler Radar.\nUse with caution." )

	local ScreenRes     = AddComboBox( CPanel, "Resolution", {"4x4","8x8","16x16","32x32","64x64","48x48","128x128"}, "gdisasters_graphics_dr_resolution")
	local Monochromatic = AddComboBox( CPanel, "Monochromatic Mode", {"false", "true"}, "gdisasters_graphics_dr_monochromatic")
	local HudW 			= AddComboBox( CPanel, "Hud Wind Display", {"km/h", "mph"}, "gdisasters_hud_windtype")
	local HudT			= AddComboBox( CPanel, "Hud Temperature Display", {"c", "f"}, "gdisasters_hud_temptype")
	local MaxRD         = CPanel:NumSlider(     "Max Render Distance", "", 1, 600, 0 );
	local RefreshRate   = CPanel:NumSlider(     "Refresh Rate (Hz)", "", 1, 16, 0 );
	local UpdateRate   = CPanel:NumSlider(     "Update  Rate (Hz)", "", 1, 16, 0 );
	
	local GP = CPanel:NumSlider( "Max GP", "", 1, 1000, 0 );
	local WP = CPanel:NumSlider( "Max WP", "", 1, 1000, 0 );
	local nPass = CPanel:NumSlider( "Max nPass", "", 1, 1000, 0 );

	local label =  AddControlLabel( CPanel, "Please don't touch these settings unless you what you're doing.\n\nAbbreviation references below.\n\nGP: Ground Particles\n\nWP:Weather Particles\n\nnPass: Number of Passes " )
	
		
	-- on value change, set values 

	MaxRD.Scratch.ConVarChanged = function() end 
	MaxRD.OnValueChanged = function( panel, val)
		if (CurTime() - gDisasters_gDisastersADVGraphicsSettings_SetupTime) < 1 then return end 
		RunConsoleCommand( "gdisasters_graphics_dr_maxrenderdistance", tonumber( val))
	end
	
	UpdateRate.Scratch.ConVarChanged = function() end 
	UpdateRate.OnValueChanged = function( panel, val)
		if (CurTime() - gDisasters_gDisastersADVGraphicsSettings_SetupTime) < 1 then return end 
		RunConsoleCommand( "gdisasters_graphics_dr_updaterate", tonumber( val))
	end
	
	RefreshRate.Scratch.ConVarChanged = function() end 
	RefreshRate.OnValueChanged = function( panel, val)
		if (CurTime() - gDisasters_gDisastersADVGraphicsSettings_SetupTime) < 1 then return end 
		RunConsoleCommand( "gdisasters_graphics_dr_refreshrate", tonumber( val))
	end
		
	
	WQ.Scratch.ConVarChanged = function() end
	WQ.OnValueChanged = function( panel, val )
		if (CurTime() - gDisasters_gDisastersADVGraphicsSettings_SetupTime) < 1 then return end 
		RunConsoleCommand( "gdisasters_graphics_water_quality", 4 - tonumber( val ) )		
	end
	
	GP.Scratch.ConVarChanged = function() end 
	GP.OnValueChanged = function( panel, val)
		if (CurTime() - gDisasters_gDisastersADVGraphicsSettings_SetupTime) < 1 then return end 
		RunConsoleCommand( "gdisasters_antilag_ground_particles", tonumber( val))
	end

	WP.Scratch.ConVarChanged = function() end 
	WP.OnValueChanged = function( panel, val)
		if (CurTime() - gDisasters_gDisastersADVGraphicsSettings_SetupTime) < 1 then return end 
		RunConsoleCommand( "gdisasters_antilag_weather_particles", tonumber( val))
	end
	
	nPass.Scratch.ConVarChanged = function() end 
	nPass.OnValueChanged = function( panel, val)
		if (CurTime() - gDisasters_gDisastersADVGraphicsSettings_SetupTime) < 1 then return end 
		RunConsoleCommand( "gdisasters_antilag_number_of_passes", tonumber( val))
	end
	
	-- on panel setup, this will set the values for sliders and buttons to their original stored values 
	
	
	timer.Simple(0.05, function()
	
		if WQ then WQ:SetValue(GetConVar(( "gdisasters_graphics_water_quality" )):GetFloat()) end 
		
		if MaxRD then MaxRD:SetValue(GetConVar(( "gdisasters_graphics_dr_maxrenderdistance" )):GetFloat()) end 
		if UpdateRate then UpdateRate:SetValue(GetConVar(( "gdisasters_graphics_dr_updaterate" )):GetFloat()) end 
		if RefreshRate then RefreshRate:SetValue(GetConVar(( "gdisasters_graphics_dr_refreshrate" )):GetFloat()) end 
		
		if GP then GP:SetValue(GetConVar(( "gdisasters_antilag_ground_particles" )):GetFloat()) end
		if WP then WP:SetValue(GetConVar(( "gdisasters_antilag_weather_particles" )):GetFloat()) end
		if nPass then nPass:SetValue(GetConVar(( "gdisasters_antilag_number_of_passes" )):GetFloat()) end
	
	end)
	
end


hook.Add( "PopulateToolMenu", "gDisasters_PopulateMenu", function()

	spawnmenu.AddToolMenuOption( "gDisasters", "Server", "gDisastersSVADSettings", "Advanced", "", "", gDisastersSVADVSettings )
	spawnmenu.AddToolMenuOption( "gDisasters", "Server", "gDisastersSVSettings", "Main", "", "", gDisastersSVSettings )
	spawnmenu.AddToolMenuOption( "gDisasters", "Client", "gDisastersADVGraphicsSettings", "Advanced Graphics", "", "", gDisastersADVGraphicsSettings )


end );


