main()
{
self setModel("char_usa_marine_player_body2_1");
self.headModel = "char_usa_marine_head4_2";
self attach(self.headModel, "", true);
self.hatModel = "char_usa_marine_helm1";
self attach(self.hatModel);
self.gearModel = "char_usa_raider_gear4";
self attach(self.gearModel);
self.voice = "american";
}

precache()
{
precacheModel("char_usa_marine_player_body2_1");
precacheModel("char_usa_marine_head4_2");
precacheModel("char_usa_marine_helm1");
precacheModel("char_usa_raider_gear4");
}
