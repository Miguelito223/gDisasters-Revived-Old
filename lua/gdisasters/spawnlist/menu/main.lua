if !CLIENT then return end 


spawnmenu.AddCreationTab("gDisasters Mesea Edition", function()

	local ctrl = vgui.Create("SpawnmenuContentPanel")
	ctrl:CallPopulateHook("PopulategDisasters_Disasters")
	ctrl:CallPopulateHook("PopulategDisasters_Weather")
	ctrl:CallPopulateHook("PopulategDisasters_Buildings")
	ctrl:CallPopulateHook("PopulategDisasters_Weapons")
	ctrl:CallPopulateHook("PopulategDisasters_Equipment")
	return ctrl
	end,
	"icons/gdlogo.png", 60
)


function AddToGDSpawnMenu(name, class, category, subcategory, adminonly)

	-- available parent categories 
	-- Disasters, Weather, Weapons, Buildings, Misc
	if category == "Disasters" then 
	
		list.Set( "gDisasters_Disasters", class, {Name = name, Class = class, Category = subcategory, AdminOnly = adminonly, Offset = 0})
	elseif category == "Weather" then 
		list.Set( "gDisasters_Weather", class, {Name = name, Class = class, Category = subcategory, AdminOnly = adminonly, Offset = 0})
	elseif category == "Weapons" then 
		list.Set( "gDisasters_Weapons", class, {Name = name, Class = class, Category = subcategory, AdminOnly = adminonly, Offset = 0})
	elseif category == "Buildings" then
		list.Set( "gDisasters_Buildings", class, {Name = name, Class = class, Category = subcategory, AdminOnly = adminonly, Offset = 0})
	elseif category == "Equipment" then
		list.Set( "gDisasters_Equipment", class, {Name = name, Class = class, Category = subcategory, AdminOnly = adminonly, Offset = 0})
	end

end



hook.Add( "PopulategDisasters_Weapons", "AddWeaponsContent", function( pnlContent, tree, node )

	local dtree = tree:AddNode("Weapons & Ammo (DOESN'T WORK)", "icons/weapons.png")
	dtree.PropPanel = vgui.Create("ContentContainer", pnlContent)
	dtree.PropPanel:SetVisible(false)
	dtree.PropPanel:SetTriggerSpawnlistChange(false)

	function dtree:DoClick()
		--pnlContent:SwitchPanel(self.PropPanel)
	end

	local EntityCategories = {}
	local SpawnableEntitiesList = list.Get("gDisasters_Weapons")
	if (SpawnableEntitiesList) then
		for k, v in pairs(SpawnableEntitiesList) do

			EntityCategories[v.Category] = EntityCategories[v.Category] or {}
			table.insert(EntityCategories[v.Category], v)
		end
	end
	for CategoryName, v in SortedPairs(EntityCategories) do
	
		local node = dtree:AddNode(CategoryName, "icons/weapons.png")
		
		
		node.DoPopulate = function( self )
	
			if ( self.PropPanel ) then return end

			self.PropPanel = vgui.Create( "ContentContainer", pnlContent )
			self.PropPanel:SetVisible( false )
			self.PropPanel:SetTriggerSpawnlistChange( false )

			for name, ent in SortedPairsByMemberValue( v, "PrintName" ) do
				
				spawnmenu.CreateContentIcon( "entity", self.PropPanel, 
				{ 
					nicename	= ent.PrintName or ent.Name,
					spawnname	= ent.Class,
					material	= "entities/"..ent.Class..".png",
					admin		= ent.AdminOnly or false
				})
				
			end

		end

		node.DoClick = function( self )
	
			self:DoPopulate()		
			pnlContent:SwitchPanel( self.PropPanel )
	
		end
		

		
	end



end )


