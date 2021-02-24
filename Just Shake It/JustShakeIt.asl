state("Just Shake It") {
	int checkpoint : "mono-2.0-bdwgc.dll", 0x497DE8, 0x48, 0xC10, 0x28;
}

startup {
	timer.CurrentTimingMethod = TimingMethod.RealTime;
}

start {
	return old.checkpoint == 0 && current.checkpoint == 1;
}

split {
	return old.checkpoint != current.checkpoint && current.checkpoint > 1;
}

reset {
	return old.checkpoint != current.checkpoint && (current.checkpoint == 0 || current.checkpoint == 1);
}