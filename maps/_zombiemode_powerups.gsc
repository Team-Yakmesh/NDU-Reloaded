#include maps\_utility; 
#include common_scripts\utility;
#include maps\_zombiemode_utility;

init()
{

	PrecacheShader( "specialty_doublepoints_zombies" );
	PrecacheShader( "specialty_instakill_zombies" );
	PrecacheShader( "specialty_juggernaut_zombies" );
	PrecacheShader( "specialty_fastreload_zombies" );
	PrecacheShader( "specialty_doubletap_zombies" );
	PrecacheShader( "specialty_quickrevive_zombies" );
	PrecacheShader( "specialty_phd_zombies" );
	PrecacheShader( "specialty_sp_zombies" );
	PrecacheShader( "specialty_aim_zombies" );
	PrecacheShader( "specialty_fireworks_zombies" );
	PrecacheShader( "specialty_longersprint_zombies" );
	PrecacheShader( "black" ); 

	PrecacheModel( "zombie_pickup_perkbottle" );
	
	// powerup Vars
	set_zombie_var( "zombie_insta_kill", 				0 );
	set_zombie_var( "zombie_point_scalar", 				1 );
	set_zombie_var( "zombie_drop_item", 				0 );
	set_zombie_var( "zombie_timer_offset", 				350 );	// hud offsets
	set_zombie_var( "zombie_timer_offset_interval", 	30 );
	set_zombie_var( "zombie_powerup_insta_kill_on", 	false );
	set_zombie_var( "zombie_powerup_point_doubler_on", 	false );
	set_zombie_var( "zombie_powerup_point_doubler_time", 30 );	// length of point doubler
	set_zombie_var( "zombie_powerup_insta_kill_time", 	30 );	// length of insta kill
	set_zombie_var( "zombie_powerup_drop_increment", 	2000 );	// lower this to make drop happen more often 400
	set_zombie_var( "zombie_powerup_drop_max_per_round", 4 );	// lower this to make drop happen more often

	// powerups
	level._effect["powerup_on"] 				= loadfx( "misc/fx_zombie_powerup_on" );
	level._effect["powerup_grabbed"] 			= loadfx( "misc/fx_zombie_powerup_grab" );
	level._effect["powerup_grabbed_wave"] 		= loadfx( "misc/fx_zombie_powerup_wave" );

	init_powerups();

	thread watch_for_drop();
	
}

init_powerups()
{
    // Random Drops
    //add_zombie_powerup( "nuke",         "zombie_bomb",        &"ZOMBIE_POWERUP_NUKE",             "misc/fx_zombie_mini_nuke" );
    //add_zombie_powerup( "nuke",         "zombie_bomb",        &"ZOMBIE_POWERUP_NUKE",             "misc/fx_zombie_mini_nuke_hotness" );
    add_zombie_powerup( "insta_kill",     "zombie_skull",        &"ZOMBIE_POWERUP_INSTA_KILL" );
    //add_zombie_powerup( "double_points","zombie_x2_icon",    &"ZOMBIE_POWERUP_DOUBLE_POINTS" );
    //add_zombie_powerup( "full_ammo",      "zombie_ammocan",    &"ZOMBIE_POWERUP_MAX_AMMO");
    //add_zombie_powerup( "carpenter",      "zombie_carpenter",    &"ZOMBIE_POWERUP_MAX_AMMO");
    //add_zombie_powerup( "randomperk",        "zombie_pickup_perkbottle",        "ZOMBIE_POWERUP_MAX_AMMO" );	//Random Perk!

	// Randomize the order
	randomize_powerups();

	level.zombie_powerup_index = 0;
	randomize_powerups();

	level thread powerup_hud_overlay();
}  

