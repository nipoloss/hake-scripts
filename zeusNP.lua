local zeusNP = {}

zeusNP.optionEnable = Menu.AddOption({"Hero Specific","Zeus by NP"},"Enabled","")
zeusNP.optionKey = Menu.AddKeyOption({"Hero Specific","Zeus by NP"},"Combo Key",Enum.ButtonCode.KEY_SPACE)
zeusNP.optionEnableVeil = Menu.AddOption({ "Hero Specific","Zeus by NP","Toggle Items"},"Use Veil Of Discord","")
zeusNP.optionEnableHex = Menu.AddOption({ "Hero Specific","Zeus by NP","Toggle Items"},"Use Scythe Of Vyse","")
zeusNP.optionEnableBloth = Menu.AddOption({ "Hero Specific","Zeus by NP","Toggle Items"},"Use Bloodthorn","")
zeusNP.optionEnableEblade = Menu.AddOption({ "Hero Specific","Zeus by NP","Toggle Items"},"Use Ethereal Blade","")
zeusNP.optionEnableOrchid = Menu.AddOption({ "Hero Specific","Zeusby np","Toggle Items"},"Use Orchid Malevolence","")
zeusNP.optionEnableRefresher = Menu.AddOption({ "Hero Specific","Zeus by NP","Toggle Items"},"Use Refresher Orb","")
zeusNP.optionEnableRoA = Menu.AddOption({ "Hero Specific","Zeus by NP","Toggle Items"},"Use Rod Of Atos","")
zeusNP.optionEnableSring = Menu.AddOption({ "Hero Specific","Zeus by NP","Toggle Items"},"Use Soul Ring","")
zeusNP.optionEnableSguard = Menu.AddOption({ "Hero Specific","Zeus by NP","Toggle Items"},"Use Shivas Guard","")
zeusNP.optionEnableDagon = Menu.AddOption({ "Hero Specific","Zeus by NP","Toggle Items"},"Use Dagon","")
zeusNP.optionEnableArcBolt = Menu.AddOption({ "Hero Specific","Zeus by NP","Toggle Abilities"},"Use Arc Lightning","")
zeusNP.optionEnableConShot = Menu.AddOption({ "Hero Specific","Zeus by NP","Toggle Abilities"},"Use Lightning Bolt","")
zeusNP.optionEnableLinkens1 = Menu.AddOption({ "Hero Specific","Zeus by NP","Linkens Breaker"},"Break With Arc Lightning","")
zeusNP.optionEnableLinkens2 = Menu.AddOption({ "Hero Specific","Zeus by NP","Linkens Breaker"},"Break With Lightning Bolt","")
zeusNP.optionEnableLinkens3 = Menu.AddOption({ "Hero Specific","Zeus by NP","Linkens Breaker"},"Break With Force Staff","")
zeusNP.optionEnableLinkens4 = Menu.AddOption({ "Hero Specific","Zeus by NP","Linkens Breaker"},"Break With Hurricane Pike","")
zeusNP.optionEnableBmail = Menu.AddOption({"Hero Specific","Zeus by NP"},"Stop Combo When Blademail Activated","")
zeusNP.optionEnableLorb = Menu.AddOption({"Hero Specific","Zeus by NP"},"Stop Combo When Lotus Orb Activated","")

function zeusNP.OnUpdate()
    if not Menu.IsEnabled(zeusNP.optionEnable) then return true end
    zeusNP.ITABcombo()
end

