state("flashplayer_32_sa", "Normal Flash Player") {
	int frameCount : 0xD1DD48, 0x8BC, 0x8, 0x68, 0xC, 0x8, 0x14, 0x2D8, 0x10, 0x78, 0x64;
	int level      : 0xD1DD48, 0x8BC, 0x8, 0x68, 0xC, 0x8, 0x14, 0x2D8, 0x10, 0x78, 0x6C;
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
	return current.level == 1 && old.frameCount == 0 && current.frameCount > 0;
}

split {
	if (old.level != current.level && old.level % 10 == 0 && old.level != 80) {
		if (old.level == 10) vars.totalFrames += 1;
		else vars.totalFrames += 3;
		return true;
	} else return current.level == old.level + 1;
}

reset {
	if (old.level != 0 && current.level == 0) {
		vars.totalFrames = 0;
		return true;
	}
}

gameTime {
	if (old.frameCount > current.frameCount && old.frameCount > 10) vars.totalFrames += old.frameCount;
	var timeConvert = (Func<double, TimeSpan>) ((value) => { return TimeSpan.FromSeconds(Math.Round(value * 100 / 60) / 100); });
	var timeInRun = timeConvert(vars.totalFrames + Convert.ToSingle(current.frameCount));
	var timeOnScore = timeConvert((double)vars.totalFrames);
	return current.level == 80 ? timeOnScore : timeInRun;
}

isLoading {
	return true;
}
