state("yapp") {
  //string1800 dataString : "mono.dll", 0x263110, 0xA0, 0x28, 0x14;
}

startup {
  vars.tM = new TimerModel {CurrentState = timer};

  var startIndex = new Dictionary<int, int> {
    {1, 10},
    {2, 20},
    {3, 30},
    {4, 40},
    {5, 50},
    {6, 60},
    {7, 70},
  };

  for (int wrld = 1; wrld <= 7; ++wrld) {
    string header = "World " + wrld + " Splits:";
    settings.Add(header);
    for (int lvl = 1; lvl <= 8; ++lvl)
      settings.Add("l" + (startIndex[wrld] + lvl), true, lvl == 8 ? "Castle" : "Level " + lvl, header);
  }
}

init {
  vars.solvedWatchers = new MemoryWatcherList();

  for (int i = 0; i < 128; ++i)
    vars.solvedWatchers.Add(
      new MemoryWatcher<bool>(new DeepPointer("mono.dll", 0x263110, 0xA0, 0x20, 0x10, 0x20 + i)) {Name = "l" + i.ToString()}
    );
}

split {
  vars.solvedWatchers.UpdateAll(game);
  foreach (var watcher in vars.solvedWatchers)
    if (watcher.Changed && watcher.Current)
      return settings[watcher.Name];
}

reset {
  return vars.solvedWatchers["l11"].Old && !vars.solvedWatchers["l11"].Current;
}

exit {
  vars.tM.Reset();
}