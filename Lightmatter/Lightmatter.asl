state("LightmatterSub") {
	byte startValue                       : "fmodstudio.dll", 0x2B3CF0, 0x110, 0x10, 0x0, 0x28;
	int levelIndex                        : "mono-2.0-bdwgc.dll", 0x490A68, 0x50, 0x140, 0x58, 0xA0;
	float levelSpecificMovementMultiplier : "mono-2.0-bdwgc.dll", 0x490A68, 0x50, 0x140, 0x168;
	float timeInlevel                     : "mono-2.0-bdwgc.dll", 0x490A68, 0x50, 0x180, 0x0, 0xF8, 0x0;
	int totalButtonPushCount              : "mono-2.0-bdwgc.dll", 0x490A68, 0x50, 0x180, 0x0, 0xF8, 0x40;
}

start {
	return old.startValue == 3 && current.startValue == 2 && current.levelIndex == 0;
}

split {
	bool inFinalRoom = current.levelSpecificMovementMultiplier == 0.3f && current.levelIndex == 37;
	return
		inFinalRoom ? old.totalButtonPushCount < current.totalButtonPushCount :
		              current.levelIndex == old.levelIndex + 1 && current.levelIndex < 38;
}

reset {
	return
		old.levelIndex != 0 && current.levelIndex == 0 ||
		current.levelIndex == 0 && old.startValue == 2 && current.startValue == 3;
}
