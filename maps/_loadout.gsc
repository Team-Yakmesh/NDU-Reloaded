#include maps\_utility;

init_loadout()
{
	// MikeD (7/30/2007): New method of precaching/giving weapons.
	// Set the level variables.
	if( !isDefined( level.player_loadout ) )
	{
		level.player_loadout = [];
	}

	// CODER MOD
	// With the player joining later now we need to precache all weapons for the level
	init_models_and_variables_loadout();

	players = get_players();
	for ( i = 0; i < players.size; i++ )
	{
		players[i] give_loadout();
		players[i].pers["class"] = "closequarters";
	}
	level.loadoutComplete = true;
	level notify("loadout complete");


	// these precaches should only happen per level and campaign

	if (level.campaign == "russian")
	{
		if (level.script == "ber2")
		{
			mptype\player_rus_guard_wet::precache();	
		}
		else if (level.script == "sniper")
		{
			// nothing!
		}
		else
		{
			mptype\player_rus_guard::precache();
		}
	}
	else if (level.campaign == "american")
	{
		if (level.script == "pel1")
		{
			mptype\player_usa_marine::precache();
		}
		else if (level.script == "pel1a" || level.script == "pel2")
		{
			mptype\player_usa_marine::precache();
		}
		else if (level.script == "oki2")
		{
			mptype\player_usa_marine_wet::precache();
		}
		else if( level.script == "mak")
		{
			mptype\player_usa_raider::precache();
		}	
		else if ( level.script == "pby_fly")
		{
			//nothing
		}
		else if( level.script == "nazi_zombie_sumpf" || level.script == "nazi_zombie_asylum" || level.script == "nazi_zombie_factory" || level.script == "nazi_zombie_prototype" )
		{

			mptype\nazi_zombie_heroes::precache();

		}
		else
		{
			mptype\player_usa_marine::precache();
		}
	}
	else
	{
		mptype\player_usa_marine::precache();
	}
}

