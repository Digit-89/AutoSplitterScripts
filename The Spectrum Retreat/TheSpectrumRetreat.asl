state("Spectrum") {
	int screen: "mono.dll", 0x01F50AC, 0xA80, 0x20, 0x24;
	int mouse : "UnityPlayer.dll", 0x0FD789C, 0x38, 0x20, 0x8, 0x44;
	int map   : "UnityPlayer.dll", 0x0FD9174, 0x14;
}

init {
	string logPath = Environment.GetEnvironmentVariable("appdata")+"\\..\\LocalLow\\Ripstone\\The Spectrum Retreat\\output_log.txt";
	vars.line = "";
	vars.reader = new StreamReader(new FileStream(logPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite));
	print("canSplit set to TRUE (line 11)");
	vars.canSplit = true;
	vars.time = "";
	vars.day = "";
}

exit {
	vars.reader = null;
}

update {
	if (vars.reader == null) return false;
	vars.line = vars.reader.ReadLine();
	if (vars.line != null && vars.line.StartsWith("Time advanced to ")) {
		vars.time = vars.line.Split(' ')[3];
		vars.day  = vars.line.Split(' ')[6];
	}
	if (
		(vars.line != null && vars.time.Equals("12")) || 
		(vars.line != null && vars.time.Equals("13")) ||
		(vars.line != null && vars.time.Equals("14")) ||
		(vars.line != null && vars.time.Equals("10") && vars.day.Equals("5"))
	   ) {
		print("canSplit set to TRUE (line 34)");
		vars.canSplit = true;
	} else if (vars.line != null && vars.time.Equals("22")) {
		print("canSplit set to FALSE (line 37)");
		vars.canSplit = false;
	}
}

start {
	if (current.screen != 14 && old.screen == 14) {
		print("canSplit set to FALSE (line 44)");
		vars.canSplit = false;
		return true;
	}
}

reset {
	return (current.screen == 14 && old.screen == 18);
}

split {
	if (current.mouse == 257 && old.mouse == 0 && vars.time.Equals("10")) {
		print("canSplit set to TRUE (line 56)");
		vars.canSplit = true;
	}
	if (current.map == 58) {
		return false;
	} else if (current.mouse == 0 && old.mouse == 257 && vars.canSplit) {
		return true;
	}
}
