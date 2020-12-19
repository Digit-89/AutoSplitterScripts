/*
 * LevelSettings : "mono.dll", 0x298AE8, 0x20, 0x400, 0xD8   * RM : "mono.dll", 0x298AE8, 0x20, 0x400
 * * 0x18 : deliveryData (OS1Delivery),                      * * 0x30 : holePos.x (float),
 *   * 0x18, 0x14 : customerLocation.Value (string),         * * 0x34 : holePos.y (float),
 *   * 0x48, 0x14 : scene.Value (string),                    * * 0x38 : holePos.z (float)
 *   * 0x71       : completesGame (bool),                    *
 *   * 0x8C       : index (int)                              * HoleContents : "mono.dll", 0x298AE8, 0x20, 0x400, 0x10
 *                  *  0 = Mira's House,                     * * 0x70 : water (bool),
 *                  *  1 = Donut Shop,                       * * 0x71 : fire (bool),
 *                  *  2 = Potter's Rock,                    * * 0x72 : temporaryFire (bool),
 *                  *  3 = Ranger Station,                   * * 0x73 : preLaunchAbility (bool),
 *                  *  4 = LOCATION_RIVER,                   * * 0x74 : numBunnies (int),
 *                  *  5 = Campground,                       * * 0x78 : addedBunnies (bool),
 *                  *  6 = Hopper Springs,                   * * 0x79 : inLaunchSequence (bool)
 *                  *  7 = Joshua Tree,                      *
 *                  *  8 = Bu Beach Lot C,                   * HoleScale : "mono.dll", 0x298AE8, 0x20, 0x400, 0x18
 *                  *  9 = Gecko Park,                       * * 0x3C : targetScale (float),
 *                  * 10 = Chicken Barn,                     * * 0x40 : scaleFlag (int),
 *                  * 11 = Honey Nut Forest,                 *          * ? = ?
 *                  * 12 = Cat Soup,                         * * 0x50 : hidden (bool),
 *                  * 13 = Donut Shop,                       * * 0x58 : currentScale (float)
 *                  * 14 = Abandoned House,                  *
 *                  * 15 = Raccoon Lagoon,                   * SoupManager : "mono.dll", 0x298AE8, 0x20, 0x400, 0x58
 *                  * 16 = The 405,                          * * 0x28 : hasBroth (bool),
 *                  * 17 = Above Donut County,               * * 0x29 : hasSalt (bool),
 *                  * 18 = Raccoon HQ Exterior,              * * 0x2A : hasPepper (bool),
 *                  * 19 = Raccoon HQ,                       * * 0x2B : isBad (bool)
 *                  * 20 = Biology Lab,                      *
 *                  * 21 = Raccoon HQ,                       * SceneManager : "mono.dll", 0x298AE8, 0x20, 0x400, 0xB8
 *                  * 22 = Anthropology Lab,                 * * 0x20, 0x14 : nextLevel.Value (string),
 *                  * 23 = Raccoon HQ,                       * * 0x30       : loading (bool),
 *                  * 24 = Trash King's Office,              * * 0x32       : isLoadingScene (bool)
 *                  * 25 = HQ Attack,                        *
 *                  * 26 = Catapult,                         * AbilitiesManager : "mono.dll", 0x298AE8, 0x20, 0x400, 0xE0
 *                  * 27 = Donut Shop                        * * 0x18 launchUnlocked (bool),
 * * 0x64 : locationType (int),                              * * 0x19 launchForceLocked (bool),
 *          * 0 = Day,                                       * * 0x1A setup (bool)
 *          * 1 = Location,                                  *
 *          * 2 = Underground,                               * Tornado : "mono.dll", 0x298AE8, 0x20, 0x400, 0xF0
 *          * 3 = App                                        * * 0xC0 : numRotorsRequired (int),
 * * 0x93 : throwUnlocked (bool),                            * * 0xC4 : numRotors (int),
 * * 0xB5 : isPlaying (bool)                                 * * 0xCC : numDestructablesRequired (int),
 *                                                           * * 0xD0 : numDestructables (int)
 * Game : "mono.dll", 0x298AE8, 0x20, 0x400, 0x138
 * * 0x44 : numCollectibles (int),
 * * 0x48 : numCollected (int),
 * * 0x4C : win (bool)
 */

state("DonutCounty") {
	string50 sceneName       : "mono.dll", 0x298AE8, 0x20, 0x400, 0xB8, 0x20, 0x14;
	bool loading             : "mono.dll", 0x298AE8, 0x20, 0x400, 0xB8, 0x30;
	bool isLoadingScene      : "mono.dll", 0x298AE8, 0x20, 0x400, 0xB8, 0x32;
	int levelIndex           : "mono.dll", 0x298AE8, 0x20, 0x400, 0xD8, 0x18, 0x8C;
	int tornadoDestructables : "mono.dll", 0x298AE8, 0x20, 0x400, 0xF0, 0xD0;
}

startup {
	vars.completedAreas = new HashSet<int>();
	var tB = (Func<string, string, bool, string, Tuple<string, string, bool, string>>) ((elmt1, elmt2, elmt3, emlt4) => { return Tuple.Create(elmt1, elmt2, elmt3, emlt4); });
	var sB = new List<Tuple<string, string, bool, string>> {
		tB("splits", "Mira's House", true, "mira"),
			tB("mira", "Duck on a Scooter", false, "0"),
			tB("mira", "BK talking to Mira", true, "1"),
		tB("splits", "Potter's Rock", true, "2"),
		tB("splits", "Ranger Station", true, "3"),
		tB("splits", "Riverbed", true, "4"),
		tB("splits", "Campground", true, "5"),
		tB("splits", "Hopper Springs", true, "6"),
		tB("splits", "Joshua Tree", true, "7"),
		tB("splits", "Beach Lot C", true, "8"),
		tB("splits", "Gecko Park", true, "9"),
		tB("splits", "Chicken Barn", true, "10"),
		tB("splits", "Honey Nut Forest", true, "11"),
		tB("splits", "Cat Soup", true, "12"),
		tB("splits", "Donut Shop", true, "13"),
		tB("splits", "Abandoned House", true, "14"),
		tB("splits", "Raccoon Lagoon", true, "15"),
		tB("splits", "The 405", true, "16"),
		tB("splits", "Above Donut County", false, "17"),
		tB("splits", "Raccoon HQ Exterior", false, "18"),
		tB("splits", "Biology Lab", true, "20"),
		tB("splits", "Anthropology Lab", true, "22"),
		tB("splits", "Trash King's Office", false, "24")
	};

	settings.Add("splits", true, "Split after completing levels:");

	foreach (var s in sB) settings.Add(s.Item4, s.Item3, s.Item2, s.Item1);
}

start {
	if (old.sceneName != current.sceneName && old.sceneName == "titlescreen" && current.sceneName != "scn_credits") {
		vars.completedAreas.Clear();
		return true;
	}
}

split {
	if (old.levelIndex != current.levelIndex && !vars.completedAreas.Contains(old.levelIndex)) {
		vars.completedAreas.Add(old.levelIndex);
		return settings[old.levelIndex.ToString()];
	}

	return old.tornadoDestructables == 3 && current.tornadoDestructables == 4;
}

reset {
	return old.sceneName != current.sceneName && current.sceneName == "titlescreen";
}

isLoading {
	return current.loading || current.isLoadingScene;
}