hook.Add( "PopulategDisasters_Equipment", "AddEquipmentContent", function( pnlContent, tree, node )

	local dtree = tree:AddNode("Equipment", "icons/equipment.png")
	dtree.PropPanel = vgui.Create("ContentContainer", pnlContent)
	dtree.PropPanel:SetVisible(false)
	dtree.PropPanel:SetTriggerSpawnlistChange(false)

	function dtree:DoClick()
		--pnlContent:SwitchPanel(self.PropPanel)
	end

	local EntityCategories = {}
	local SpawnableEntitiesList = list.Get("gDisasters_Equipment")
	if (SpawnableEntitiesList) then
		for k, v in pairs(SpawnableEntitiesList) do

			EntityCategories[v.Category] = EntityCategories[v.Category] or {}
			table.insert(EntityCategories[v.Category], v)
		end
	end
	for CategoryName, v in SortedPairs(EntityCategories) do
	
		local node = dtree:AddNode(CategoryName, "icons/equipment.png")
		
		
		node.DoPopulate = function( self )
	
			if ( self.PropPanel ) then return end

			self.PropPanel = vgui.Create( "ContentContainer", pnlContent )
			self.PropPanel:SetVisible( false )
			self.PropPanel:SetTriggerSpawnlistChange( false )

			for name, ent in SortedPairsByMemberValue( v, "PrintName" ) do
				
				spawnmenu.CreateContentIcon( "entity", self.PropPanel, 
				{ 
					nicename	= ent.PrintName or ent.Name,
					spawnname	= ent.Class,
					material	= "entities/"..ent.Class..".png",
					admin		= ent.AdminOnly or false
				})
				
			end

		end

		node.DoClick = function( self )
	
			self:DoPopulate()		
			pnlContent:SwitchPanel( self.PropPanel )
	
		end
		

		
	end



end )
hook.Add( "PopulategDisasters_Disasters", "AddDisastersContent", function( pnlContent, tree, node )

	local dtree = tree:AddNode("Disasters", "icons/disasters.png")
	dtree.PropPanel = vgui.Create("ContentContainer", pnlContent)
	dtree.PropPanel:SetVisible(false)
	dtree.PropPanel:SetTriggerSpawnlistChange(false)

	function dtree:DoClick()
		--pnlContent:SwitchPanel(self.PropPanel)
	end

	local EntityCategories = {}
	local SpawnableEntitiesList = list.Get("gDisasters_Disasters")
	if (SpawnableEntitiesList) then
		for k, v in pairs(SpawnableEntitiesList) do

			EntityCategories[v.Category] = EntityCategories[v.Category] or {}
			table.insert(EntityCategories[v.Category], v)
		end
	end
	for CategoryName, v in SortedPairs(EntityCategories) do
	
		local node = dtree:AddNode(CategoryName, "icons/disasters.png")
		
		
		node.DoPopulate = function( self )
	
			if ( self.PropPanel ) then return end

			self.PropPanel = vgui.Create( "ContentContainer", pnlContent )
			self.PropPanel:SetVisible( false )
			self.PropPanel:SetTriggerSpawnlistChange( false )

			for name, ent in SortedPairsByMemberValue( v, "PrintName" ) do
				
				spawnmenu.CreateContentIcon( "entity", self.PropPanel, 
				{ 
					nicename	= ent.PrintName or ent.Name,
					spawnname	= ent.Class,
					material	= "entities/"..ent.Class..".png",
					admin		= ent.AdminOnly or false
				})
				
			end

		end

		node.DoClick = function( self )
	
			self:DoPopulate()		
			pnlContent:SwitchPanel( self.PropPanel )
	
		end
		

		
	end



end )


hook.Add( "PopulategDisasters_Buildings", "AddBuildingsContent", function( pnlContent, tree, node )

	local dtree = tree:AddNode("Buildings", "icons/buildings.png")
	dtree.PropPanel = vgui.Create("ContentContainer", pnlContent)
	dtree.PropPanel:SetVisible(false)
	dtree.PropPanel:SetTriggerSpawnlistChange(false)

	function dtree:DoClick()
		--pnlContent:SwitchPanel(self.PropPanel)
	end

	local EntityCategories = {}
	local SpawnableEntitiesList = list.Get("gDisasters_Buildings")
	if (SpawnableEntitiesList) then
		for k, v in pairs(SpawnableEntitiesList) do

			EntityCategories[v.Category] = EntityCategories[v.Category] or {}
			table.insert(EntityCategories[v.Category], v)
		end
	end
	for CategoryName, v in SortedPairs(EntityCategories) do
	
		local node = dtree:AddNode(CategoryName, "icons/buildings.png")
		
		
		node.DoPopulate = function( self )
	
			if ( self.PropPanel ) then return end

			self.PropPanel = vgui.Create( "ContentContainer", pnlContent )
			self.PropPanel:SetVisible( false )
			self.PropPanel:SetTriggerSpawnlistChange( false )

			for name, ent in SortedPairsByMemberValue( v, "PrintName" ) do
				
				spawnmenu.CreateContentIcon( "entity", self.PropPanel, 
				{ 
					nicename	= ent.PrintName or ent.Name,
					spawnname	= ent.Class,
					material	= "entities/"..ent.Class..".png",
					admin		= ent.AdminOnly or false
				})
				
			end

		end

		node.DoClick = function( self )
	
			self:DoPopulate()		
			pnlContent:SwitchPanel( self.PropPanel )
	
		end
		

		
	end



end )

hook.Add( "PopulategDisasters_Weather", "AddWeatherContent", function( pnlContent, tree, node )

	local dtree = tree:AddNode("Weather", "icons/weather.png")
	dtree.PropPanel = vgui.Create("ContentContainer", pnlContent)
	dtree.PropPanel:SetVisible(false)
	dtree.PropPanel:SetTriggerSpawnlistChange(false)

	function dtree:DoClick()
		--pnlContent:SwitchPanel(self.PropPanel)
	end

	local EntityCategories = {}
	local SpawnableEntitiesList = list.Get("gDisasters_Weather")
	if (SpawnableEntitiesList) then
		for k, v in pairs(SpawnableEntitiesList) do

			EntityCategories[v.Category] = EntityCategories[v.Category] or {}
			table.insert(EntityCategories[v.Category], v)
		end
	end
	for CategoryName, v in SortedPairs(EntityCategories) do
	
		local node = dtree:AddNode(CategoryName, "icons/weather.png")
		
		
		node.DoPopulate = function( self )
	
			if ( self.PropPanel ) then return end

			self.PropPanel = vgui.Create( "ContentContainer", pnlContent )
			self.PropPanel:SetVisible( false )
			self.PropPanel:SetTriggerSpawnlistChange( false )

			for name, ent in SortedPairsByMemberValue( v, "PrintName" ) do
				
				spawnmenu.CreateContentIcon( "entity", self.PropPanel, 
				{ 
					nicename	= ent.PrintName or ent.Name,
					spawnname	= ent.Class,
					material	= "entities/"..ent.Class..".png",
					admin		= ent.AdminOnly or false
				})
				
			end

		end

		node.DoClick = function( self )
	
			self:DoPopulate()		
			pnlContent:SwitchPanel( self.PropPanel )
	
		end
		

		
	end



end )