function zeusNP.ITABcombo()
    if not Menu.IsKeyDown(zeusNP.optionKey) then return end

    local myHero = Heroes.GetLocal()
    local hero = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
    if NPC.GetUnitName(myHero) ~= "npc_dota_hero_zeus" then return end
    if not hero then return end

    local arcLight = NPC.GetAbilityByIndex(myHero, 0)
    local lightBolt = NPC.GetAbilityByIndex(myHero, 1)

    local veil = NPC.GetItem(myHero, "item_veil_of_discord", true)
    local hex = NPC.GetItem(myHero, "item_sheepstick", true)
    local bloth = NPC.GetItem(myHero, "item_bloodthorn", true)
    local eblade = NPC.GetItem(myHero, "item_ethereal_blade", true)
    local orchid = NPC.GetItem(myHero, "item_orchid", true)
    local refresh = NPC.GetItem(myHero, "item_refresher", true)
    local RoA = NPC.GetItem(myHero, "item_rod_of_atos", true)
    local Sguard = NPC.GetItem(myHero, "item_shivas_guard", true)
    local Sring = NPC.GetItem(myHero, "item_soul_ring", true)
    local Fstaff = NPC.GetItem(myHero, "item_force_staff", true)
    local BladeM = NPC.GetItem(myHero, "item_blade_mail", true)
    local Hstaff = NPC.GetItem(myHero, "item_hurricane_pike", true)
    for i = 0, 5 do
    local dagon = NPC.GetItem(myHero, "item_dagon_" .. i, true)
    if i == 0 then dagon = NPC.GetItem(myHero, "item_dagon", true) end

    local myMana = NPC.GetMana(myHero)
    local mousePos = Input.GetWorldCursorPos()
    local heroPos = Entity.GetAbsOrigin(hero)
    local heroAng = Entity.GetAbsRotation(hero)
    local heroMs = NPC.GetMoveSpeed(hero)
    local myPos = Entity.GetAbsOrigin(myHero)

    if NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then return true end

    if Menu.IsEnabled(zeusNP.optionEnableLorb) and NPC.HasModifier(hero, "modifier_item_lotus_orb_active") then return true end
    if Menu.IsEnabled(zeusNP.optionEnableBmail) and NPC.HasModifier(hero, "modifier_item_blade_mail_reflect") then return true end

    if Menu.IsEnabled(zeusNP.optionEnableLinkens1) and arcLight and Ability.IsCastable(arcLight, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(arcLight) - 10) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(arcLight, hero); return end
    if Menu.IsEnabled(zeusNP.optionEnableLinkens2) and lightBolt and Ability.IsCastable(lightBolt, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(lightBolt) - 10) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(lightBolt, hero); return end
    if Menu.IsEnabled(zeusNP.optionEnableLinkens3) and Fstaff and Ability.IsCastable(Fstaff, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(Fstaff) - 10) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(Fstaff, hero); return end
    if Menu.IsEnabled(zeusNP.optionEnableLinkens4) and Hstaff and Ability.IsCastable(Hstaff, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(Hstaff) - 10) and NPC.IsLinkensProtected(hero) then Ability.CastTarget(Hstaff, hero); return end

    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(zeusNP.optionEnableSring) and Sring and Ability.IsCastable(Sring, 0) then Ability.CastNoTarget(Sring); return end
    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(zeusNP.optionEnableAncSeal) and arcLight and Ability.IsCastable(arcLight, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(arcLight) - 10) then Ability.CastTarget(arcLight, hero); return end
    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(zeusNP.optionEnableVeil) and veil and Ability.IsCastable(veil, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(veil) - 10) then Ability.CastPosition(veil, heroPos); return end
    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(zeusNP.optionEnableSguard) and Sguard and Ability.IsCastable(Sguard, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(Sguard) - 10) then Ability.CastNoTarget(Sguard); return end
    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(zeusNP.optionEnableRoA) and RoA and Ability.IsCastable(RoA, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(RoA) - 10) then Ability.CastTarget(RoA, hero); return end
    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(zeusNP.optionEnableHex) and hex and Ability.IsCastable(hex, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(hex) - 10) then Ability.CastTarget(hex, hero); return end
    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(zeusNP.optionEnableBloth) and bloth and Ability.IsCastable(bloth, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(bloth) - 10) then Ability.CastTarget(bloth, hero); return end
    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(zeusNP.optionEnableEblade) and eblade and Ability.IsCastable(eblade, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(eblade) - 10) then Ability.CastTarget(eblade, hero); return end
    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(zeusNP.optionEnableDagon) and dagon and Ability.IsCastable(dagon, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(dagon) - 10) then  Ability.CastTarget(dagon, hero) return end
    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(zeusNP.optionEnableOrchid) and orchid and Ability.IsCastable(orchid, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(orchid) - 10) then Ability.CastTarget(orchid, hero); return end
    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(zeusNP.optionEnableArcBolt) and lightBolt and Ability.IsCastable(lightBolt, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(lightBolt) - 10) then Ability.CastTarget(lightBolt, hero); return end
    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(zeusNP.optionEnableRefresher) and refresh and Ability.IsCastable(refresh, myMana) then Ability.CastNoTarget(refresh); return end end
end

return zeusNP