init_models_and_variables_loadout()
{
	// SCRIPTER_MOD
	// MikeD (3/16/2007): Testmap for Coop
	if( level.script == "coop_test1" )
	{
		add_weapon( "m1garand" );
		add_weapon( "thompson" );
		add_weapon( "fraggrenade" );
		set_switch_weapon( "m1garand" );

		set_player_viewmodel( "viewmodel_usa_marine_arms");

		level.campaign = "american";
		return;
	}
	else if( level.script == "mak" ) // MikeD
	{
		add_weapon( "nambu" );
		set_switch_weapon( "nambu" );
		set_laststand_pistol( "nambu" );

		set_player_viewmodel( "viewmodel_usa_raider_arms" );
		set_player_interactive_hands( "viewmodel_usa_raider_player" );

		level.campaign = "american";		 
		return;
	}
	else if( level.script == "pel1" ) // Jesse
	{
		add_weapon( "colt");	
		add_weapon( "m1garand_bayonet" );	
		add_weapon( "fraggrenade" );
		add_weapon( "m8_white_smoke" );
		add_weapon( "rocket_barrage" );
		set_action_slot( 4, "weapon", "rocket_barrage" );
		set_secondary_offhand( "smoke" );

		set_laststand_pistol( "colt" );

		set_player_viewmodel( "viewmodel_usa_marine_arms");
		set_player_interactive_hands( "viewmodel_usa_marine_player" );

		// CODER MOD (Austin & Sumeet 11/3/07)
		// Fix bugs #1056 & #1057 with co-op players having no weapon selected
		set_switch_weapon( "m1garand_bayonet" );

		level.campaign = "american";
		return;
	}
	else if( level.script == "pel1a" ) // MikeD
	{
		add_weapon( "m1garand" );
		PrecacheItem( "m2_flamethrower" );
		//add_weapon( "m2_flamethrower" );
		add_weapon( "thompson" );
		//TFLAME - Bug about 3 weapons
		//add_weapon( "colt" );
		add_weapon( "fraggrenade" );
		add_weapon( "m8_white_smoke" );
		set_secondary_offhand( "smoke" );
		//		set_switch_weapon( "m2_flamethrower" );
		set_switch_weapon( "m1garand" );

		set_laststand_pistol( "colt" );

		set_player_viewmodel( "viewmodel_usa_marine_arms");
		set_player_interactive_hands( "viewmodel_usa_marine_player" );

		level.campaign = "american";
		return;
	}
	else if( level.script == "pel1b" )
	{
		// TODO add level-specific weapons
		add_weapon( "shotgun" );
		add_weapon( "30cal_bipod" );
		//add_weapon( "colt");
		add_weapon( "fraggrenade" );
		add_weapon( "m8_white_smoke" );
		set_secondary_offhand( "smoke" );
		set_switch_weapon( "30cal_bipod" );

		set_laststand_pistol( "colt" );

		set_player_viewmodel( "viewmodel_usa_marine_arms");
		set_player_interactive_hands( "viewmodel_usa_marine_player");

		level.campaign = "american";
		return;
	}
	else if (level.script == "pby_fly" ) // Gavin
	{
		//add_weapon( "pby_backgun" );
		//add_weapon( "pby_frontgun" );
		//add_weapon( "pby_rightgun" );
		//add_weapon( "pby_leftgun" );
		//set_action_slot( 1, "weapon", "pby_frontgun" );
		//set_action_slot( 4, "weapon", "pby_rightgun" );
		//set_action_slot( 2, "weapon", "pby_backgun" );
		//set_action_slot( 3, "weapon", "pby_leftgun" );

		set_laststand_pistol( "colt" ); // No revive while in the air!

		set_player_viewmodel( "viewmodel_usa_pbycrew_arms");

		level.campaign = "american";
		return;
	}
	else if( level.script == "pel2" ) // DPG (7/9/2007): Peleliu 2
	{
		add_weapon( "colt" );

		add_weapon( "bar" );
		add_weapon( "fraggrenade" );
		add_weapon( "m8_white_smoke" );
		set_secondary_offhand( "smoke" );

		set_switch_weapon( "bar" );

		set_laststand_pistol( "colt" );

		set_player_viewmodel( "viewmodel_usa_marine_arms");
		set_player_interactive_hands( "viewmodel_usa_marine_player" );

		level.campaign = "american";
		return;
	}
	else if( level.script == "see1" ) // Alex Liu
	{
		add_weapon( "mosin_rifle" );
		add_weapon( "tokarev" );
		// CODER_MOD: Austin (7/31/08): added stick grenade for russian campaign to replace smoke (BUG 17665)
		add_weapon( "stick_grenade" );
		add_weapon( "molotov" );
		PrecacheItem( "napalmblob" );
		PrecacheItem( "napalmbloblight" );
		set_secondary_offhand( "smoke" );
		set_switch_weapon( "mosin_rifle" );

		set_laststand_pistol( "tokarev" );

		set_player_viewmodel( "viewmodel_rus_guard_arms");

		level.campaign = "russian";
		return;
	}
	else if( level.script == "see2" ) // DPG (7/9/2007): Seelow 2
	{
		//add_weapon( "mosin_rifle" );
		add_weapon( "m2_flamethrower" );
		add_weapon( "ppsh" );
		add_weapon( "stick_grenade" );
		set_secondary_offhand( "smoke" );
		set_switch_weapon( "m2_flamethrower" );

		set_laststand_pistol( "none" ); // Players are in a tank

		// SRS 6/24/2008: don't need visible viewarms because you're in a tank

		level.campaign = "russian";
		return;
	}
	else if( level.script == "ber1" ) // Bloodlust (7/06/2007): Berlin 1
	{
		add_weapon( "tokarev" );	
		add_weapon( "mosin_rifle" );
		add_weapon( "stick_grenade" );
		//add_weapon( "m8_white_smoke" );
		add_weapon( "molotov" );
		set_secondary_offhand( "molotov" );
		set_switch_weapon( "mosin_rifle" );

		set_laststand_pistol( "tokarev" );

		set_player_viewmodel( "viewmodel_rus_guard_arms");

		level.campaign = "russian";
		return;
	}
	else if( level.script == "ber1_geo" ) // Bloodlust (10/22/2007): Berlin 1 Geo (for Brandon)
	{
		add_weapon( "mosin_rifle" );
		add_weapon( "ppsh" );
		add_weapon( "stick_grenade" );
		add_weapon( "molotov" );
		set_secondary_offhand( "smoke" );
		set_switch_weapon( "mosin_rifle" );

		set_laststand_pistol( "tokarev" );

		set_player_viewmodel( "viewmodel_rus_guard_arms");

		level.campaign = "russian";
		return;
	}
	else if( level.script == "ber2" ) // SS
	{
		add_weapon( "ppsh" );
		add_weapon( "tokarev" );
		//add_weapon( "mosin_rifle" );  // SRS 5/9/2008: need to pick either the rifle or the SMG to start
		// CODER_MOD: Austin (7/31/08): added stick grenade for russian campaign to replace smoke (BUG 17665)
		add_weapon( "stick_grenade" );
		add_weapon( "molotov" );
		set_secondary_offhand( "smoke" );
		set_switch_weapon( "ppsh" );

		set_laststand_pistol( "tokarev" );

		set_player_viewmodel( "viewmodel_rus_guard_arms");

		level.campaign = "russian";
		return;
	}
	else if( level.script == "sniper" ) // TFlame 2/12/08 - only weapon player should have is a scoped rifle
	{
		add_weapon( "mosin_rifle_scoped" );
		add_weapon( "stick_grenade" );
		set_switch_weapon("mosin_rifle_scoped");

		set_laststand_pistol( "tokarev" );

		set_player_viewmodel( "viewmodel_rus_guard_arms");
		set_player_interactive_hands( "viewmodel_rus_guard_player" );

		level.campaign = "russian";
		return;
	}
	else if( level.script == "ber3" ) // Joyal
	{
		add_weapon( "svt40" );
		add_weapon( "ppsh" );
		// CODER_MOD: Austin (7/31/08): added stick grenade for russian campaign to replace smoke (BUG 17665)
		add_weapon( "stick_grenade" );
		add_weapon( "molotov" );
		PrecacheItem( "napalmblob" );
		PrecacheItem( "napalmbloblight" );
		set_secondary_offhand( "smoke" );
		set_switch_weapon( "ppsh" );

		set_laststand_pistol( "tokarev" );

		set_player_viewmodel("viewmodel_rus_guard_arms");
		level.campaign = "russian";
		return;
	}
	else if( level.script == "ber3b" ) // SS
	{
		add_weapon( "tokarev" );
		add_weapon( "svt40" );
		// CODER_MOD: Austin (7/31/08): added stick grenade for russian campaign to replace smoke (BUG 17665)
		add_weapon( "stick_grenade" );
		add_weapon( "molotov" );
		set_secondary_offhand( "smoke" );
		set_switch_weapon( "svt40" );

		set_laststand_pistol( "tokarev" );

		set_player_viewmodel( "viewmodel_rus_guard_arms");

		level.campaign = "russian";
		return;
	}
	else if( level.script == "oki2" ) // JeremyS
	{
		add_weapon( "30cal_wet" );
		//add_weapon( "m2_flamethrower_wet" );
		PrecacheItem( "m2_flamethrower_wet" );
		add_weapon( "thompson_wet" );
		add_weapon( "fraggrenade" );
		add_weapon( "m8_white_smoke" );
		//add_weapon( "satchel_charge" );
		set_secondary_offhand( "smoke" );
		//		set_switch_weapon( "m2_flamethrower_wet" );
		set_switch_weapon( "thompson_wet" );


		set_laststand_pistol( "colt_wet" );

		set_player_viewmodel( "viewmodel_usa_marinewet_rolledup_arms");
		set_player_interactive_hands( "viewmodel_usa_marinewet_rolledup_player" ); // Uncomment this if you want "interactive" hands for Banzai

		level.campaign = "american";
		return;
	}
	else if( level.script == "prologue" ) // Lucas (03/14/2008)
	{
		add_weapon( "m1garand" );
		add_weapon( "colt" );
		set_switch_weapon( "colt" );

		set_laststand_pistol( "colt" );

		set_player_viewmodel( "viewmodel_usa_marine_arms");

		level.campaign = "american";
		return;
	}
	else if( level.script == "oki3" ) // ChrisP
	{
		add_weapon( "m1garand" );
		add_weapon( "thompson" );
		add_weapon( "fraggrenade" );
		add_weapon( "m8_white_smoke" );
		add_weapon("air_support");
		set_action_slot( 4, "weapon", "air_support" );
		set_secondary_offhand( "smoke" );
		set_switch_weapon( "m1garand" );
		set_laststand_pistol( "colt" );

		set_player_viewmodel( "viewmodel_usa_marine_arms");
		set_player_interactive_hands( "viewmodel_usa_marine_player" );

		level.campaign = "american";
		return;
	}
	else if( level.script == "living_battlefield" )
	{
		add_weapon( "m1garand_bayonet" );
		add_weapon( "thompson" );
		add_weapon( "molotov" );
		PrecacheItem( "napalmblob" );
		PrecacheItem( "napalmbloblight" );
		add_weapon( "fraggrenade" );
		set_secondary_offhand( "flash" );
		set_switch_weapon( "m1garand_bayonet" );

		set_laststand_pistol( "colt" );

		set_player_viewmodel( "viewmodel_usa_marine_arms");

		level.campaign = "american";
		return;
	}
	else if( GetDvar( "zombiemode" ) == "1" || IsSubStr( level.script, "nazi_zombie_" ) || level.script == "zombie_test_map" ) // CODER_MOD (Austin 5/4/08): zombiemode loadout setup
	{
		//Zombiemode loadout. If you aren't making a zombie map then you can define your level.script and add a check above.
		set_player_specific_add_weapon(0, "colt" );
		set_player_specific_add_weapon(1, "walther");
		set_player_specific_add_weapon(2, "colt" );
		set_player_specific_add_weapon(3, "tokarev");
		PrecacheItem( "napalmblob" );
		PrecacheItem( "napalmbloblight" );
		set_player_specific_switch_weapon(0, "colt" );
		set_player_specific_switch_weapon(1, "walther");
		set_player_specific_switch_weapon(2, "colt" );
		set_player_specific_switch_weapon(3, "tokarev");

		set_player_specific_laststand_pistol(0, "colt" );
		set_player_specific_laststand_pistol(1, "walther");
		set_player_specific_laststand_pistol(2, "colt" );
		set_player_specific_laststand_pistol(3, "tokarev");

		set_player_specific_viewmodel(0, "viewmodel_usa_marine_arms");
    	set_player_specific_viewmodel(1, "viewmodel_ger_wermacht_arms");
    	set_player_specific_viewmodel(2, "viewmodel_usa_marine_arms");
    	set_player_specific_viewmodel(3, "viewmodel_rus_guard_arms");

		set_player_specific_interactive_hands(0, "viewmodel_usa_marine_player");
		set_player_specific_interactive_hands(1, "viewmodel_ger_wermacht_player");
		set_player_specific_interactive_hands(2, "viewmodel_usa_marine_player");
		set_player_specific_interactive_hands(3, "viewmodel_rus_guard_player");

		/*set_player_specific_death_hands(0, "death_hands");
		set_player_specific_death_hands(1, "death_hands");
		set_player_specific_death_hands(2, "death_hands");
		set_player_specific_death_hands(3, "death_hands");

		set_player_specific_knuckle_crack_hands(0, "knuckle_crack_hands");
		set_player_specific_knuckle_crack_hands(1, "knuckle_crack_hands");
		set_player_specific_knuckle_crack_hands(2, "knuckle_crack_hands");
		set_player_specific_knuckle_crack_hands(3, "knuckle_crack_hands");*/

		level.campaign = "american";
		return;
	}
	else if( IsSubStr( level.script, "intro_" ) ) // Support for the intro movies for the campaigns
	{
		return;
	}
	else if( level.script == "credits" )
	{
		set_player_viewmodel( "viewmodel_usa_marine_arms");
		set_player_interactive_hands( "viewmodel_usa_marine_player");
		level.campaign = "american";
		return;
	}


	//------------------------------------
	// level.script is not a single player level. give default weapons.
	println ("loadout.gsc:     No level listing in _loadout.gsc, giving default guns!!!! =======================");		

	// default weapons
	add_weapon( "colt" );
	add_weapon( "m1garand" );
	add_weapon( "fraggrenade" );
	add_weapon( "m8_white_smoke" );
	set_secondary_offhand( "smoke" );

	set_laststand_pistol( "colt" );
	set_switch_weapon( "m1garand" );

	// SRS 6/29/2008: updated to allow defaulted maps to have different level.campaign default viewarms
	if( isDefined( level.campaign ) && level.campaign == "russian" )
	{
		set_player_viewmodel( "viewmodel_rus_guard_arms");
	}
	else
	{
		set_player_viewmodel( "viewmodel_usa_marine_arms");
		level.campaign = "american";
	}
}

