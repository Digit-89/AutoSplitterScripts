state("A Proof of Concept 1.1") {
	int room: 0x6C2DB8;
	//int time: 0x6C2DE0;
}

state("Concept - v2.0") {
	int room: 0x6FFF60;
}

startup {
	var tB = (Func<string, string, bool, string, Tuple<string, string, bool, string>>) ((elmt1, elmt2, elmt3, elmt4) => { return Tuple.Create(elmt1, elmt2, elmt3, elmt4); });
	var sB = new List<Tuple<string, string, bool, string>> {
		tB("v2.0", "libSplits2.0", false, "Split when going anywhere from Library:"),
			tB("libSplits2.0", "2.0-10to5", false, "Enter Museum from Library"),
			tB("libSplits2.0", "2.0-19to11", false, "Enter Main Frame from Library"),
			tB("libSplits2.0", "2.0-19to17", false, "Enter Power Plant from Library"),
			tB("libSplits2.0", "2.0-19to12", false, "Enter Gravitational Management from Library"),
			tB("libSplits2.0", "2.0-19to1", false, "Enter SA * RC from Library"),
			tB("libSplits2.0", "2.0-19to21", false, "Enter Woods from Library"),
			tB("libSplits2.0", "2.0-19to15", false, "Enter Great Door from Library"),
		tB("v2.0", "libBackSplits2.0", false, "Splits when arriving back in Library:"),
			tB("libBackSplits2.0", "2.0-10to19", false, "Leave Museum to Library"),
			tB("libBackSplits2.0", "2.0-11to19", false, "Leave Main Frame to Library"),
			tB("libBackSplits2.0", "2.0-16to19", false, "Leave Back Door level to Library"),
			tB("libBackSplits2.0", "2.0-17to19", false, "Leave Power Plant to Library"),
			tB("libBackSplits2.0", "2.0-29to19", false, "Leave Centrifuge to Library"),
			tB("libBackSplits2.0", "2.0-18to19", false, "Leave Event Horizon to Library"),
			tB("libBackSplits2.0", "2.0-8to19", false, "Leave Continuum to Library"),
			tB("libBackSplits2.0", "2.0-2to19", false, "Leave Warp Machine to Library"),
			tB("libBackSplits2.0", "2.0-21to19", false, "Leave Woods to Library"),
		tB("v2.0", "inLevelSplits2.0", false, "In-Level Splits:"),
			tB("inLevelSplits2.0", "2.0-15to13", false, "Enter Archive from Big Orb Room"),
			tB("inLevelSplits2.0", "frameSplits2.0", false, "Splits in Mainframe:"),
				tB("frameSplits2.0", "2.0-11to13", false, "Enter second half of Main Frame"),
				tB("frameSplits2.0", "2.0-13to15", false, "Enter Back Door Corridor from Main Frame"),
				tB("frameSplits2.0", "2.0-15to16", false, "Enter Back Door level from Corridor"),
			tB("inLevelSplits2.0", "centSplits2.0", false, "Splits in Mainframe:"),
				tB("centSplits2.0", "2.0-12to29", false, "Enter Centrifuge from Gravitational Management"),
				tB("centSplits2.0", "2.0-29to2", false, "Enter Warp Machine from Centrifuge"),
			tB("inLevelSplits2.0", "eventSplits2.0", false, "Splits in Event Horizon:"),
				tB("eventSplits2.0", "2.0-1to18", false, "Enter Event Horizon from SA * RC"),
				tB("eventSplits2.0", "2.0-1to3", false, "Enter Professor's lab from SA * RC"),
				tB("eventSplits2.0", "2.0-3to8", false, "Enter Continuum from lab"),

		tB("v1.1", "libSplits1.1", false, "Split when going anywhere from Library:"),
			tB("libSplits1.1", "1.1-12to5", false, "Enter Museum from Library"),
			tB("libSplits1.1", "1.1-12to6", false, "Enter Main Frame from Library"),
			tB("libSplits1.1", "1.1-12to11", false, "Enter Power Plant from Library"),
			tB("libSplits1.1", "1.1-12to14", false, "Enter Woods from Library"),
			tB("libSplits1.1", "1.1-12to15", false, "Enter Great Door from Library"),
		tB("v1.1", "libBackSplits1.1", false, "Splits when arriving back in Library:"),
			tB("libBackSplits1.1", "1.1-5to12", false, "Leave Museum to Library"),
			tB("libBackSplits1.1", "1.1-7to12", false, "Leave Main Frame to Library"),
			tB("libBackSplits1.1", "1.1-10to12", false, "Leave Back Door level to Library"),
			tB("libBackSplits1.1", "1.1-11to12", false, "Leave Power Plant to Library"),
			tB("libBackSplits1.1", "1.1-14to12", false, "Leave Woods to Library"),
		tB("v1.1", "inLevelSplits1.1", false, "Other Splits:"),
			tB("inLevelSplits1.1", "1.1-15to13", false, "Enter Archive from Big Orb Room"),
			tB("inLevelSplits1.1", "frameSplits1.1", false, "Splits in Mainframe:"),
				tB("frameSplits1.1", "1.1-6to7", false, "Enter second half of Main Frame"),
				tB("frameSplits1.1", "1.1-7to9", false, "Enter Back Door Corridor from Main Frame"),
				tB("frameSplits1.1", "1.1-9to10", false, "Enter Back Door level from Corridor")
	};

	settings.Add("v2.0", false, "Splits for version 2.0:");
	settings.Add("v1.1", false, "Splits for version 1.1:");

	foreach (var s in sB) settings.Add(s.Item2, s.Item3, s.Item4, s.Item1);
}

update {
	if (old.room != current.room) print(old.room + "-" + current.room);
}

init {
	switch (game.ProcessName) {
		case "A Proof of Concept 1.1": vars.ver = "1.1"; break;
		case "Concept - v2.0": vars.ver = "2.0"; break;
	}
}

start {
	switch ((string)vars.ver) {
		case "1.1": return old.room == 1 && current.room == 4;
		case "2.0": return old.room == 5 && current.room == 9;
	}
}

split {
	return old.room != current.room && settings[vars.ver + "-" + old.room + "to" + current.room];
}

reset {
	if (old.room != current.room)
		switch ((string)vars.ver) {
			case "1.1": return old.room != 0 && old.room != 4 && current.room == 0;
			case "2.0": return old.room != 5 && old.room != 9 && current.room == 4;
		}
}
