state("Phasmophobia", "Stable") {
	bool isTutorial             : "mono-2.0-bdwgc.dll", 0x498210, 0x1B0, 0xD0, 0x8, 0x278, 0x398, 0x10, 0x6C;
	bool allPlayersAreConnected : "mono-2.0-bdwgc.dll", 0x498210, 0x1B0, 0xD0, 0x8, 0x278, 0x398, 0x10, 0x74;
	bool isLoadingBackToMenu    : "mono-2.0-bdwgc.dll", 0x498210, 0x1B0, 0xD0, 0x8, 0x278, 0x398, 0x10, 0x75;
	byte evidence1Index         : "mono-2.0-bdwgc.dll", 0x495DE8, 0x88, 0xDD0, 0x60, 0x0, 0x78, 0xD8;
	byte evidence2Index         : "mono-2.0-bdwgc.dll", 0x495DE8, 0x88, 0xDD0, 0x60, 0x0, 0x78, 0xDC;
	byte evidence3Index         : "mono-2.0-bdwgc.dll", 0x495DE8, 0x88, 0xDD0, 0x60, 0x0, 0x78, 0xE0;
	byte ghostTypeIndex         : "mono-2.0-bdwgc.dll", 0x495DE8, 0x88, 0xDD0, 0x60, 0x0, 0x78, 0xE4;
	bool miss1Completed         : "UnityPlayer.dll", 0x17BA5D8, 0x148, 0xB0, 0x68, 0x78, 0x28, 0x34;
	bool miss2Completed         : "UnityPlayer.dll", 0x17BA5D8, 0x148, 0xB0, 0x68, 0x88, 0x28, 0x34;
	bool miss3Completed         : "UnityPlayer.dll", 0x17BA5D8, 0x148, 0xB0, 0x68, 0x98, 0x28, 0x34;
	bool miss4Completed         : "UnityPlayer.dll", 0x17BA5D8, 0x148, 0xB0, 0x68, 0xA8, 0x28, 0x34;
}

state("Phasmophobia", "Beta") {
	bool isTutorial             : "UnityPlayer.dll", 0x1804EE8, 0x128, 0x8, 0x80, 0x1A;
	bool miss1Completed         : "UnityPlayer.dll", 0x1804EE8, 0x128, 0x8, 0x80, 0x24;
	bool miss2Completed         : "UnityPlayer.dll", 0x1804EE8, 0x128, 0x8, 0x80, 0x25;
	bool miss3Completed         : "UnityPlayer.dll", 0x1804EE8, 0x128, 0x8, 0x80, 0x26;
	bool miss4Completed         : "UnityPlayer.dll", 0x1804EE8, 0x128, 0x8, 0x80, 0x27;
	byte evidence1Index         : "UnityPlayer.dll", 0x17A2460, 0x8, 0x8, 0x240, 0x1C0, 0xD0;
	byte evidence2Index         : "UnityPlayer.dll", 0x17A2460, 0x8, 0x8, 0x240, 0x1C0, 0xE0;
	byte evidence3Index         : "UnityPlayer.dll", 0x17A2460, 0x8, 0x8, 0x240, 0x1C0, 0xF0;
	byte ghostTypeIndex         : "UnityPlayer.dll", 0x17A2460, 0x8, 0x8, 0x240, 0x1C0, 0x100;
	bool allPlayersAreConnected : "UnityPlayer.dll", 0x1804EE8, 0x128, 0x8, 0x148, 0x8, 0xB8, 0x30, 0x68;
	bool isLoadingBackToMenu    : "UnityPlayer.dll", 0x1804EE8, 0x128, 0x8, 0x148, 0x8, 0xB8, 0x30, 0x69;
}

startup {
	vars.tM = new TimerModel {CurrentState = timer};
	vars.sW = new Stopwatch();
}

init {
	byte[] exeMD5HashBytes = new byte[0];
	using (var md5 = System.Security.Cryptography.MD5.Create()) {
		using (var s = File.Open(modules.First().FileName.Substring(0, modules.First().FileName.Length), FileMode.Open, FileAccess.Read, FileShare.ReadWrite)) {
			exeMD5HashBytes = md5.ComputeHash(s);
		}
	}
	var MD5Hash = exeMD5HashBytes.Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
	//print("MD5Hash: " + var MD5Hash.ToString());

	switch (MD5Hash.ToString()) {
		case "70A74DE286D80165D0E02662157A59AC": version = "Stable"; break;
		case "05359082AD1D84F4DDD6462175C79A90": version = "Beta"; break;
	}
}

update {
	vars.evid = new[] {current.evidence1Index, current.evidence2Index, current.evidence3Index, current.ghostTypeIndex}.Any(x => x == 0);
	vars.miss = new[] {current.miss1Completed, current.miss2Completed, current.miss3Completed, current.miss4Completed}.Any(x => x == false);

	if (!old.isLoadingBackToMenu && current.isLoadingBackToMenu) vars.sW.Start();
	if (timer.CurrentPhase == TimerPhase.Ended && old.allPlayersAreConnected && !current.allPlayersAreConnected) vars.tM.Split();
}

start {
	return !old.allPlayersAreConnected && current.allPlayersAreConnected;
}

split {
	if (vars.sW.ElapsedMilliseconds >= 2140 && !vars.evid && (current.isTutorial || !current.isTutorial && !vars.miss)) {
		vars.sW.Reset();
		return true;
	}
}

reset {
	if (vars.sW.ElapsedMilliseconds >= 2140 && vars.evid && (current.isTutorial || !current.isTutorial && vars.miss)) {
		vars.sW.Reset();
		return true;
	}
}