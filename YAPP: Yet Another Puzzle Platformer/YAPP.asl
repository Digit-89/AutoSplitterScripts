state("yapp") {
	int location          : "mono.dll", 0x263110, 0xA0, 0x20, 0x30;
	//int xPos              : "mono.dll", 0x263110, 0xA0, 0x20, 0x38;
	//int yPos              : "mono.dll", 0x263110, 0xA0, 0x20, 0x3C;
	//string1800 dataString : "mono.dll", 0x263110, 0xA0, 0x28, 0x14;
}

startup {
	vars.tM = new TimerModel {CurrentState = timer};

	vars.startIndex = new Dictionary<int, int> {
		{1, 10},
		{2, 20},
		{3, 30},
		{4, 40},
		{5, 50},
		{6, 60},
		{7, 70},
	};

	for (int wrld = 1; wrld <= 7; ++wrld) {
		string header = "World " + wrld + " Splits:";
		settings.Add(header);
		for (int lvl = 1; lvl <= 8; ++lvl)
			settings.Add("l" + (vars.startIndex[wrld] + lvl), true, lvl == 8 ? "Castle" : "Level " + lvl, header);
	}
}

init {
	vars.solvedWatchers = new MemoryWatcherList();

	for (int wrld = 1; wrld <= 7; ++wrld)
		for (int lvl = 1; lvl <= 8; ++lvl)
			vars.solvedWatchers.Add(new MemoryWatcher<bool>(new DeepPointer("mono.dll", 0x263110, 0xA0, 0x20, 0x10, 0x20 + vars.startIndex[wrld] + lvl)) {Name = "l" + (vars.startIndex[wrld] + lvl).ToString()});
}

start {
	return old.location == 1 && current.location == 2;
}

split {
	vars.solvedWatchers.UpdateAll(game);
	foreach (var watcher in vars.solvedWatchers)
		if (watcher.Changed && watcher.Current)
			return settings[watcher.Name];
}

reset {
	return old.location == 2 && current.location == 1;
}

exit {
	vars.tM.Reset();
}
