// Help by Pimmalage.

/*
 * WarCache :                              * GameSceneManager :
 * * 0x60 : LevelInfo (WarLevelInfo),      * * 0x4  : curSceneID (int),
 *   * 0x10 : LevelID (int),               * * 0x8  : curMapID (int),
 *   * 0x18 : MaxLevelCnt (int),           * * 0xC  : isInWar (bool),
 *   * 0x1C : CurLevel (int),              * * 0x10 : loadingSceneName,
 *   * 0x20 : CurLayer (int),              *   * 0x14 : Value (string)
 *   * 0x24 : LevelType (int),             *
 *   * 0x28 : GameType (int),              * * 0x18 : nextSceneName,
 *   * 0x34 : MaxRoom (int)                * * 0x20 : nowSceneName,
 *                                         * * 0x50 : IsLoading (bool)
 * * 0x68 : OldLevelInfo (WarLevelInfo),
 * * 0x70 : IsHeroDie (bool),              * Game.GameUtility :
 * * 0x71 : HasBoss (bool),                * * 0x28 : StartClientFrameCount (bool),
 * * 0x74 : BossID (int),                  * * 0x2C : ServerChallengeFrame (int),
 * * 0x80 : HasBossWar (bool),             * * 0x30 : ClientChallengeFrame (int),
 * * 0x84 : IsPause (int),                 * * 0x34 : ChallengePause (int)
 * * 0x88 : CurRound (int),
 * * 0x8C : LoadOK (bool),
 * * 0x90 : PlayMode (int),
 * * 0xA0 : TargetPointUpdated (bool)
 */

state("Gunfire Reborn") {}

startup {
	vars.timerModel = new TimerModel{CurrentState = timer};
	var stageNames = new Dictionary<int, string> {
		{1, "Longling Tomb"},
		{2, "Anxi Desert"},
		{3, "Duo Fjord"}
	};

	for (int i1 = 1; i1 <= 3; ++i1) {
		int max = i1 == 1 ? 5 : 4;
		string st = i1.ToString();
		string stPlus = (i1 + 1).ToString();

		settings.Add("layer" + st, true, "Split after completing a stage in " + stageNames[i1] + ":");

		for (int i2 = 0; i2 <= max; ++i2) {
			string lvl = i2.ToString();
			string lvlPlus = (i2 + 1).ToString();

			if (i1 != 1 && i2 == 0)
				settings.Add(st + "-0to" + st + "-1", false, stageNames[i1] + " Entrance", "layer" + st);
			else if (i2 > 0 && i2 < max)
				settings.Add(st + "-" + lvl + "to" + st + "-" + lvlPlus, true, "Stage " + lvl, "layer" + st);
			else if (i1 != 3 && i2 == max)
				settings.Add(st + "-" + lvl + "to" + stPlus + "-0", true, stageNames[i1] + " Boss", "layer" + st);
		}
	}

	settings.Add("finalSplit", true, "Duo Fjord Boss", "layer3");
	settings.Add("igtMessage", true, "Ask if Game Time should be used when the game is opened");
}