// This will precache and set the loadout rather than duplicating work.
add_weapon( weapon_name )
{
	PrecacheItem( weapon_name );
	level.player_loadout[level.player_loadout.size] = weapon_name;
}

// This sets the secondary offhand type when the player spawns in
set_secondary_offhand( weapon_name )
{
	level.player_secondaryoffhand = weapon_name;
}

// This sets the the switchtoweapon when the player spawns in
set_switch_weapon( weapon_name )
{
	level.player_switchweapon = weapon_name;
}

// This sets the the action slot for when the player spawns in
set_action_slot( num, option1, option2 )
{

	if( num < 2 || num > 4)
	{
		if(level.script != "pby_fly")  // GLocke 11/15/2007 - The flying level uses all 4 dpad slots
		{
			// Not using 1, since it's defaulted to grenade launcher.
			assertmsg( "_loadout.gsc: set_action_slot must be set with a number greater than 1 and less than 5" );
		}
	}

	// Glocke 12/03/07 - added precaching of weapon type for action slot
	if(isDefined(option1))
	{
		if(option1 == "weapon")
		{
			PrecacheItem(option2);
			level.player_loadout[level.player_loadout.size] = option2;
		}
	}

	if( !isDefined( level.player_actionslots ) )
	{
		level.player_actionslots = [];
	}

	action_slot = SpawnStruct();
	action_slot.num = num;
	action_slot.option1 = option1;

	if( isDefined( option2 ) )
	{
		action_slot.option2 = option2;
	}

	level.player_actionslots[level.player_actionslots.size] = action_slot;
}

