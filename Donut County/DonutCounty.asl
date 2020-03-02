state("DonutCounty") {
	int level: "UnityPlayer.dll", 0x149E6B0;
}

startup {
	settings.Add("splits", true, "Choose the Levels to split after:");
		settings.Add("241", true, "Mira's House", "splits");
		settings.Add("435", true, "Potter's Rock", "splits");
		settings.Add("489", true, "Ranger Station", "splits");
		settings.Add("163", true, "Riverbed", "splits");
		settings.Add("175", true, "Campground", "splits");
		settings.Add("207", true, "Hopper Springs", "splits");
		settings.Add("173", true, "Joshua Tree", "splits");
		settings.Add("97", true, "Beach Lot C", "splits");
		settings.Add("235", true, "Gecko Park", "splits");
		settings.Add("191", true, "Chicken Barn", "splits");
		settings.Add("141", true, "Honey Nut Forest", "splits");
		settings.Add("393", true, "Cat Soup", "splits");
		settings.Add("201", true, "Donut Shop", "splits");
		settings.Add("215", true, "Abandoned House", "splits");
		settings.Add("291", true, "Raccoon Lagoon", "splits");
		settings.Add("499", true, "The 405", "splits");
		settings.Add("35", false, "Above Donut County", "splits");
		settings.Add("63", false, "Raccoon HQ", "splits");
		settings.Add("183", true, "Biology Lab", "splits");
		settings.Add("165", true, "Anthropology Lab", "splits");
		settings.Add("51", false, "Trash King's Office", "splits");
}

split {
	if (current.level != old.level) {
		print("got " + old.level + " with setting: " + settings[old.level.ToString()]);
		return (settings[old.level.ToString()]);
	}
}