powerup_hud_overlay()
{

	level.powerup_hud_array = [];
	level.powerup_hud_array[0] = true;
	level.powerup_hud_array[1] = true;

	level.powerup_hud = [];
	level.powerup_hud_cover = [];
	level endon ("disconnect");


	for(i = 0; i < 2; i++)
	{
		level.powerup_hud[i] = create_simple_hud();
		level.powerup_hud[i].foreground = true; 
		level.powerup_hud[i].sort = 2; 
		level.powerup_hud[i].hidewheninmenu = false; 
		level.powerup_hud[i].alignX = "center"; 
		level.powerup_hud[i].alignY = "bottom";
		level.powerup_hud[i].horzAlign = "center"; 
		level.powerup_hud[i].vertAlign = "bottom";
		level.powerup_hud[i].x = -32 + (i * 15); 
		level.powerup_hud[i].y = level.powerup_hud[i].y - 35; 
		level.powerup_hud[i].alpha = 0.8;
		//hud SetShader( shader_inst, 24, 24 );
	}

	shader_2x = "specialty_doublepoints_zombies";
	shader_insta = "specialty_instakill_zombies";
//	shader_white = "black";
	



	//for(i = 0; i < 2; i++)
	//{
	//	level.powerup_hud_cover[i] = create_simple_hud();
	//	level.powerup_hud_cover[i].foreground = true; 
	//	level.powerup_hud_cover[i].sort = 1; 
	//	level.powerup_hud_cover[i].hidewheninmenu = false; 
	//	level.powerup_hud_cover[i].alignX = "center"; 
	//	level.powerup_hud_cover[i].alignY = "bottom";
	//	level.powerup_hud_cover[i].horzAlign = "center"; 
	//	level.powerup_hud_cover[i].vertAlign = "bottom";
	//	level.powerup_hud_cover[i].x = -32 + (i * 34); 
	//	level.powerup_hud_cover[i].y = level.powerup_hud_cover[i].y - 30; 
	//	level.powerup_hud_cover[i].alpha = 1;
	//	//hud SetShader( shader_inst, 24, 24 );
	//}



	//increment = 0;
	

	while(true)
	{
		if(level.zombie_vars["zombie_powerup_insta_kill_time"] < 5)
		{
			wait(0.1);		
			level.powerup_hud[1].alpha = 0;
			wait(0.1);
			

		}
		else if(level.zombie_vars["zombie_powerup_insta_kill_time"] < 10)
		{
			wait(0.2);
			level.powerup_hud[1].alpha = 0;
			wait(0.18);
			
		}
		
		if(level.zombie_vars["zombie_powerup_point_doubler_time"] < 5)
		{
			wait(0.1);	
			level.powerup_hud[0].alpha = 0;
			wait(0.1);
			

		}
		else if(level.zombie_vars["zombie_powerup_point_doubler_time"] < 10)
		{
			wait(0.2);
			level.powerup_hud[0].alpha = 0;
			wait(0.18);
		}
		

		//if(level.zombie_vars["zombie_powerup_insta_kill_time"] != 0)
		//	iprintlnbold(level.zombie_vars["zombie_powerup_insta_kill_time"]);

		//if(level.zombie_vars["zombie_powerup_point_doubler_time"] != 0)
		//	iprintlnbold(level.zombie_vars["zombie_powerup_point_doubler_time"]);


		//wait(0.01);
		
		if(level.zombie_vars["zombie_powerup_point_doubler_on"] == true && level.zombie_vars["zombie_powerup_insta_kill_on"] == true)
		{

			level.powerup_hud[0].x = -24;
			level.powerup_hud[1].x = 24;
			level.powerup_hud[0].alpha = 1;
			level.powerup_hud[1].alpha = 1;
			level.powerup_hud[0] setshader(shader_2x, 32, 32);
			level.powerup_hud[1] setshader(shader_insta, 32, 32);
			/*level.powerup_hud_cover[0].x = -36;
			level.powerup_hud_cover[1].x = 36;
			level.powerup_hud_cover[0] setshader(shader_white, 32, i);
			level.powerup_hud_cover[1] setshader(shader_white, 32, j);
			level.powerup_hud_cover[0].alpha = 1;
			level.powerup_hud_cover[1].alpha = 1;*/

		}
		else if(level.zombie_vars["zombie_powerup_point_doubler_on"] == true && level.zombie_vars["zombie_powerup_insta_kill_on"] == false)
		{
			level.powerup_hud[0].x = 0; 
			//level.powerup_hud[0].y = level.powerup_hud[0].y - 70; 
			level.powerup_hud[0] setshader(shader_2x, 32, 32);
			level.powerup_hud[1].alpha = 0;
			level.powerup_hud[0].alpha = 1;

		}
		else if(level.zombie_vars["zombie_powerup_insta_kill_on"] == true && level.zombie_vars["zombie_powerup_point_doubler_on"] == false)
		{

			level.powerup_hud[1].x = 0; 
			//level.powerup_hud[1].y = level.powerup_hud[1].y - 70; 
			level.powerup_hud[1] setshader(shader_insta, 32, 32);
			level.powerup_hud[0].alpha = 0;
			level.powerup_hud[1].alpha = 1;
		}
		else
		{
			
			level.powerup_hud[1].alpha = 0;
			level.powerup_hud[0].alpha = 0;

		}

		wait(0.01);


	
		//increment += 1;

		//if(increment >= 20)
		//{
		//	level.powerup_hud[0].alpha = 0;
		//	level.powerup_hud[1].alpha = 0;
		////	level.powerup_hud_cover[0].alpha = 0;
		////	level.powerup_hud_cover[1].alpha = 0;
		//}
		//
		//if(increment == 30)
		//{

		//	level.powerup_hud_array[1] = false;
		//	level.powerup_hud_array[0] = false;

		//}
		//wait(0.5);

		




	/*	if(randomint(100) > 50)
			level.powerup_hud_array[0] = false;
		else 
			level.powerup_hud_array[0] = true;
	

		if(randomint(100) > 50)
			level.powerup_hud_array[1] = false;
		else
			level.powerup_hud_array[1] = true;*/

	}


	

	//for(i = 0; i < 2; i++)
	//{
	//	level.powerup_hud_cover[i] = create_simple_hud();
	//	level.powerup_hud_cover[i].foreground = true; 
	//	level.powerup_hud_cover[i].sort = 1; 
	//	level.powerup_hud_cover[i].hidewheninmenu = false; 
	//	level.powerup_hud_cover[i].alignX = "center"; 
	//	level.powerup_hud_cover[i].alignY = "bottom";
	//	level.powerup_hud_cover[i].horzAlign = "center"; 
	//	level.powerup_hud_cover[i].vertAlign = "bottom";
	//	level.powerup_hud_cover[i].x = -32 + (i * 34); 
	//	level.powerup_hud_cover[i].y = level.powerup_hud_cover[i].y - 79; 
	//	level.powerup_hud_cover[i].alpha = 0.5;
	//	//hud SetShader( shader_inst, 24, 24 );
	//}


	//while(true)
	//{
	//	/*	for(i = 0; i < 2; i++)
	//	{
	//	level.powerup_hud[i].y = level.powerup_hud[i].y - 5;

	//	}*/




	//	wait(1);
	//}

}