// Sets the player's viewmodel
set_player_viewmodel( viewmodel )
{
	PrecacheModel( viewmodel );
	level.player_viewmodel = viewmodel;
}

// Sets the player's handmodel used for "interactive" hands and banzai attacks
set_player_interactive_hands( model )
{
	level.player_interactive_hands = model;
	PrecacheModel( level.player_interactive_hands ); 
}

// Sets the player's laststand pistol
set_laststand_pistol( weapon )
{
	level.laststandpistol = weapon;
}

/*set_death_hands( weapon )
{
	level.death_hands = weapon;
}

set_knuckle_crack_hands( weapon )
{
	level.knuckle_crack_hands = weapon;
}*/

give_loadout(wait_for_switch_weapon)
{
	if( !isDefined( game["gaveweapons"] ) )
	{
		game["gaveweapons"] = 0;
	}

	if( !isDefined( game["expectedlevel"] ) )
	{
		game["expectedlevel"] = "";
	}

	if( game["expectedlevel"] != level.script )
	{
		game["gaveweapons"] = 0;		
	}

	if( game["gaveweapons"] == 0 )
	{
		game["gaveweapons"] = 1;
	}

	// MikeD (4/18/2008): In order to be able to throw a grenade back, the player first needs to at
	// least have a grenade in his inventory before doing so. So let's try to find out and give it to him
	// then take it away.
	gave_grenade = false;

	// First check to see if we are giving him a grenade, if so, skip this process.
	for( i = 0; i < level.player_loadout.size; i++ )
	{
		if( WeaponType( level.player_loadout[i] ) == "grenade" )
		{
			gave_grenade = true;
			break;
		}
	}

	// If we do not have a grenade then try to automatically assign one
	// If we can't automatically do this, then the scripter needs to do by hand in the level
	if( !gave_grenade )
	{
		if( isDefined( level.player_grenade ) )
		{
			grenade = level.player_grenade;
			self GiveWeapon( grenade );
			self SetWeaponAmmoStock( grenade, 0 );
			gave_grenade = true;
		}

		if( !gave_grenade )
		{
			// Get all of the AI and assign any grenade to the player
			ai = GetAiArray( "allies" );

			if( isDefined( ai ) )
			{
				for( i = 0; i < ai.size; i++ )
				{
					if( isDefined( ai[i].grenadeWeapon ) )
					{
						grenade = ai[i].grenadeWeapon;
						self GiveWeapon( grenade );
						self SetWeaponAmmoStock( grenade, 0 );
						break;
					}
				}
			}

			println( "^3LOADOUT ISSUE: Unable to give a grenade, the player need to be given a grenade and then take it away in order for the player to throw back grenades, but not have any grenades in his inventory." );
		}
	}

	for( i = 0; i < level.player_loadout.size; i++ )
	{
		self GiveWeapon( level.player_loadout[i] );
	}

	self SetActionSlot( 1, "" );
	self SetActionSlot( 2, "" );
	self SetActionSlot( 3, "altMode" );	// toggles between attached grenade launcher
	self SetActionSlot( 4, "" );

	if( isDefined( level.player_actionslots ) )
	{
		for( i = 0; i < level.player_actionslots.size; i++ )
		{
			num = level.player_actionslots[i].num;
			option1 = level.player_actionslots[i].option1;

			if( isDefined( level.player_actionslots[i].option2 ) )
			{
				option2 = level.player_actionslots[i].option2;
				self SetActionSlot( num, option1, option2 );
			}
			else
			{
				self SetActionSlot( num, option1 );
			}
		}
	}

	if( isDefined( level.player_switchweapon ) )
	{
		// the wait was added to fix a revive issue with the host
		// for some reson the SwitchToWeapon message gets lost
		// this can be removed if that is ever resolved
		if ( isDefined(wait_for_switch_weapon) && wait_for_switch_weapon == true )
		{
			wait(0.5);
		}
		self SwitchToWeapon( level.player_switchweapon );
	}

	wait(0.5);

	self player_flag_set("loadout_given");
}