init {
	if (timer.CurrentTimingMethod == TimingMethod.RealTime && settings["igtMessage"]) {
		var message = MessageBox.Show(
			"Gunfire Reborn uses Game Time for its runs! You are currently comparing against Real Time.\n\nWould you like to switch?",
			"LiveSplit | Gunfire Reborn Splitter", MessageBoxButtons.YesNo, MessageBoxIcon.Information);

		if (message == DialogResult.Yes) timer.CurrentTimingMethod = TimingMethod.GameTime;
	}

	// SigScan code by 2838.
	Func<IntPtr, int, int, IntPtr> getPointerFromOpcode = (ptr, trgOperandOffset, totalSize) => {
		byte[] bytes = memory.ReadBytes(ptr + trgOperandOffset, 4);
		if (bytes == null) return IntPtr.Zero;

		Array.Reverse(bytes);
		int offset = Convert.ToInt32(BitConverter.ToString(bytes).Replace("-",""),16);
		IntPtr actualPtr = IntPtr.Add((ptr + totalSize), offset);
		return actualPtr;
	};

	ProcessModuleWow64Safe assembly = modules.FirstOrDefault(x => x.ModuleName.ToLower() == "gameassembly.dll");
	var assemblyScanner = new SignatureScanner(game, assembly.BaseAddress, assembly.ModuleMemorySize);

	// Additional thanks to 2838's Ghidra signature script.
	var warCacheSig = new SigScanTarget(0, "48 8B 05 ???????? 48 8B 80 ???????? 33 C9 C6 00 01");
	var gameUtilitySig = new SigScanTarget(0, "48 8B 0D ???????? 0F 29 74 24 ?? F3 0F 10 73 ?? F6 81 27 01 ???? 02 74 ?? 83 B9 ???????? 00 75 ?? E8 ???????? 33 C9");
	IntPtr warCachePtr = IntPtr.Zero;
	IntPtr sceneManagerPtr = IntPtr.Zero;
	IntPtr gameUtilityPtr = IntPtr.Zero;

	bool sigsFound = false;
	while (!sigsFound) {
		warCachePtr = getPointerFromOpcode(assemblyScanner.Scan(warCacheSig), 3, 7);
		sceneManagerPtr = getPointerFromOpcode(assemblyScanner.Scan(warCacheSig) + 0x18, 3, 7);
		gameUtilityPtr = getPointerFromOpcode(assemblyScanner.Scan(gameUtilitySig), 3, 7);
		sigsFound = new[]{warCachePtr, sceneManagerPtr, gameUtilityPtr}.All(x => x != IntPtr.Zero);
	}

	//print("Found WarCache        : 0x" + warCachePtr.ToString("X"));
	//print("Found GameSceneManager: 0x" + sceneManagerPtr.ToString("X"));
	//print("Found Game.GameUtility: 0x" + gameUtilityPtr.ToString("X"));

	vars.levelWatcher = new MemoryWatcher<byte>(new DeepPointer(warCachePtr, 0xB8, 0x60, 0x1C));
	vars.layerWatcher = new MemoryWatcher<byte>(new DeepPointer(warCachePtr, 0xB8, 0x60, 0x20));
	vars.inWarWatcher = new MemoryWatcher<bool>(new DeepPointer(sceneManagerPtr, 0xB8, 0xC));
	vars.timeWatcher = new MemoryWatcher<int>(new DeepPointer(gameUtilityPtr, 0xB8, 0x30));

	vars.memWatchers = new MemoryWatcherList {vars.levelWatcher, vars.layerWatcher, vars.inWarWatcher, vars.timeWatcher};

	timer.IsGameTimePaused = false;
}

update {
	vars.memWatchers.UpdateAll(game);
	current.level = vars.levelWatcher.Current;
	current.layer = vars.layerWatcher.Current;
	current.isInWar = vars.inWarWatcher.Current;
	current.halfTime = vars.timeWatcher.Current;

	if (!(current.layer == 3 && current.level == 4) && old.isInWar && !current.isInWar)
		vars.timerModel.Pause();
}



start {
	return current.layer == 1 && current.level == 1 && old.halfTime == 0 && current.halfTime > 0;
}

split {
	string oSt = old.layer.ToString();
	string cSt = current.layer.ToString();
	string oL = old.level.ToString();
	string cL = current.level.ToString();

	return
		old.level != current.level && settings[oSt + "-" + oL + "to" + cSt + "-" + cL] ||
		settings["finalSplit"] && current.layer == 3 && current.level == 4 && old.isInWar && !current.isInWar && old.halfTime == current.halfTime;
}

reset {
	return old.layer != 0 && current.layer == 0;
}

gameTime {
	if (timer.CurrentPhase == TimerPhase.Running)
		return TimeSpan.FromMilliseconds(current.halfTime * 20);
}

isLoading {
	return true;
}

exit {
	timer.IsGameTimePaused = true;
}