randomize_powerups()
{
	level.zombie_powerup_array = array_randomize( level.zombie_powerup_array );
}

get_next_powerup()
{
	if( level.zombie_powerup_index >= level.zombie_powerup_array.size )
	{
		level.zombie_powerup_index = 0;
		randomize_powerups();
	}

	powerup = level.zombie_powerup_array[level.zombie_powerup_index];
	
	level.zombie_powerup_index++;

	return powerup;
}
get_num_window_destroyed()
{
	num = 0;
	for( i = 0; i < level.exterior_goals.size; i++ )
	{
		/*targets = getentarray(level.exterior_goals[i].target, "targetname");

		barrier_chunks = []; 
		for( j = 0; j < targets.size; j++ )
		{
			if( IsDefined( targets[j].script_noteworthy ) )
			{
				if( targets[j].script_noteworthy == "clip" )
				{ 
					continue; 
				}
			}

			barrier_chunks[barrier_chunks.size] = targets[j];
		}*/


		if( all_chunks_destroyed( level.exterior_goals[i].barrier_chunks ) )
		{
			num += 1;
		}
	}

	return num;
}
watch_for_drop()
{
	players = get_players();
	score_to_drop = ( players.size * level.zombie_vars["zombie_score_start"] ) + level.zombie_vars["zombie_powerup_drop_increment"];
	while (1)
	{
		players = get_players();

		curr_total_score = 0;

		for (i = 0; i < players.size; i++)
		{
			curr_total_score += players[i].score_total * 2;
		}
		
		if (curr_total_score > score_to_drop )
		{
			level.zombie_vars["zombie_powerup_drop_increment"] *= 1.14;
			score_to_drop = curr_total_score + level.zombie_vars["zombie_powerup_drop_increment"];
			level.zombie_vars["zombie_drop_item"] = 1;
		}

		wait( 0.5 );
	}
}

add_zombie_powerup( powerup_name, model_name, hint, fx )
{
	if( IsDefined( level.zombie_include_powerups ) && !IsDefined( level.zombie_include_powerups[powerup_name] ) )
	{
		return;
	}

	PrecacheModel( model_name );
	PrecacheString( hint );

	struct = SpawnStruct();

	if( !IsDefined( level.zombie_powerups ) )
	{
		level.zombie_powerups = [];
	}

	if( !IsDefined( level.zombie_powerup_array ) )
	{
		level.zombie_powerup_array = [];
	}

	struct.powerup_name = powerup_name;
	struct.model_name = model_name;
	struct.weapon_classname = "script_model";
	struct.hint = hint;

	if( IsDefined( fx ) )
	{
		struct.fx = LoadFx( fx );
	}

	level.zombie_powerups[powerup_name] = struct;
	level.zombie_powerup_array[level.zombie_powerup_array.size] = powerup_name;
}

include_zombie_powerup( powerup_name )
{
	if( !IsDefined( level.zombie_include_powerups ) )
	{
		level.zombie_include_powerups = [];
	}

	level.zombie_include_powerups[powerup_name] = true;
}

powerup_round_start()
{
	level.powerup_drop_count = 0;
}

powerup_drop(drop_point)
{
	rand_drop = randomint(100);

	if( level.powerup_drop_count == level.zombie_vars["zombie_powerup_drop_max_per_round"] )
	{
		println( "^3POWERUP DROP EXCEEDED THE MAX PER ROUND!" );
		return;
	}

	// some guys randomly drop, but most of the time they check for the drop flag
	if (rand_drop > 2)
	{
		if (!level.zombie_vars["zombie_drop_item"])
		{
			return;
		}

		debug = "score";
	}
	else
	{
		debug = "random";
	}	

	// never drop unless in the playable area
	playable_area = getentarray("playable_area","targetname");

	powerup = spawn ("script_model", drop_point + (0,0,40));
	
	//chris_p - fixed bug where you could not have more than 1 playable area trigger for the whole map
	valid_drop = false;
	for (i = 0; i < playable_area.size; i++)
	{
		if (powerup istouching(playable_area[i]))
		{
			valid_drop = true;
		}
	}
	
	if(!valid_drop)
	{
		powerup delete();
		return;
	}

	powerup powerup_setup();
	level.powerup_drop_count++;

	print_powerup_drop( powerup.powerup_name, debug );

	powerup thread powerup_timeout();
	powerup thread powerup_wobble();
	powerup thread powerup_grab();

	level.zombie_vars["zombie_drop_item"] = 0;


	//powerup = powerup_setup(); 


	// if is !is touching trig
	// return

	// spawn the model, do a ground trace and place above
	// start the movement logic, spawn the fx
	// start the time out logic
	// start the grab logic
}