give_model( class )
{

	if (level.campaign == "russian")
	{
		if (level.script == "ber2")
		{
			self mptype\player_rus_guard_wet::main();	
		}
		else if (level.script == "sniper")
		{
			// nothing!
		}
		else
		{
			self mptype\player_rus_guard::main();
		}
	}
	else if (level.campaign == "american")
	{
		if (level.script == "pel1")
		{
			self mptype\player_usa_marine::main();	
		}
		else if (level.script == "pel1a" || level.script == "pel2")
		{
			self mptype\player_usa_marine::main();
		}
		else if (level.script == "oki2")
		{
			self mptype\player_usa_marine_wet::main();
		}
		else if (level.script == "mak")
		{
			self mptype\player_usa_raider::main();
		}
		else if ( level.script == "pby_fly")
		{
			//nothing
		}
		else
		{

			switch( maps\_zombiemode_weapons::get_player_index( self ) )
			{
			case 0:
				character\char_zomb_player_0::main();
				break;
			case 1:
				character\char_zomb_player_1::main();
				break;
			case 2:
				character\char_zomb_player_2::main();
				break;
			case 3:
				character\char_zomb_player_3::main();
				break;
			}

		}
			self give_player_specific_add_weapon();
			self give_player_specific_switch_weapon();
			self give_player_specific_laststand_pistol();
			self give_player_specific_viewmodel();
			//level waittill("condition_goes_here");
			//self give_player_specific_death_hands();
			//level waittill("condition_goes_here");
			//self give_player_specific_knuckle_crack_hands();  
            return;
	}
	else
	{
		switch( self.entity_num)
			{
			case 0:
				character\char_zomb_player_0::main();
				break;
			case 1:
				character\char_zomb_player_1::main();
				break;
			case 2:
				character\char_zomb_player_2::main();
				break;
			case 3:
				character\char_zomb_player_3::main();
				break;
			}
	}

}
///////////////////////////////////////////////
// SavePlayerWeaponStatePersistent
// 
// Saves the player's weapons and ammo state persistently( in the game variable )
// so that it can be restored in a different map.
// You can use strings for the slot:
// 
// SavePlayerWeaponStatePersistent( "russianCampaign" );
// 
// Or you can just use numbers:
// 
// SavePlayerWeaponStatePersistent( 0 );
// SavePlayerWeaponStatePersistent( 1 ); etc.
// 
// In a different map, you can restore using RestorePlayerWeaponStatePersistent( slot );
// Make sure that you always persist the data between map changes.

