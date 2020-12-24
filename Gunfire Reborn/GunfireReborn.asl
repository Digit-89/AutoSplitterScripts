// By Ero & Pimmalage.

/*
 * WarCache : "GameAssembly.dll", 0x405ABE8, 0xB8   * GameSceneManager : "GameAssembly.dll", 0x4049F88, 0xB8
 * * 0x60 : LevelInfo (WarLevelInfo),               * * 0x4  : curSceneID (int),
 *   * 0x10 : LevelID (int),                        * * 0x8  : curMapID (int),
 *   * 0x18 : MaxLevelCnt (int),                    * * 0xC  : isInWar (bool),
 *   * 0x1C : CurLevel (int),                       * * 0x10 : loadingSceneName,
 *   * 0x20 : CurLayer (int),                       *   * 0x14 : Value (string)
 *   * 0x24 : LevelType (int),                      *
 *   * 0x28 : GameType (int),                       * * 0x18 : nextSceneName,
 *   * 0x34 : MaxRoom (int)                         * * 0x20 : nowSceneName,
 *                                                  * * 0x50 : IsLoading (bool)
 * * 0x68 : OldLevelInfo (WarLevelInfo),
 * * 0x70 : IsHeroDie (bool),                       * Game.GameUtility : "GameAssembly.dll", 0x4079CE0, 0xB8
 * * 0x71 : HasBoss (bool),                         * * 0x28 : StartClientFrameCount (bool),
 * * 0x74 : BossID (int),                           * * 0x2C : ServerChallengeFrame (int),
 * * 0x80 : HasBossWar (bool),                      * * 0x30 : ClientChallengeFrame (int),
 * * 0x84 : IsPause (int),                          * * 0x34 : ChallengePause (int)
 * * 0x88 : CurRound (int),
 * * 0x8C : LoadOK (bool),
 * * 0x90 : PlayMode (int),
 * * 0xA0 : TargetPointUpdated (bool)
 */

state("Gunfire Reborn") {
	bool isInWar : "GameAssembly.dll", 0x4049F88, 0xB8, 0xC;
	byte level   : "GameAssembly.dll", 0x405ABE8, 0xB8, 0x60, 0x1C;
	byte layer   : "GameAssembly.dll", 0x405ABE8, 0xB8, 0x60, 0x20;
	//byte lvlType : "GameAssembly.dll", 0x405ABE8, 0xB8, 0x60, 0x24;
	int halfTime : "GameAssembly.dll", 0x4079CE0, 0xB8, 0x30;
}

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

	timer.IsGameTimePaused = false;
}

update {
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

isLoading {
	return true;
}

gameTime {
	return TimeSpan.FromMilliseconds(current.halfTime * 20);
}

exit {
	timer.IsGameTimePaused = true;
}
