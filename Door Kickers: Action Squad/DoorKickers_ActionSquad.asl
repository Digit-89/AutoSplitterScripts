state("ActionSquad") {
  double levelRunTime : 0x38C8C0;
  int levelEndTime    : 0x38E5A0;
  int levelState      : 0x38D2AC;

  int chapter         : 0x281758;
  int level           : 0x38D2C0;

  int hostagesTotal   : 0x38E5B4;
  int hostagesSaved   : 0x38E608;
  int targetsTotal    : 0x38E5D0;
  int targetsArrested : 0x38E5D4;
}

startup {
  object[,] sB = {
    {    "",   "ch1", "Chapter 1:" },
      { "ch1",  "ch0lvl0",  "1.1: Slow Starters" },
      { "ch1",  "ch0lvl1",  "1.2: Knock Knock Knock" },
      { "ch1",  "ch0lvl2",  "1.3: Old Embassy" },
      { "ch1",  "ch0lvl3",  "1.4: Night Call" },
      { "ch1",  "ch0lvl4",  "1.5: Tread Carefully" },
      { "ch1",  "ch0lvl5",  "1.6: 255th Precinct" },
      { "ch1",  "ch0lvl6",  "1.7: High Rise" },
      { "ch1",  "ch0lvl7",  "1.8: The Warehouse" },
      { "ch1",  "ch0lvl8",  "1.9: Office Day" },
      { "ch1",  "ch0lvl9", "1.10: Flashbang Junction" },
      { "ch1", "ch0lvl10", "1.11: Cleanup" },
      { "ch1", "ch0lvl11", "1.12: Meet Big Boss" },

    {    "",   "ch2", "Chapter 2:" },
      { "ch2",  "ch1lvl0",  "2.1: Meeting Bart" },
      { "ch2",  "ch1lvl1",  "2.2: Volatile Motel" },
      { "ch2",  "ch1lvl2",  "2.3: Going Under" },
      { "ch2",  "ch1lvl3",  "2.4: The Bunker" },
      { "ch2",  "ch1lvl4",  "2.5: Midnight Folies" },
      { "ch2",  "ch1lvl5",  "2.6: Mountain Hideout" },
      { "ch2",  "ch1lvl6",  "2.7: Outpost" },
      { "ch2",  "ch1lvl7",  "2.8: Bombs Away" },
      { "ch2",  "ch1lvl8",  "2.9: The Block" },
      { "ch2",  "ch1lvl9", "2.10: Caught in a Maze" },
      { "ch2", "ch1lvl10", "2.11: The Museum" },
      { "ch2", "ch1lvl11", "2.12: The Yard" },

    { "", "ch3", "Chapter 3:" },
      { "ch3",  "ch2lvl0",  "3.1: Frankie the Fanatic" },
      { "ch3",  "ch2lvl1",  "3.2: Crisis at McDonuts" },
      { "ch3",  "ch2lvl2",  "3.3: Metro Madness" },
      { "ch3",  "ch2lvl3",  "3.4: Molotov Delievery" },
      { "ch3",  "ch2lvl4",  "3.5: Vertigo" },
      { "ch3",  "ch2lvl5",  "3.6: Water Works, Inc." },
      { "ch3",  "ch2lvl6",  "3.7: Cold Exposure" },
      { "ch3",  "ch2lvl7",  "3.8: Hipster Beer Factory" },
      { "ch3",  "ch2lvl8",  "3.9: Climbing the Shaft" },
      { "ch3",  "ch2lvl9", "3.10: Laboratory Crisis" },
      { "ch3", "ch2lvl10", "3.11: Raid on Plaza" },
      { "ch3", "ch2lvl11", "3.12: Doomsday Train" },

    { "", "ch4", "Chapter 4:" },
      { "ch4",  "ch3lvl0",  "4.1: Bank Heist" },
      { "ch4",  "ch3lvl1",  "4.2: Queen's Cross" },
      { "ch4",  "ch3lvl2",  "4.3: Fibonacci" },
      { "ch4",  "ch3lvl3",  "4.4: On the Anvil" },
      { "ch4",  "ch3lvl4",  "4.5: Secret Stronghold" },
      { "ch4",  "ch3lvl5",  "4.6: Caneville" },
      { "ch4",  "ch3lvl6",  "4.7: On Vacation" },
      { "ch4",  "ch3lvl7",  "4.8: Whine and Dine" },
      { "ch4",  "ch3lvl8",  "4.9: Lights Out" },
      { "ch4",  "ch3lvl9", "4.10: To the Airport" },
      { "ch4", "ch3lvl10", "4.11: Around the Clock" },
      { "ch4", "ch3lvl11", "4.12: The Great Batsby" },

    { "", "ch5", "Chapter 5:" },
      { "ch5",  "ch4lvl0",  "5.1: I am the Captain Now" },
      { "ch5",  "ch4lvl1",  "5.2: Reservoir Docks" },
      { "ch5",  "ch4lvl2",  "5.3: Dusty Neighbours" },
      { "ch5",  "ch4lvl3",  "5.4: The Shiny" },
      { "ch5",  "ch4lvl4",  "5.5: El Quarantino" },
      { "ch5",  "ch4lvl5",  "5.6: Joint Block" },
      { "ch5",  "ch4lvl6",  "5.7: Sky Scratchers" },
      { "ch5",  "ch4lvl7",  "5.8: NCtv Cribs" },
      { "ch5",  "ch4lvl8",  "5.9: Tinytanic" },
      { "ch5",  "ch4lvl9", "5.10: Flying High" },
      { "ch5", "ch4lvl10", "5.11: Word on the Street" },
      { "ch5", "ch4lvl11", "5.12: The Crib" },

    { "", "ch6", "Chapter 6:" },
      { "ch6",  "ch5lvl0",  "6.1: Fixer Upper" },
      { "ch6",  "ch5lvl1",  "6.2: Snitches Galore" },
      { "ch6",  "ch5lvl2",  "6.3: Graveyard Surprise" },
      { "ch6",  "ch5lvl3",  "6.4: Long Way Down" },
      { "ch6",  "ch5lvl4",  "6.5: Terror from the Terrace" },
      { "ch6",  "ch5lvl5",  "6.6: Hard Core" },
      { "ch6",  "ch5lvl6",  "6.7: It's Raining Men" },
      { "ch6",  "ch5lvl7",  "6.8: Pool Party Crashers" },
      { "ch6",  "ch5lvl8",  "6.9: Downstairs Cage" },
      { "ch6",  "ch5lvl9", "6.10: Crates and Bombs" },
      { "ch6", "ch5lvl10", "6.11: The Express" },
      { "ch6", "ch5lvl11", "6.12: Consulate Crisis" },

    { "", "ch7", "Chapter 7:" },
      { "ch7",  "ch6lvl0",  "7.1: Stoners Paradise" },
      { "ch7",  "ch6lvl1",  "7.2: Peace and Quiet" },
      { "ch7",  "ch6lvl2",  "7.3: High as a Kite" },
      { "ch7",  "ch6lvl3",  "7.4: Living on the Ledge" },
      { "ch7",  "ch6lvl4",  "7.5: Cutting Edge" },
      { "ch7",  "ch6lvl5",  "7.6: Earthworm Ben" },
      { "ch7",  "ch6lvl6",  "7.7: Switch and Destroy" },
      { "ch7",  "ch6lvl7",  "7.8: Home Box Office" },
      { "ch7",  "ch6lvl8",  "7.9: Leap of Faith" },
      { "ch7",  "ch6lvl9", "7.10: Under Pressure" },
      { "ch7", "ch6lvl10", "7.11: Monty Hall" },
      { "ch7", "ch6lvl11", "7.12: No Excuse" }
  };

  settings.Add("leveled", true, "Split whenever a level is completed (3 stars not required)");
  settings.SetToolTip("leveled", "Unchecking this setting will make the auto splitter\nonly split when a level is completed with 3 stars.");
  settings.Add("ilTimer", false, "Reset on mission restart or fail");

  for (int i = 0; i < sB.GetLength(0); ++i) {
    if ((string)sB[i, 0] == "") settings.Add((string)sB[i, 1], true, (string)sB[i, 2]);
    else settings.Add((string)sB[i, 1], true, (string)sB[i, 2], (string)sB[i, 0]);
  }


  vars.timerStartEvent = (EventHandler) ((s, e) => {
    string fileName = "DKAS_ILTimes.log";
    var logWriter = File.AppendText(fileName);

    logWriter.WriteLine("\nNew run started!\n");
    logWriter.Close();
  });

  timer.OnStart += vars.timerStartEvent;
  timer.CurrentTimingMethod = TimingMethod.RealTime;
}