SavePlayerWeaponStatePersistent( slot )
{
	current = level.player getCurrentWeapon();
	if ( ( !isDefined( current ) ) || ( current == "none" ) )
		assertmsg( "Player's current weapon is 'none' or undefined. Make sure 'disableWeapons()' has not been called on the player when trying to save weapon states." );
	game[ "weaponstates" ][ slot ][ "current" ] = current;

	offhand = level.player getcurrentoffhand();
	game[ "weaponstates" ][ slot ][ "offhand" ] = offhand;

	game[ "weaponstates" ][ slot ][ "list" ] = [];
	weapList = level.player GetWeaponsList();
	for ( weapIdx = 0; weapIdx < weapList.size; weapIdx++ )
	{
		game[ "weaponstates" ][ slot ][ "list" ][ weapIdx ][ "name" ] = weapList[ weapIdx ];

		// below is only used if we want to NOT give max ammo
		// game[ "weaponstates" ][ slot ][ "list" ][ weapIdx ][ "clip" ] = level.player GetWeaponAmmoClip( weapList[ weapIdx ] );
		// game[ "weaponstates" ][ slot ][ "list" ][ weapIdx ][ "stock" ] = level.player GetWeaponAmmoStock( weapList[ weapIdx ] );
	}
}

RestorePlayerWeaponStatePersistent( slot )
{
	if ( !isDefined( game[ "weaponstates" ] ) )
		return false;
	if ( !isDefined( game[ "weaponstates" ][ slot ] ) )
		return false;

	level.player takeallweapons();

	for ( weapIdx = 0; weapIdx < game[ "weaponstates" ][ slot ][ "list" ].size; weapIdx++ )
	{
		weapName = game[ "weaponstates" ][ slot ][ "list" ][ weapIdx ][ "name" ];

		if ( isDefined( level.legit_weapons ) )
		{
			// weapon doesn't exist in this level
			if ( !isDefined( level.legit_weapons[ weapName ] ) )
				continue;
		}

		// don't carry over C4 or claymores
		if ( weapName == "c4" )
			continue;
		if ( weapName == "claymore" )
			continue;
		level.player GiveWeapon( weapName );
		level.player GiveMaxAmmo( weapName );

		// below is only used if we want to NOT give max ammo
		// level.player SetWeaponAmmoClip( weapName, game[ "weaponstates" ][ slot ][ "list" ][ weapIdx ][ "clip" ] );
		// level.player SetWeaponAmmoStock( weapName, game[ "weaponstates" ][ slot ][ "list" ][ weapIdx ][ "stock" ] );
	}

	if ( isDefined( level.legit_weapons ) )
	{
		weapname = game[ "weaponstates" ][ slot ][ "offhand" ];
		if ( isDefined( level.legit_weapons[ weapName ] ) )
			level.player switchtooffhand( weapname );

		weapname = game[ "weaponstates" ][ slot ][ "current" ];
		if ( isDefined( level.legit_weapons[ weapName ] ) )
			level.player SwitchToWeapon( weapname );
	}
	else
	{
		level.player switchtooffhand( game[ "weaponstates" ][ slot ][ "offhand" ] );
		level.player SwitchToWeapon( game[ "weaponstates" ][ slot ][ "current" ] );
	}

	return true;
}

