state("Phasmophobia") {
	bool isTutorial             : "UnityPlayer.dll", 0x1804EE8, 0x128, 0x8, 0x80, 0x1A;
	bool miss1Completed         : "UnityPlayer.dll", 0x1804EE8, 0x128, 0x8, 0x80, 0x24;
	bool miss2Completed         : "UnityPlayer.dll", 0x1804EE8, 0x128, 0x8, 0x80, 0x25;
	bool miss3Completed         : "UnityPlayer.dll", 0x1804EE8, 0x128, 0x8, 0x80, 0x26;
	bool miss4Completed         : "UnityPlayer.dll", 0x1804EE8, 0x128, 0x8, 0x80, 0x27;
	bool allPlayersAreConnected : "UnityPlayer.dll", 0x1804EE8, 0x128, 0x8, 0x148, 0x8, 0xB8, 0x30, 0x68;
	bool isLoadingBackToMenu    : "UnityPlayer.dll", 0x1804EE8, 0x128, 0x8, 0x148, 0x8, 0xB8, 0x30, 0x69;
	byte evidence1Index         : "UnityPlayer.dll", 0x17A2460, 0x8, 0x8, 0x240, 0x1C0, 0xD0;
	byte evidence2Index         : "UnityPlayer.dll", 0x17A2460, 0x8, 0x8, 0x240, 0x1C0, 0xE0;
	byte evidence3Index         : "UnityPlayer.dll", 0x17A2460, 0x8, 0x8, 0x240, 0x1C0, 0xF0;
	byte ghostTypeIndex         : "UnityPlayer.dll", 0x17A2460, 0x8, 0x8, 0x240, 0x1C0, 0x100;
}

startup {
	vars.tM = new TimerModel {CurrentState = timer};
	vars.sW = new Stopwatch();
	vars.doOnTrue = (Func<bool, bool>) ((cond) => { if (cond) { vars.sW.Reset(); return true; } else return false; });

	settings.Add("header", true, "Split ONLY when these conditions are met, reset if not:");
		settings.Add("miss", true, "Objectives must be completed", "header");
		settings.Add("evid", true, "Evidences and ghost type must be set", "header");
}

update {
	vars.miss = new[] {current.miss1Completed, current.miss2Completed, current.miss3Completed, current.miss4Completed}.All(x => x == true);
	vars.evid = new[] {current.evidence1Index, current.evidence2Index, current.evidence3Index, current.ghostTypeIndex}.All(x => x != 0);

	if (!old.isLoadingBackToMenu && current.isLoadingBackToMenu) vars.sW.Start();
	if (timer.CurrentPhase == TimerPhase.Ended && old.allPlayersAreConnected && !current.allPlayersAreConnected) vars.tM.Split();
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
