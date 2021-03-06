state("Alba") {
	int activeStage : "UnityPlayer.dll", 0x18053A8, 0x48, 0x178, 0x78, 0x148, 0xD0, 0x30, 0x70, 0x0, 0x48;
	float igt       : "UnityPlayer.dll", 0x18053A8, 0x48, 0x178, 0x78, 0x148, 0xD0, 0x30, 0x70, 0x0, 0x54;
	int goalCount   : "mono-2.0-bdwgc.dll", 0x494A90, 0xD00, 0x0, 0x250, 0x40, 0x10, 0x30, 0x18;
}

startup {
	vars.stopWatch = new Stopwatch();

	var tB = (Func<string, string, string, Tuple<string, string, string>>) ((elmt1, elmt2, elmt3) => { return Tuple.Create(elmt1, elmt2, elmt3); });
	var questSettings = new List<Tuple<string, string, string>> {
		tB("Main Quests", "QT_GetCameraGrandad", "Take Granddad's phone (Prologue)"),
		tB("Main Quests", "QG_Explore_with_Ines", "Explore with Inés"),
			tB("QG_Explore_with_Ines", "QT_Follow_Ines_to_the_Paella_in_the_resturant", "Follow Inés to the Paella in the restaurant"),
			tB("QG_Explore_with_Ines", "QT_Follow_Ines_to_the_Ancient_Ruins", "Follow Inés to the Ancient Ruins"),
		tB("Main Quests", "QG_Dolphin_Rescue", "Dolphin Rescue"),
			tB("QG_Dolphin_Rescue", "QT_Investigate_the_stranded_dolphin", "Investigate the stranded dolphin"),
			tB("QG_Dolphin_Rescue", "QT_Find_people_to_help_save_the_dolphin", "Find people to help save the dolphin"),
			tB("QG_Dolphin_Rescue", "QT_Return_the_dolphin_to_the_sea", "Return the dolphin to the sea"),
		tB("Main Quests", "QT_Scan_Sparrow", "Scan the Sparrow"),
		tB("Main Quests", "QT_Find_the_Mayor_at_the_Nature_Reserve", "Find the Mayor at the Nature Reserve"),
		tB("Main Quests", "QG_Nature_Reserve", "Nature Reserve"),
			tB("QG_Nature_Reserve", "QT_Explore_the_Nature_Reserve", "Explore the Nature Reserve"),
			tB("QG_Nature_Reserve", "QT_Take_a_photo_of_the_Shoveler", "Take a photo of the Shoveler"),
			tB("QG_Nature_Reserve", "QT_Talk_to_the_Carpenter_in_town", "Talk to the Carpenter in town"),
			tB("QG_Nature_Reserve", "QT_Fix_the_bridge_in_the_Nature_Reserve", "Fix the bridge in the Nature Reserve"),
			tB("QG_Nature_Reserve", "QT_Scan_a_Grey_Heron_in_the_Nature_Reserve", "Scan a Grey Heron in the Nature Reserve"),
			tB("QG_Nature_Reserve", "QT_Put_Heron_photo_on_sign_in_Nature_Reserve", "Put Heron photo on sign in Nature Reserve"),
			tB("QG_Nature_Reserve", "QT_Clean_up_the_Nature_Reserve", "Clean up the Nature Reserve"),
			tB("QG_Nature_Reserve", "QT_Fix_Carpenter_Birdbox", "Fix Carpenter Birdbox"),
		tB("Main Quests", "QG_Mysterious_Goo", "Mysterious Goo"),
			tB("QG_Mysterious_Goo", "QT_Follow_the_trail_of_green_goo", "Follow the trail of green goo"),
			tB("QG_Mysterious_Goo", "QT_Ask_the_vet_in_town_for_help", "Ask the vet in town for help"),
			tB("QG_Mysterious_Goo", "QT_Meet_the_vet_at_the_sick_squirrel", "Meet the vet at the sick squirrel"),
			tB("QG_Mysterious_Goo", "QT_Find_and_heal_sick_animals_nearby", "Find and heal sick animals nearby"),
			tB("QG_Mysterious_Goo", "QT_Talk_to_the_Vet_in_town", "Talk to the Vet in town on the next day"),
			tB("QG_Mysterious_Goo", "QT_Follow_the_trail_of_sick_animals", "Follow the trail of sick animals"),
			tB("QG_Mysterious_Goo", "QT_Find_the_farm_the_pesticides_came_from", "Find the farm the pesticides came from"),
			tB("QG_Mysterious_Goo", "QT_Heal_the_farmers_sick_cat", "Heal the farmer's sick cat"),
		tB("Main Quests", "QG_Castle", "Castle"),
			tB("QG_Castle", "QT_Meet_Grandpa_at_the_Castle", "Meet Grandpa at the Castle"),
			tB("QG_Castle", "QT_Fix_the_wooden_stairs_in_the_Castle", "Fix the wooden stairs in the Castle"),
			tB("QG_Castle", "QT_Scan_the_Eagle_from_the_Castle_walls", "Scan the Eagle from the Castle walls"),
		tB("Main Quests", "QG_The_Lynx", "The Lynx"),
			tB("QG_The_Lynx", "QT_Meet_Ines_at_the_Chicken_Farm", "Meet Inés at the Chicken Farm"),
			tB("QG_The_Lynx", "QT_Find_where_the_Lynx_went", "Find where the Lynx went"),
			tB("QG_The_Lynx", "QT_Follow_the_Lynxs_trail_near_the_Farm", "Follow the Lynxs trail near the Farm"),
			tB("QG_The_Lynx", "QT_Talk_to_Ines_outside_the_Lynxs_den", "Talk to Inés outside the Lynxs den"),
			tB("QG_The_Lynx", "QT_Repair_the_Chicken_Farm_Fence", "Repair the Chicken Farm Fence"),
			tB("QG_The_Lynx", "QT_Scan_the_Fox", "Scan the Fox"),
		tB("Main Quests", "QG_ReturnToDolphinIsland", "Return to La Roqueta (Dolphin)"),
			tB("QG_ReturnToDolphinIsland", "QT_ClaraDolphinBoat", "Get on the boat"),
			tB("QG_ReturnToDolphinIsland", "QT_ClaraDolphin", "Take a photo of the dolphin"),
		tB("Main Quests", "QG_Cleanup_North_Beach", "Clean up North Beach"),
			tB("QG_Cleanup_North_Beach", "QT_IllegalDump_Meet_Juanito", "Meet Juanito"),
			tB("QG_Cleanup_North_Beach", "QT_IllegalDump_Heal_the_Animals", "Heal the Animals"),
			tB("QG_Cleanup_North_Beach", "QT_IllegalDump_Clean_the_Rubbish", "Clean the Rubbish"),
		tB("Main Quests", "QT_Talk_to_the_Mayor_in_town", "Talk to the Mayor in town"),
		tB("Main Quests", "QG_Mayor_Investigation", "Mayor Investigation"),
			tB("QG_Mayor_Investigation", "QT_Follow_Ines_to_find_the_Mayor", "Follow Inés to find the Mayor"),
			tB("QG_Mayor_Investigation", "QT_Scan_the_Mayor_1", "Scan the Mayor 1"),
			tB("QG_Mayor_Investigation", "QT_Scan_the_Mayor_2", "Scan the Mayor 2"),
			tB("QG_Mayor_Investigation", "QT_Scan_the_Mayor_3", "Scan the Mayor 3"),
			tB("QG_Mayor_Investigation", "QT_Scan_the_Mayor_4", "Scan the Mayor 4"),
			tB("QG_Mayor_Investigation", "QT_Use_the_Scanner_to_see_whats_in_the_briefcase", "Use the Scanner to see whats in the briefcase"),
		tB("Main Quests", "QT_Scan_the_Lynx", "Scan the Lynx"),
		tB("Main Quests", "QG_Summer_Festival", "Summer Festival"),
			tB("QG_Summer_Festival", "QT_Summer_Festival_Enjoy", "Summer Festival Enjoy"),
			tB("QG_Summer_Festival", "QT_Summer_Festival", "Summer Festival"),

		tB("Side Quests", "QG_Nature_Reserve_SQ", "Nature Reserve"),
			tB("QG_Nature_Reserve_SQ", "QT_Fix_up_the_old_Nature_Reserve", "Fix up the old Nature Reserve"),
			tB("QG_Nature_Reserve_SQ", "QT_Replace_damaged_photos_on_signs_in_Nature_Reserve", "Replace damaged photos on signs in Nature Reserve"),
		tB("Side Quests", "QG_Animals_Discovered", "Animals Discovered"),
			tB("QG_Animals_Discovered", "QT_ScanAnimals1", "Scan 5 Animals"),
			tB("QG_Animals_Discovered", "QT_ScanAnimals2", "Scan 12 Animals"),
			tB("QG_Animals_Discovered", "QT_ScanAnimals3", "Scan 20 Animals"),
			tB("QG_Animals_Discovered", "QT_ScanAnimals4", "Scan 30 Animals"),
			tB("QG_Animals_Discovered", "QT_ScanAnimals5", "Scan 40 Animals"),
			tB("QG_Animals_Discovered", "QT_ScanAnimals6", "Scan 50 Animals"),
			tB("QG_Animals_Discovered", "QT_ScanAnimals7", "Scan 61 Animals"),
		tB("Side Quests", "QG_Animal_SIgn", "Photo Signs"),
			tB("QG_Animal_SIgn", "QT_RiceFields_WildlifeSIgn", "Rice Fields"),
			tB("QG_Animal_SIgn", "QT_Forest_WildlifeSIgn", "Forest"),
			tB("QG_Animal_SIgn", "QT_Castle_WildlifeSign", "Castle"),
			tB("QG_Animal_SIgn", "QT_Terraces_WildlifeSIgn", "Terraces"),
			tB("QG_Animals_Discovered", "QT_All_Animals_Photographed", "All Animals Photographed"),
		tB("Side Quests", "QG_WildlifeRescue", "Wildlife Rescue"),
			tB("QG_WildlifeRescue", "QT_Heal_birds_covered_in_oil_on_East_Beach", "Heal birds covered in oil on East Beach"),
			tB("QG_WildlifeRescue", "QT_Help_animals_caught_in_trash_on_Mountain", "Help animals caught in trash on Mountain"),
		tB("Side Quests", "QG_Cleanup_Island", "Clean up Island"),
			tB("QG_Cleanup_Island", "QT_Recycle_Encounters", "Pick up Rubbish"),
			tB("QG_Cleanup_Island", "QT_Recycle_Encounter_TownBeach", "Town Beach"),
			tB("QG_Cleanup_Island", "QT_Recycle_Encounter_TownPromenade", "Town Promenade"),
			tB("QG_Cleanup_Island", "QT_Recycle_Encounter_MarshBeach", "Marsh Beach"),
			tB("QG_Cleanup_Island", "QT_Recycle_Encounter_Woods", "Woods"),
			tB("QG_Cleanup_Island", "QT_Recycle_Encounter_Mountain", "Mountain"),
			tB("QG_Cleanup_Island", "QT_Recycle_Encounter_DolphinIsland", "La Roqueta"),
		tB("Side Quests", "QG_Clara_Animal_Seeking", "Clara Animal Seeking"),
			tB("QG_Clara_Animal_Seeking", "QT_Take_a_photo_of_the_Sparrowhawks_near_town", "Take a photo of the Sparrowhawks near town"),
			tB("QG_Clara_Animal_Seeking", "QT_ClaraHoopoe", "Take a photo of a Hoopoe"),
			tB("QG_Clara_Animal_Seeking", "QT_ClaraGlossyIbis", "Take a photo of a Glossy Ibis"),
		tB("Side Quests", "QT_Finish_fixing_Castle", "Finish fixing Castle"),
		tB("Side Quests", "QT_Scan_the_Owl", "Scan the Owl at the construction site"),
		tB("Side Quests", "QT_TellPepeLolaHasFreeIceCream", "Tell Pepe Lola has free Ice Cream"),
		tB("Side Quests", "QG_Marina_and_Socks", "Marina and Socks"),
			tB("QG_Marina_and_Socks", "QT_Find_lost_dog", "Find lost dog"),
			tB("QG_Marina_and_Socks", "QT_Return_lost_dog_to_owner", "Return lost dog to owner")
	};

	settings.Add("dayEnd", true, "Split when the next day starts");
		settings.SetToolTip("dayEnd", "This splits when the player is able to\nperform the first input on the next day.");
	settings.Add("Main Quests");
	settings.Add("Side Quests");

	foreach (var q in questSettings) settings.Add(q.Item2, false, q.Item3, q.Item1);
}