powerup_setup()
{
	powerup = get_next_powerup();

	struct = level.zombie_powerups[powerup];
	self SetModel( struct.model_name );

	//TUEY Spawn Powerup
	playsoundatposition("spawn_powerup", self.origin);

	self.powerup_name 	= struct.powerup_name;
	self.hint 			= struct.hint;

	if( IsDefined( struct.fx ) )
	{
		self.fx = struct.fx;
	}

	self PlayLoopSound("spawn_powerup_loop");
}

powerup_grab()
{
	self endon ("powerup_timedout");
	self endon ("powerup_grabbed");

	while (isdefined(self))
	{
		players = get_players();

		for (i = 0; i < players.size; i++)
		{
			if (distance (players[i].origin, self.origin) < 64)
			{
				playfx (level._effect["powerup_grabbed"], self.origin);
				playfx (level._effect["powerup_grabbed_wave"], self.origin);	

				if( IsDefined( level.zombie_powerup_grab_func ) )
				{
					level thread [[level.zombie_powerup_grab_func]]();
				}
				else
				{
					switch (self.powerup_name)
					{
					case "nuke":
						level thread nuke_powerup( self );
						
						//chrisp - adding powerup VO sounds
						players[i] thread powerup_vo("nuke");
						zombies = getaiarray("axis");
						players[i].zombie_nuked = get_array_of_closest( self.origin, zombies );
						players[i] notify("nuke_triggered");
						
						break;
					case "full_ammo":
						level thread full_ammo_powerup( self );
						players[i] thread powerup_vo("full_ammo");
						break;
					case "double_points":
						level thread double_points_powerup( self );
						players[i] thread powerup_vo("double_points");
						break;
					case "insta_kill":
						level thread insta_kill_powerup( self );
						players[i] thread powerup_vo("insta_kill");
						break;	
					case "carpenter":
						level thread start_carpenter( self.origin );
						players[i] thread powerup_vo("carpenter");
						break;						
					case "randomperk":
							for(i=0;i<players.size;i++)
							{
								players[i] thread give_player_perk();
							}
						break;
					default:
						println ("Unrecognized powerup.");
						break;
					}
				}

				wait( 0.1 );

				playsoundatposition("powerup_grabbed", self.origin);
				self stoploopsound();

				self delete();
				self notify ("powerup_grabbed");
			}
		}
		wait 0.1;
	}	
}

give_player_perk()
{
	//IPrintLn("Give perk has been activated!");

	if(!isdefined(self.perknum) || self.perknum == 0) // if player doesnt have any perks
	{
		//IPrintLn("defining perks");
		self thread resetperkdefs();
		self thread death_check();
	}

	if( self maps\_laststand::player_is_in_laststand() || self.perknum == 8 ) //max perks
	{
		//IPrintLn("max perks! or downed... :(");
		return;
	}

	if(self.perkarray[self.perknum] == "specialty_armorvest")
	{
		//IPrintLn("perk is jugg");
		self.maxhealth = 200;
	}

	if(self.perkarray[self.perknum] == "specialty_longersprint")
	{
		self SetMoveSpeedScale(1);
		self setClientDvar( "perk_sprintMultiplier", "1" ); 
	}

	self SetPerk( self.perkarray[self.perknum] );
	self perk_hud_create( self.perkarray[self.perknum] );

	self.perknum++; // add 1 perk to counter
	//IPrintLn("player has " + self.perknum + " perks");
}

resetperkdefs()
{	
	
	self.perkarray = [];
	self.perkarray[0] = "specialty_armorvest";
	self.perkarray[1] = "specialty_rof";
	self.perkarray[2] = "specialty_fastreload";
	self.perkarray[3] = "specialty_quickrevive";
	self.perkarray[4] = "specialty_detectexplosive";
	self.perkarray[5] = "specialty_longersprint";
	self.perkarray[6] = "specialty_bulletaccuracy";
	self.perkarray[7] = "specialty_explosivedamage";
	//self.perkarray[8] = "specialty_bulletdamage";		//merged into rof for Double Tap 2.0
	self.perkarray = array_randomize( self.perkarray );
	
	self.perknum = 0;
}

