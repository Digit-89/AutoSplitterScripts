// For Lightmatter Version 1.05

state("LightmatterSub") {
    int level_number : "UnityPlayer.dll", 0x16488D0, 0x178, 0xC8, 0x10, 0x60, 0xA0;
	int start_value  :  "fmodstudio.dll", 0x02B3CF0, 0x108, 0x10, 0x0, 0x28;
	int switches     : "UnityPlayer.dll", 0x16488D0, 0x148, 0x118, 0x0, 0xF8, 0x40;
	// float total_timer: "UnityPlayer.dll", 0x1646CD8, 0x78, 0x78, 0xC0, 0x1A0, 0x4;
	float level_timer: "UnityPlayer.dll", 0x1646CD8, 0x78, 0x78, 0xC0, 0x1A0, 0x0;
}

startup {
	settings.Add("iltimer", false, "IL runs (starts on clicking retry, splits on level completion)");
}

init {
	string logPath = Environment.GetEnvironmentVariable("appdata")+"\\..\\LocalLow\\Tunnel Vision Games\\Lightmatter\\Player.log";
	vars.line = "";
	vars.reader = new StreamReader(new FileStream(logPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite));
	vars.movementSpeed = "0";
	vars.currentLevel = -1;
}

update {
	if (vars.reader == null) return false;
	vars.line = vars.reader.ReadLine();
	if (vars.line != null && vars.line.StartsWith("TA_SetPlayerMovementSpeed: ")) {
		vars.movementSpeed = vars.line.Split(' ')[1];
		print(">>>>> movement speed changed to " + vars.movementSpeed);
	}
	if (old.level_number != current.level_number) {
		print(">>>>> level changed from " + old.level_number + " to " + current.level_number);
	}
	if (old.switches != current.switches) {
		print(">>>>> switches changed from " + old.switches + " to " + current.switches);
	}
}

exit {
	vars.reader = null;
}

start {
	if (settings["iltimer"]) {
		if (current.level_timer < old.level_timer) {
			vars.currentLevel = current.level_number;
			return true;
		}
	} else {
		return (old.start_value == 3 && current.start_value == 2 && current.level_number == 0);
	}
}

split {
	return
		(current.level_number == old.level_number + 1 && current.level_number < 38) ||
		(vars.movementSpeed == "0,3" && current.level_number == 37 && old.switches < current.switches);
}

reset {
	if (settings["iltimer"]) {
		return
			(current.level_timer < old.level_timer && current.level_number == vars.currentLevel) ||
			(old.level_number != 0 && current.level_number == 0);
	} else {
		return (old.level_number != 0 && current.level_number == 0);
	}
}
