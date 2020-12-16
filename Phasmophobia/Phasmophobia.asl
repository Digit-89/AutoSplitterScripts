/*
 * LevelController : "GameAssembly.dll", 0x292EA48, 0xB8, 0x0   * LevelValues : "GameAssembly.dll", 0x292D368, 0xB8, 0x0
 * * 0x78 : JournalController,                                  * * 0x1A : isTutorial (bool),
 *   * 0xD0  : evidence1Index (int),                            * * 0x24 : miss1Completed (bool),
 *   * 0xE0  : evidence2Index (int),                            * * 0x25 : miss2Completed (bool),
 *   * 0xF0  : evidence3Index (int),                            * * 0x26 : miss3Completed (bool),
 *   * 0x100 : ghostTypeIndex (int)                             * * 0x27 : miss4Completed (bool)
 *
 * * 0x88 : GameController
 *   * 0x68 : allPlayersAreConnected (bool),
 *   * 0x69 : isLoadingBackToMenu (bool)
 */

state("Phasmophobia") {
	bool isTutorial             : "GameAssembly.dll", 0x292D368, 0xB8, 0x0, 0x1A;
	bool miss1Completed         : "GameAssembly.dll", 0x292D368, 0xB8, 0x0, 0x24;
	bool miss2Completed         : "GameAssembly.dll", 0x292D368, 0xB8, 0x0, 0x25;
	bool miss3Completed         : "GameAssembly.dll", 0x292D368, 0xB8, 0x0, 0x26;
	bool miss4Completed         : "GameAssembly.dll", 0x292D368, 0xB8, 0x0, 0x27;
	byte evidence1Index         : "GameAssembly.dll", 0x292EA48, 0xB8, 0x0, 0x78, 0xD0;
	byte evidence2Index         : "GameAssembly.dll", 0x292EA48, 0xB8, 0x0, 0x78, 0xE0;
	byte evidence3Index         : "GameAssembly.dll", 0x292EA48, 0xB8, 0x0, 0x78, 0xF0;
	byte ghostTypeIndex         : "GameAssembly.dll", 0x292EA48, 0xB8, 0x0, 0x78, 0x100;
	bool allPlayersAreConnected : "GameAssembly.dll", 0x292EA48, 0xB8, 0x0, 0x88, 0x68;
	bool isLoadingBackToMenu    : "GameAssembly.dll", 0x292EA48, 0xB8, 0x0, 0x88, 0x69;
}

startup {
	vars.sW = new Stopwatch();
	vars.doOnTrue = (Func<bool, bool>) ((cond) => { if (cond) { vars.sW.Reset(); return true; } else return false; });

	settings.Add("header", true, "Split ONLY when these conditions are met, reset if not:");
		settings.Add("miss", true, "Objectives must be completed", "header");
		settings.Add("evid", true, "Evidences and ghost type must be set", "header");
}

update {
	vars.miss = new[] {current.miss1Completed, current.miss2Completed, current.miss3Completed, current.miss4Completed}.All(x => x == true);
	vars.evid = new[] {current.evidence1Index, current.evidence2Index, current.evidence3Index, current.ghostTypeIndex}.All(x => x != 0);
	current.phase = timer.CurrentPhase;

	if (!old.isLoadingBackToMenu && current.isLoadingBackToMenu) vars.sW.Start();
	if (old.phase != TimerPhase.NotRunning && current.phase == TimerPhase.NotRunning) vars.sW.Reset();
}

start {
	return !old.allPlayersAreConnected && current.allPlayersAreConnected;
}

split {
	if (vars.sW.ElapsedMilliseconds >= 8967) {
		if (!settings["evid"] && !settings["miss"]) return vars.doOnTrue(true);

		if (current.isTutorial) return vars.doOnTrue(vars.evid && settings["evid"]);
		else return vars.doOnTrue(vars.evid && settings["evid"] || vars.miss && settings["miss"]);
	}
}

reset {
	if (vars.sW.ElapsedMilliseconds >= 8982) {
		if (!settings["evid"]) return false;
		if (current.isTutorial) return vars.doOnTrue(settings["evid"] && !vars.evid);
		else return vars.doOnTrue(settings["evid"] && !vars.evid || settings["miss"] && !vars.miss);
	}
}