start_carpenter( origin )
{
	playsoundatposition("carp_vox", (0,0,0));
	window_boards = getstructarray( "exterior_goal", "targetname" ); 
	total = level.exterior_goals.size;
	
	//COLLIN
	carp_ent = spawn("script_origin", (0,0,0));
	carp_ent playloopsound( "carp_loop" );
	
	while(true)
	{
		windows = get_closest_window_repair(window_boards);
		if( !IsDefined( windows ) )
		{
			carp_ent stoploopsound( 1 );
			carp_ent playsound( "carp_end", "sound_done" );
			carp_ent waittill( "sound_done" );
			break;
		}
		else
		{
			window_boards = array_remove(window_boards, windows);
		}


		while(1)
		{
			if( all_chunks_intact( windows.barrier_chunks ) )
			{
				break;
			}

			chunk = get_random_destroyed_chunk( windows.barrier_chunks ); 

			if( !IsDefined( chunk ) )
				break;

			windows thread maps\_zombiemode_blockers::replace_chunk( chunk, false, true );
			windows.clip enable_trigger(); 
			windows.clip DisconnectPaths();
			wait_network_frame();
			wait(0.05);
		}
 

		wait_network_frame();
		
	}

	players = get_players();

	for(i = 0; i < players.size; i++)
	{
		players[i].score += 200 * level.zombie_vars["zombie_point_scalar"];
		players[i].score_total += 200 * level.zombie_vars["zombie_point_scalar"];
		players[i] maps\_zombiemode_score::set_player_score_hud(); 
	}

	carp_ent delete();
}
get_closest_window_repair( windows )
{
	current_window = undefined;
	for( i = 0; i < windows.size; i++ )
	{
		if( all_chunks_intact(windows[i].barrier_chunks ) )
			continue;

		current_window = windows[i];

	}
	return current_window;
}

powerup_vo(type)
{
	self endon("death");
	self endon("disconnect");
	
	index =  maps\_zombiemode_weapons::get_player_index(self);
	sound = undefined;
	
	if(!isdefined (level.player_is_speaking))
	{
		level.player_is_speaking = 0;
	}
	
	wait(randomfloatrange(1,2));
		
	switch(type)
	{
		case "nuke":
			sound = "plr_" + index + "_vox_powerup_nuke_0";
			break;
		case "insta_kill":
			sound = "plr_" + index + "_vox_powerup_insta_0";
			break;
		case "full_ammo":
			sound = "plr_" + index + "_vox_powerup_ammo_0";
			break;
		case "double_points":
			sound = "plr_" + index + "_vox_powerup_double_0";
			break;
		case "carpenter":
			sound = "plr_0_vox_powerup_carp_" + index + "";
			break;
	}
	//This keeps multiple voice overs from playing on the same player (both killstreaks and headshots).
	if (level.player_is_speaking != 1 && isDefined(sound))
	{	
		level.player_is_speaking = 1;
		self playsound(sound, "sound_done");			
		self waittill("sound_done");
		level.player_is_speaking = 0;
	}	
	
	
}

powerup_wobble()
{
	self endon ("powerup_grabbed");
	self endon ("powerup_timedout");

	if (isdefined(self))
	{
		playfxontag (level._effect["powerup_on"], self, "tag_origin");
	}

	while (isdefined(self))
	{
		waittime = randomfloatrange(2.5, 5);
		yaw = RandomInt( 360 );
		if( yaw > 300 )
		{
			yaw = 300;
		}
		else if( yaw < 60 )
		{
			yaw = 60;
		}
		yaw = self.angles[1] + yaw;
		self rotateto ((-60 + randomint(120), yaw, -45 + randomint(90)), waittime, waittime * 0.5, waittime * 0.5);
		wait randomfloat (waittime - 0.1);
	}
}

powerup_timeout()
{
	self endon ("powerup_grabbed");

	wait 15;

	for (i = 0; i < 40; i++)
	{
		// hide and show
		if (i % 2)
		{
			self hide();
		}
		else
		{
			self show();
		}

		if (i < 15)
		{
			wait 0.5;
		}
		else if (i < 25)
		{
			wait 0.25;
		}
		else
		{
			wait 0.1;
		}
	}

	self notify ("powerup_timedout");
	self delete();
}

// kill them all!
nuke_powerup( drop_item )
{
	zombies = getaiarray("axis");

	PlayFx( drop_item.fx, drop_item.origin );
	//	players = get_players();
	//	array_thread (players, ::nuke_flash);
	level thread nuke_flash();

	zombies = get_array_of_closest( drop_item.origin, zombies );
	for (i = 0; i < zombies.size; i++)
	{
		wait (randomfloatrange(0.1, 0.7));
		if( !IsDefined( zombies[i] ) )
		{
			continue;
		}

		if( i < 5 )
		{
			zombies[i] thread animscripts\death::flame_death_fx();
		}

		zombies[i] maps\_zombiemode_spawner::zombie_head_gib();

		zombies[i] dodamage(zombies[i].health + 666, zombies[i].origin);
		playsoundatposition("nuked", zombies[i].origin);
	}

		players = get_players();

		for(i = 0; i < players.size; i++)
		{
			players[i].score += 400 * level.zombie_vars["zombie_point_scalar"];
			players[i].score_total += 400 * level.zombie_vars["zombie_point_scalar"];
			players[i] maps\_zombiemode_score::set_player_score_hud(); 
		}

}

