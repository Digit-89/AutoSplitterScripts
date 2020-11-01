state("LightmatterSub") {
	byte startValue    : "fmodstudio.dll", 0x2B3CF0, 0x110, 0x10, 0x0, 0x28;
	byte lvlID         : "mono-2.0-bdwgc.dll", 0x490A68, 0x50, 0x140, 0x58, 0xA0;
	//float totalTime    : "mono-2.0-bdwgc.dll", 0x490A68, 0x50, 0x180, 0x0, 0xF8, 0x4;
	byte switches      : "mono-2.0-bdwgc.dll", 0x490A68, 0x50, 0x180, 0x0, 0xF8, 0x40;
	float lvlTime      : "mono-2.0-bdwgc.dll", 0x492DE8, 0x100, 0x0, 0x60, 0x90;
}

startup {
	settings.Add("iltimer", false, "IL runs (starts on clicking retry, splits on level completion)");
}

init {
	string logPath = Environment.GetEnvironmentVariable("appdata")+"\\..\\LocalLow\\Tunnel Vision Games\\Lightmatter\\Player.log";
	vars.line = "";
	vars.reader = new StreamReader(new FileStream(logPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite));
	vars.movementSpeed = "";
	vars.currentLevel = -1;
}

update {
	if (vars.reader == null) return false;
	vars.line = vars.reader.ReadLine();
	if (vars.line != null && vars.line.StartsWith("TA_SetPlayerMovementSpeed: ")) {
		vars.movementSpeed = vars.line.Split(' ')[1];
		print(">>>>> movement speed changed to " + vars.movementSpeed);
	}
}

exit {
	vars.reader = null;
}

start {
	return old.startValue == 3 && current.startValue == 2 && current.lvlID == 0;
	if (settings["iltimer"] && current.lvlTime < old.lvlTime) {
		vars.currentLevel = current.lvlID;
		return true;
	}
}

split {
	return vars.movementSpeed == "0,3" && current.lvlID == 37 ? old.switches < current.switches : current.lvlID == old.lvlID + 1 && current.lvlID < 38;
}

reset {
	return
		old.lvlID != 0 && current.lvlID == 0 ||
		current.lvlID == 0 && old.startValue == 2 && current.startValue == 3;
}