init {
  vars.log = (Action<string>) (successOrFailed => {
    string fileName = "DKAS_ILTimes.log";
    var logWriter = File.AppendText(fileName);

    string output =
      (current.chapter + 1).ToString() + "-" + (current.level + 1).ToString("00") + ": " +
      "MISSION " + successOrFailed + " at " + TimeSpan.FromSeconds(current.levelRunTime).ToString(@"mm\:ss\.fff") +
      " (Hostages: " + current.hostagesSaved + "/" + current.hostagesTotal + ", Arrest Targets: " + current.targetsArrested + "/" + current.targetsTotal + ")";

    logWriter.WriteLine(output);

    logWriter.Close();

    if (new FileInfo(fileName).Length >= 500000)
      File.WriteAllText(fileName, output);
  });
}

start {
  return old.levelRunTime == 0.0 && current.levelRunTime > 0.0;
}

split {
  if (old.levelEndTime == 0 && current.levelEndTime > 0 && old.levelState == 0 && current.levelState == 1) {

    vars.log("SUCCESS");

    bool is6_11 = current.chapter == 5 && current.level == 10;
    bool allTargetsArrested = current.targetsTotal == 0 ? current.targetsArrested == 0 : current.targetsArrested == 1;
    bool allHostagesSaved = current.hostagesSaved == current.hostagesTotal - (is6_11 ? 1 : 0);
    bool splitCondition = settings["leveled"] ? true : allHostagesSaved && allTargetsArrested;

    return splitCondition && settings["ch" + current.chapter + "lvl" + current.level];
  }
}

reset {
  if (old.levelEndTime == 0 && current.levelEndTime > 0 && old.levelState == 0 && current.levelState == 2) {
    vars.log("FAILED ");

    return settings["ilTimer"];
  }

  return settings["ilTimer"] && old.levelRunTime > current.levelRunTime;
}

shutdown {
  timer.OnStart -= vars.timerStartEvent;
}