nuke_flash()
{
	playsoundatposition("nuke_flash", (0,0,0));
	playsoundatposition("nuke_vox", (0,0,0));
	
	fadetowhite = newhudelem();

	fadetowhite.x = 0; 
	fadetowhite.y = 0; 
	fadetowhite.alpha = 0; 

	fadetowhite.horzAlign = "fullscreen"; 
	fadetowhite.vertAlign = "fullscreen"; 
	fadetowhite.foreground = true; 
	fadetowhite SetShader( "white", 640, 480 ); 

	// Fade into white
	fadetowhite FadeOverTime( 0.2 ); 
	fadetowhite.alpha = 0.8; 

	wait 0.5;
	fadetowhite FadeOverTime( 1.0 ); 
	fadetowhite.alpha = 0; 

	wait 1.1;
	fadetowhite destroy();
}

// double the points
double_points_powerup( drop_item )
{
	level notify ("powerup points scaled");
	level endon ("powerup points scaled");

	//	players = get_players();	
	//	array_thread(level,::point_doubler_on_hud, drop_item);
	level thread point_doubler_on_hud( drop_item );

	level.zombie_vars["zombie_point_scalar"] *= 2;

	wait 30;

	level.zombie_vars["zombie_point_scalar"] = 1;
}

full_ammo_powerup( drop_item )
{
	players = get_players();

	for (i = 0; i < players.size; i++)
	{
		primaryWeapons = players[i] GetWeaponsList(); 

		for( x = 0; x < primaryWeapons.size; x++ )
		{
			players[i] SetWeaponAmmoClip( primaryWeapons[x], WeaponClipSize( primaryWeapons[x] ) );
			players[i] GiveMaxAmmo( primaryWeapons[x], "stielhandgranate", 4 );

			if( players[i] hasweapon( "molotov" ) )
			{

				players[i] SetWeaponAmmoClip( "molotov", 4 );

			}	
		}
	}

//	array_thread (players, ::full_ammo_on_hud, drop_item);
	level thread full_ammo_on_hud( drop_item );
}

insta_kill_powerup( drop_item )
{
	level notify( "powerup instakill" );
	level endon( "powerup instakill" );

		
	//	array_thread (players, ::insta_kill_on_hud, drop_item);
	level thread insta_kill_on_hud( drop_item );

	level.zombie_vars["zombie_insta_kill"] = 1;
	wait( 30 );
	level.zombie_vars["zombie_insta_kill"] = 0;
	players = get_players();
	for(i = 0; i < players.size; i++)
	{
		players[i] notify("insta_kill_over");

	}

}

check_for_instakill( player )
{
	if( IsDefined( player ) && IsAlive( player ) && level.zombie_vars["zombie_insta_kill"])
	{
		self maps\_zombiemode_spawner::zombie_head_gib();
		self DoDamage( self.health + 666, self.origin, player );
	}
}

insta_kill_on_hud( drop_item )
{
	self endon ("disconnect");

	// check to see if this is on or not
	if ( level.zombie_vars["zombie_powerup_insta_kill_on"] )
	{
		// reset the time and keep going
		level.zombie_vars["zombie_powerup_insta_kill_time"] = 30;
		return;
	}

	level.zombie_vars["zombie_powerup_insta_kill_on"] = true;

	// set up the hudelem
	//hudelem = maps\_hud_util::createFontString( "objective", 2 );
	//hudelem maps\_hud_util::setPoint( "TOP", undefined, 0, level.zombie_vars["zombie_timer_offset"] + level.zombie_vars["zombie_timer_offset_interval"]);
	//hudelem.sort = 0.5;
	//hudelem.alpha = 0;
	//hudelem fadeovertime(0.5);
	//hudelem.alpha = 1;
	//hudelem.label = drop_item.hint;

	// set time remaining for insta kill
	level thread time_remaning_on_insta_kill_powerup();		

	// offset in case we get another powerup
	//level.zombie_timer_offset -= level.zombie_timer_offset_interval;
}

time_remaning_on_insta_kill_powerup()
{
	//self setvalue( level.zombie_vars["zombie_powerup_insta_kill_time"] );
	playsoundatposition ("insta_vox", (0,0,0));
	temp_enta = spawn("script_origin", (0,0,0));
	temp_enta playloopsound("insta_kill_loop");	

	/*
	players = get_players();
	for (i = 0; i < players.size; i++)
	{
	players[i] playloopsound ("insta_kill_loop");
	}
	*/

	// time it down!
	while ( level.zombie_vars["zombie_powerup_insta_kill_time"] >= 0)
	{
		wait 0.1;
		level.zombie_vars["zombie_powerup_insta_kill_time"] = level.zombie_vars["zombie_powerup_insta_kill_time"] - 0.1;
	//	self setvalue( level.zombie_vars["zombie_powerup_insta_kill_time"] );	
	}

	players = get_players();
	for (i = 0; i < players.size; i++)
	{
		//players[i] stoploopsound (2);

		players[i] playsound("insta_kill");

	}

	temp_enta stoploopsound(2);
	// turn off the timer
	level.zombie_vars["zombie_powerup_insta_kill_on"] = false;

	// remove the offset to make room for new powerups, reset timer for next time
	level.zombie_vars["zombie_powerup_insta_kill_time"] = 30;
	//level.zombie_timer_offset += level.zombie_timer_offset_interval;
	//self destroy();
	temp_enta delete();
}

