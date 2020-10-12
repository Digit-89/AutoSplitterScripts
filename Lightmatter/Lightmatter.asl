// For Lightmatter Version 1.09

state("LightmatterSub") {
  int level_number : "mono-2.0-bdwgc.dll", 0x0490A68, 0x50, 0x140, 0x58, 0xA0;
  int start_value  :  "fmodstudio.dll", 0x02B3CF0, 0x110, 0x10, 0x0, 0x28;
  int switches     : "mono-2.0-bdwgc.dll", 0x0490A68, 0x50, 0x180, 0x0, 0xF8, 0x40;
  // float total_timer: "mono-2.0-bdwgc.dll", 0x0490A68, 0x50, 0x180, 0x0, 0xF8, 0x4;
  float level_timer: "mono-2.0-bdwgc.dll", 0x0492DE8, 0x100, 0x0, 0x60, 0x90;
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
  //if (old.level_number != current.level_number) print(">>>>> level changed from " + old.level_number + " to " + current.level_number);
  //if (old.switches != current.switches) print(">>>>> switches changed from " + old.switches + " to " + current.switches);
}

exit {
  vars.reader = null;
}

start {
  if (settings["iltimer"])
    if (current.level_timer < old.level_timer) {
      vars.currentLevel = current.level_number;
      return true;
    }
  else return old.start_value == 3 && current.start_value == 2 && current.level_number == 0;
}

split {
  return vars.movementSpeed == "0,3" && current.level_number == 37 ? old.switches < current.switches : current.level_number == old.level_number + 1 && current.level_number < 38;
}

reset {
  return
    old.level_number != 0 && current.level_number == 0 ||
    current.level_number == 0 && old.start_value == 2 && current.start_value == 3;
}
