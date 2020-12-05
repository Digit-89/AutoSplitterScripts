state("flashplayer_32_sa") {
	int frameCount : 0xD1DD48, 0x8BC, 0x8, 0x120, 0x6C, 0x8, 0x14, 0x2D8, 0x10, 0x78, 0x64;
	int level      : 0xD1DD48, 0x8BC, 0x8, 0x120, 0x6C, 0x8, 0x14, 0x2D8, 0x10, 0x78, 0x6C;
}

init {
	vars.totalFrames = 0;
}

start {
	return old.level > 1 && current.level == 1;
}

split {
	return current.level == old.level + 1;
}

reset {
	if (old.level != 0 && current.level == 0) {
		vars.totalFrames = 0;
		return true;
	}
}

gameTime {
	if (old.frameCount > current.frameCount) vars.totalFrames += old.frameCount;
	return TimeSpan.FromSeconds((vars.totalFrames + Convert.ToSingle(current.frameCount)) / 60);
}

isLoading {
	return true;
}