set_player_specific_add_weapon(num, name)
{
if(!isDefined(level.player_specific_add_weapon))
         level.player_specific_add_weapon = [];
level.player_specific_add_weapon[num] = name;
PrecacheItem(name);
}

give_player_specific_add_weapon()
{
if(isDefined(level.player_specific_add_weapon) && isDefined(level.player_specific_add_weapon[ maps\_zombiemode_weapons::get_player_index( self ) ]))
{
         self giveWeapon(level.player_specific_add_weapon[ maps\_zombiemode_weapons::get_player_index( self ) ]);
}
else if(isDefined(level.player_loadout))
{
         self giveWeapon(level.player_loadout);
}
}

set_player_specific_switch_weapon(num, name)
{
if(!isDefined(level.player_specific_switch_weapon))
         level.player_specific_switch_weapon = [];
level.player_specific_switch_weapon[num] = name;
PrecacheItem(name);
}

give_player_specific_switch_weapon()
{
if(isDefined(level.player_specific_switch_weapon) && isDefined(level.player_specific_switch_weapon[ maps\_zombiemode_weapons::get_player_index( self ) ]))
{
         self switchToWeapon(level.player_specific_switch_weapon[ maps\_zombiemode_weapons::get_player_index( self ) ]);
}
else if(isDefined(level.player_switchweapon))
{
         self switchToWeapon(level.player_switchweapon);
}
}

