state("flashplayer_32_sa", "Normal Flash Player") {
	int totalCount   : 0xD1DD48, 0x8BC, 0x8, 0x68, 0xC, 0x8, 0x14, 0x69C, 0x10, 0x18, 0x20;
	int partialCount : 0xD1DD48, 0x8BC, 0x8, 0x68, 0xC, 0x8, 0x14, 0x2D8, 0x10, 0x78, 0x64;
	int level        : 0xD1DD48, 0x8BC, 0x8, 0x68, 0xC, 0x8, 0x14, 0x2D8, 0x10, 0x78, 0x6C;
}

state("flashplayer_32_sa_debug", "Debug Flash Player") {
	int totalCount   : 0xDA07D8, 0xC, 0x818, 0x8, 0x24, 0xC8, 0x18, 0x69C, 0x10, 0x18, 0x20;
	int partialCount : 0xDA07D8, 0xC, 0x818, 0x8, 0x24, 0xC8, 0x18, 0x2D8, 0x10, 0x78, 0x64;
	int level        : 0xDA07D8, 0xC, 0x818, 0x8, 0x24, 0xC8, 0x18, 0x2D8, 0x10, 0x78, 0x6C;
}

startup {
	settings.Add("igtMessage", true, "Ask if Game Time should be used when the game is opened");
}

init {
	if (timer.CurrentTimingMethod == TimingMethod.RealTime && settings["igtMessage"]) {
		var message = MessageBox.Show(
			"Give Up, Robot uses Game Time for its runs! You are currently comparing against Real Time.\n\nWould you like to switch?",
			"LiveSplit | Give Up, Robot Splitter", MessageBoxButtons.YesNo, MessageBoxIcon.Information);

		if (message == DialogResult.Yes) timer.CurrentTimingMethod = TimingMethod.GameTime;
	}
}

start {
	return current.level == 1 && old.partialCount == 0 && current.partialCount > 0;
}

split {
	return
		current.level == old.level + 1 ||
		old.level != current.level && old.level % 10 == 0 && old.level != 80;
}

reset {
	return old.level != 0 && current.level == 0;
}

gameTime {
	var timeConverted = (Func<double, TimeSpan>) ((value) => { return TimeSpan.FromSeconds(Math.Round(Convert.ToSingle(value) * 100 / 60) / 100); });
	return current.level == 80 ? timeConverted(current.totalCount) : timeConverted(current.totalCount + current.partialCount);
}

isLoading {
	return true;
}
