state("flashplayer_32_sa", "Normal Flash Player") {
	int frameCount : 0xD1DD48, 0x8BC, 0x8, 0x120, 0x6C, 0x8, 0x14, 0x2D8, 0x10, 0x78, 0x64;
	int level      : 0xD1DD48, 0x8BC, 0x8, 0x120, 0x6C, 0x8, 0x14, 0x2D8, 0x10, 0x78, 0x6C;
}

/*state("flashplayer_32_sa_debug", "Debug Flash Player") {
	int frameCount : 
	int level      : 
}*/

init {
	vars.totalFrames = 0;
	/*switch (modules.First().ModuleMemorySize) {
		case 16990208: version = "Normal Flash Player"; break;
		case 00000000: version = "Debug Flash Player"; break;
		default: version = "Undeteced version of Flash!"; break;
	}*/
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
