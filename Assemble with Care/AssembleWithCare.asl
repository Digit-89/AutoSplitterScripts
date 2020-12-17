/*
 * LevelFlowService: "mono-2.0-bdwgc.dll", 0x491A90, 0xD00,
 * * 0x28 : LevelConfig,
 *   * 0x20 : chapterNumber
 *     * 0x14 : Value (string)
 *
 * * 0x40 : state (int) :
 *          * 0 = Begin,
 *          * 1 = InStartNarrative,
 *          * 2 = Repairing,
 *          * 3 = FinishedRepairing,
 *          * 4 = LevelComplete,
 *          * 5 = InEndNarrative,
 *          * 6 = LeavingLevel,
 *          * 7 = InPause,
 *          * 8 = LoadingOut
 */

state("AWC") {
	string128 chNum : "mono-2.0-bdwgc.dll", 0x491A90, 0xD00, 0x28, 0x20, 0x14;
	int levelState  : "mono-2.0-bdwgc.dll", 0x491A90, 0xD00, 0x40;
	int startValue  : "UnityPlayer.dll", 0x17E1760, 0xE8, 0x58, 0x20, 0xE8;
}

start {
	return old.startValue == 4 && current.startValue == 0;
}

split {
	return
		old.startValue == 0 && current.startValue == 4 ||
		(current.chNum.Contains("EspressoMachine") ? old.levelState == 5 && current.levelState == 8 :
		                                             old.levelState == 4 && current.levelState == 5);
}

reset {
	return old.startValue == 4 && current.startValue == 0;
}