set_player_specific_laststand_pistol(num, name)
{
if(!isDefined(level.player_specific_laststand_pistol))
         level.player_specific_laststand_pistol = [];
level.player_specific_laststand_pistol[num] = name;
PrecacheItem(name);
}

give_player_specific_laststand_pistol()
{
if(isDefined(level.player_specific_laststand_pistol) && isDefined(level.player_specific_laststand_pistol[ maps\_zombiemode_weapons::get_player_index( self ) ]))
{
         self switchToWeapon(level.player_specific_laststand_pistol[ maps\_zombiemode_weapons::get_player_index( self ) ]);
}
else if(isDefined(level.laststandpistol))
{
         self switchToWeapon(level.laststandpistol);
}
}

set_player_specific_viewmodel(num, name)
{
if(!isDefined(level.player_specific_viewmodels))
         level.player_specific_viewmodels = [];
level.player_specific_viewmodels[num] = name;
PrecacheModel(name);
}

give_player_specific_viewmodel()
{
if(isDefined(level.player_specific_viewmodels) && isDefined(level.player_specific_viewmodels[ maps\_zombiemode_weapons::get_player_index( self ) ]))
{
         self SetViewModel(level.player_specific_viewmodels[ maps\_zombiemode_weapons::get_player_index( self ) ]);
}
else if(isDefined(level.player_viewmodel))
{
         self SetViewModel(level.player_viewmodel);
}
}

set_player_specific_interactive_hands(num, name)
{
if(!isDefined(level.player_specific_interactive_hands))
         level.player_specific_interactive_hands = [];
level.player_specific_interactive_hands[num] = name;
PrecacheModel(name);
}

/*set_player_specific_death_hands(num, name)
{
if(!isDefined(level.player_specific_death_hands))
         level.player_specific_death_hands = [];
level.player_specific_death_hands[num] = name;
PrecacheModel(name);
IPrintLn("death anim");
}

give_player_specific_death_hands()
{
if(isDefined(level.player_specific_death_hands) && isDefined(level.player_specific_death_hands[ maps\_zombiemode_weapons::get_player_index( self ) ]))
{
         self SetViewModel(level.player_specific_death_hands[ maps\_zombiemode_weapons::get_player_index( self ) ]);
		 IPrintLn("death anim");
}
else if(isDefined(level.death_hands))
{
         self SetViewModel(level.death_hands);
		 IPrintLn("death anim");
}
}

set_player_specific_knuckle_crack_hands(num, name)
{
if(!isDefined(level.player_specific_knuckle_crack_hands))
         level.player_specific_knuckle_crack_hands = [];
level.player_specific_knuckle_crack_hands[num] = name;
PrecacheModel(name);
IPrintLn("death anim");
}

give_player_specific_knuckle_crack_hands()
{
if(isDefined(level.player_specific_knuckle_crack_hands) && isDefined(level.player_specific_knuckle_crack_hands[ maps\_zombiemode_weapons::get_player_index( self ) ]))
{
         self SetViewModel(level.player_specific_knuckle_crack_hands[ maps\_zombiemode_weapons::get_player_index( self ) ]);
		 IPrintLn("death anim");
}
else if(isDefined(level.knuckle_crack_hands))
{
         self SetViewModel(level.knuckle_crack_hands);
		 IPrintLn("death anim");
}
}*/