point_doubler_on_hud( drop_item )
{
	self endon ("disconnect");

	// check to see if this is on or not
	if ( level.zombie_vars["zombie_powerup_point_doubler_on"] )
	{
		// reset the time and keep going
		level.zombie_vars["zombie_powerup_point_doubler_time"] = 30;
		return;
	}

	level.zombie_vars["zombie_powerup_point_doubler_on"] = true;
	//level.powerup_hud_array[0] = true;
	// set up the hudelem
	//hudelem = maps\_hud_util::createFontString( "objective", 2 );
	//hudelem maps\_hud_util::setPoint( "TOP", undefined, 0, level.zombie_vars["zombie_timer_offset"] );
	//hudelem.sort = 0.5;
	//hudelem.alpha = 0;
	//hudelem fadeovertime( 0.5 );
	//hudelem.alpha = 1;
	//hudelem.label = drop_item.hint;

	// set time remaining for point doubler
	level thread time_remaining_on_point_doubler_powerup();		

	// offset in case we get another powerup
	//level.zombie_timer_offset -= level.zombie_timer_offset_interval;
}
time_remaining_on_point_doubler_powerup()
{
	//self setvalue( level.zombie_vars["zombie_powerup_point_doubler_time"] );
	
	temp_ent = spawn("script_origin", (0,0,0));
	temp_ent playloopsound ("double_point_loop");
	
	playsoundatposition("dp_vox", (0,0,0));

	
	// time it down!
	while ( level.zombie_vars["zombie_powerup_point_doubler_time"] >= 0)
	{
		wait 0.1;
		level.zombie_vars["zombie_powerup_point_doubler_time"] = level.zombie_vars["zombie_powerup_point_doubler_time"] - 0.1;
		//self setvalue( level.zombie_vars["zombie_powerup_point_doubler_time"] );	
	}

	// turn off the timer
	level.zombie_vars["zombie_powerup_point_doubler_on"] = false;
	players = get_players();
	for (i = 0; i < players.size; i++)
	{
		//players[i] stoploopsound("double_point_loop", 2);
		players[i] playsound("points_loop_off");
	}
	temp_ent stoploopsound(2);


	// remove the offset to make room for new powerups, reset timer for next time
	level.zombie_vars["zombie_powerup_point_doubler_time"] = 30;
	//level.zombie_timer_offset += level.zombie_timer_offset_interval;
	//self destroy();
	temp_ent delete();
}

full_ammo_on_hud( drop_item )
{
	self endon ("disconnect");

	// set up the hudelem
	hudelem = maps\_hud_util::createFontString( "objective", 2 );
	hudelem maps\_hud_util::setPoint( "TOP", undefined, 0, level.zombie_vars["zombie_timer_offset"] - (level.zombie_vars["zombie_timer_offset_interval"] * 2));
	hudelem.sort = 0.5;
	hudelem.alpha = 0;
	hudelem fadeovertime(0.5);
	hudelem.alpha = 1;
	hudelem.label = drop_item.hint;

	// set time remaining for insta kill
	hudelem thread full_ammo_move_hud();		

	// offset in case we get another powerup
	//level.zombie_timer_offset -= level.zombie_timer_offset_interval;
}

full_ammo_move_hud()
{

	players = get_players();

	for (i = 0; i < players.size; i++)
	{
		players[i] playsound ("full_ammo");
		players[i] playsound ("ma_vox");
	}	
    
    wait 0.5;
    
	move_fade_time = 1.5;

	self FadeOverTime( move_fade_time ); 
	self MoveOverTime( move_fade_time );
	self.y = 270;
	self.alpha = 0;

	wait move_fade_time;

	self destroy();
}

//
// DEBUG
//

print_powerup_drop( powerup, type )
{
	/#
		if( !IsDefined( level.powerup_drop_time ) )
		{
			level.powerup_drop_time = 0;
			level.powerup_random_count = 0;
			level.powerup_score_count = 0;
		}

		time = ( GetTime() - level.powerup_drop_time ) * 0.001;
		level.powerup_drop_time = GetTime();

		if( type == "random" )
		{
			level.powerup_random_count++;
		}
		else
		{
			level.powerup_score_count++;
		}

		println( "========== POWER UP DROPPED ==========" );
		println( "DROPPED: " + powerup );
		println( "HOW IT DROPPED: " + type );
		println( "--------------------" );
		println( "Drop Time: " + time );
		println( "Random Powerup Count: " + level.powerup_random_count );
		println( "Random Powerup Count: " + level.powerup_score_count );
		println( "======================================" );
#/
}

