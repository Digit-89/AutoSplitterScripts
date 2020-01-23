state("AShortHike") {
	int feather : "UnityPlayer.dll", 0x109AC54, 0x38, 0x34, 0x3C, 0x44, 0x234;
    int screen  : "UnityPlayer.dll", 0x105C480, 0x3C;
	float igt   : "UnityPlayer.dll", 0x10B6780, 0x4, 0x4, 0x14, 0x0, 0x48, 0x18, 0x28;
    int cutscene: "UnityPlayer.dll", 0x10559A8, 0x20, 0xC, 0x0, 0x34;
}

init {
    vars.lastValidIGT = 0;
}

start {
	return
        (old.igt == 0 && current.igt > 0 && current.screen == 612) ||
        (old.igt == 0 && current.igt > 0 && current.screen == 516) ||
        (old.igt == 0 && current.igt > 0 && current.screen == 216);
}

split {
	return
        (current.feather > old.feather) ||
        (current.screen == 96 && old.screen != 96) ||
        (current.screen == 108 && old.screen == 384) ||
        (current.cutscene == 0 && old.cutscene == 1);
}

reset {
    return current.screen == 24;
}

isLoading {
    return true;
}

gameTime {
    if (current.igt != 0) {
        vars.lastValidIGT = current.igt;
        return TimeSpan.FromSeconds(current.igt);
    } else {
        return TimeSpan.FromSeconds(vars.lastValidIGT);
    }
}
