state("GNOG") {
  int state : "mono.dll", 0x01F50AC, 0x42C, 0x8, 0x44, 0x630;
  int screen: "mono.dll", 0x01F50AC, 0x360, 0x8, 0x44, 0x990;
  int mouse : "mono.dll", 0x01F50AC, 0x378, 0x58;
}

startup {
  settings.Add("reset", false, "Reset timer when closing the game");
}

start {
  return old.mouse == 0 && current.mouse == 1 && current.screen == 2;
}

reset {
  return settings["reset"] && old.state != 0 && current.state == 0;
}

split {
  return current.screen == 3 && old.state == 3 && current.state != 3;
}