death_check()
{
	//IPrintLn("death check init");
	self waittill_any( "fake_death", "death", "player_downed", "second_chance" );
	//IPrintLn("death check passed");

	self UnsetPerk( "specialty_armorvest" );
	self UnsetPerk( "specialty_quickrevive" );
	self UnsetPerk( "specialty_fastreload" );
	self UnsetPerk( "specialty_rof" );
	self UnsetPerk( "specialty_detectexplosive" );
	self UnsetPerk( "specialty_longersprint" );
	self UnsetPerk( "specialty_bulletaccuracy" );
	self UnsetPerk( "specialty_explosivedamage" );
	self UnsetPerk( "specialty_bulletdamage" );
	self perk_hud_destroy( "specialty_armorvest" );
	self perk_hud_destroy( "specialty_quickrevive" );
	self perk_hud_destroy( "specialty_fastreload" );
	self perk_hud_destroy( "specialty_rof" );
	self perk_hud_destroy( "specialty_detectexplosive" );
	self perk_hud_destroy( "specialty_longersprint" );
	self perk_hud_destroy( "specialty_bulletaccuracy" );
	self perk_hud_destroy( "specialty_explosivedamage" );
	self perk_hud_destroy( "specialty_bulletdamage" );
	self.maxhealth = 100;
	self SetMoveSpeedScale(1);
	self setClientDvar( "perk_sprintMultiplier", "1" ); 
		
	wait( 0.01 );

	self.perknum = 0;
}

perk_hud_create( perk )
{
	if ( !IsDefined( self.perk_hud ) )
	{
		self.perk_hud = [];
	}

	/#
		if ( GetDVarInt( "zombie_cheat" ) >= 5 )
		{
			if ( IsDefined( self.perk_hud[ perk ] ) )
			{
				return;
			}
		}
	#/

		shader = "";

		switch( perk )
		{
		case "specialty_armorvest":
			shader = "specialty_juggernaut_zombies";
			break;

		case "specialty_quickrevive":
			shader = "specialty_quickrevive_zombies";
			break;

		case "specialty_fastreload":
			shader = "specialty_fastreload_zombies";
			break;

		case "specialty_rof":
			shader = "specialty_doubletap_zombies";
			break;
			
		case "specialty_detectexplosive":
			shader = "specialty_phd_zombies";
			break;
			
		case "specialty_longersprint":
			shader = "specialty_longersprint_zombies";
			break;
			
		case "specialty_bulletaccuracy":
			shader = "specialty_aim_zombies";
			break;
			
		case "specialty_explosivedamage":
			shader = "specialty_fireworks_zombies";
			break;

		case "specialty_bulletdamage":
			shader = "specialty_sp_zombies";
			break;

		default:
			shader = "";
			break;
		}

		hud = create_simple_hud( self );
		hud.foreground = true; 
		hud.sort = 1; 
		hud.hidewheninmenu = false; 
		hud.alignX = "left"; 
		hud.alignY = "bottom";
		hud.horzAlign = "left"; 
		hud.vertAlign = "bottom";
		hud.x = self.perk_hud.size * 30; 
		hud.y = hud.y - 70; 
		hud.alpha = 1;
		hud SetShader( shader, 24, 24 );

		self.perk_hud[ perk ] = hud;
}

perk_hud_destroy( perk )
{
	self.perk_hud[ perk ] destroy_hud();
	self.perk_hud[ perk ] = undefined;
}

play_no_money_perk_dialog()
{
	
	index = maps\_zombiemode_weapons::get_player_index(self);
	
	player_index = "plr_" + index + "_";
	if(!IsDefined (self.vox_nomoney_perk))
	{
		num_variants = maps\_zombiemode_spawner::get_number_variants(player_index + "vox_nomoney_perk");
		self.vox_nomoney_perk = [];
		for(i=0;i<num_variants;i++)
		{
			self.vox_nomoney_perk[self.vox_nomoney_perk.size] = "vox_nomoney_perk_" + i;	
		}
		self.vox_nomoney_perk_available = self.vox_nomoney_perk;		
	}	
	sound_to_play = random(self.vox_nomoney_perk_available);
	
	self.vox_nomoney_perk_available = array_remove(self.vox_nomoney_perk_available,sound_to_play);
	
	if (self.vox_nomoney_perk_available.size < 1 )
	{
		self.vox_nomoney_perk_available = self.vox_nomoney_perk;
	}
			
	self maps\_zombiemode_spawner::do_player_playdialog(player_index, sound_to_play, 0.25);
	
	
		
	
}

play_no_money_purchase_dialog()
{
	
	index = maps\_zombiemode_weapons::get_player_index(self);
	
	player_index = "plr_" + index + "_";
	if(!IsDefined (self.vox_gen_sigh))
	{
		num_variants = maps\_zombiemode_spawner::get_number_variants(player_index + "vox_gen_sigh");
		self.vox_gen_sigh = [];
		for(i=0;i<num_variants;i++)
		{
			self.vox_gen_sigh[self.vox_gen_sigh.size] = "vox_gen_sigh_" + i;	
		}
		self.vox_gen_sigh_available = self.vox_gen_sigh;		
	}
	rand = randomintrange(0,6);
	if(rand < 3)
	{
		sound_to_play = random(self.vox_gen_sigh_available);		
		self.vox_gen_sigh_available = array_remove(self.vox_gen_sigh_available,sound_to_play);
		if (self.vox_gen_sigh_available.size < 1 )
		{
			self.vox_gen_sigh_available = self.vox_gen_sigh;
		}
		wait(0.25);
		self maps\_zombiemode_spawner::do_player_playdialog(player_index, sound_to_play, 0.25);
	}
	
		
	
}