init {
	vars.stopWatch.Restart();
	while (current.goalCount == 0)
		if (vars.stopWatch.ElapsedMilliseconds >= 1000) throw new Exception("Game has not fully initialized yet!");

	vars.taskCompletionWatchers = new MemoryWatcherList();
	vars.taskMaxWatchers = new MemoryWatcherList();
	IntPtr currQuest = IntPtr.Zero;
	for (int questID = 0; questID < current.goalCount; ++questID) {
		new DeepPointer("mono-2.0-bdwgc.dll", 0x494A90, 0xD00, 0x0, 0x250, 0x40, 0x10, 0x30, 0x10, 0x20 + questID * 0x8).DerefOffsets(game, out currQuest);
		var taskCount = new MemoryWatcher<int>(new DeepPointer(currQuest, 0x30, 0x18)); taskCount.Update(game);

		for (int taskID = 0; taskID < taskCount.Current; ++taskID) {
			var taskName = new StringWatcher(new DeepPointer(currQuest, 0x30, 0x10, 0x20 + taskID * 0x8, 0x18, 0x14), 120); taskName.Update(game);
			vars.taskMaxWatchers.Add(new MemoryWatcher<int>(new DeepPointer(
				"mono-2.0-bdwgc.dll", 0x494A90, 0xD00, 0x0, 0x250, 0x40, 0x10, 0x30, 0x10, 0x20 + questID * 0x8, 0x30, 0x10, 0x20 + taskID * 0x8, 0x28))
				{Name = taskName.Current}
			);

			vars.taskCompletionWatchers.Add(new MemoryWatcher<float>(new DeepPointer(
				"mono-2.0-bdwgc.dll", 0x494A90, 0xD00, 0x0, 0x250, 0x40, 0x10, 0x30, 0x10, 0x20 + questID * 0x8, 0x30, 0x10, 0x20 + taskID * 0x8, 0x2C))
				{Name = taskName.Current}
			);
		}
	}
}

start {
	return old.igt == 0.0 && current.igt > 0.0;
}

split {
	vars.taskMaxWatchers.UpdateAll(game);
	vars.taskCompletionWatchers.UpdateAll(game);
	foreach (var task in vars.taskCompletionWatchers)
		if (task.Changed) {
			int taskMax = vars.taskMaxWatchers[task.Name].Current;
			int taskCurr = Math.Floor(task.Current);
			return taskCurr == taskMax && settings[task.Name];
		}

	return current.activeStage == old.activeStage + 1 && settings["dayEnd"];
}

reset {
	return current.igt == 0.0 && old.igt > 0.0;
}

gameTime {
	return TimeSpan.FromSeconds(current.igt);
}

isLoading {
	return true;
}
