state("MOAstray") {
  int chapter      : 0x145CDE8, 0x3E8, 0xF8, 0x8, 0x18, 0x10, 0x58, 0x58, 0x20, 0x78;
  int area         : 0x145CDE8, 0x3E8, 0xF8, 0x8, 0x18, 0x10, 0x58, 0x58, 0x20, 0x7C;
  int checkpoint   : 0x145CDE8, 0x3E8, 0xF8, 0x8, 0x18, 0x10, 0x58, 0x58, 0x20, 0x80;
  int subCheckpoint: 0x145CDE8, 0x3E8, 0xF8, 0x8, 0x18, 0x10, 0x58, 0x58, 0x20, 0x84;
  //int inCutscene   : "mono.dll", 0x266180, 0x50, 0x7E0, 0x8, 0x20, 0x18, 0x20, 0x80; // broken
  float levelTime  : "mono.dll", 0x262A68, 0x50, 0xF18;
  double totalTime : "mono.dll", 0x296BC8, 0x20, 0x6A8, 0x0, 0x30, 0x30, 0x18;
  //int deathCount   : "mono.dll", 0x296BC8, 0x20, 0x6A8, 0x0, 0x30, 0x30, 0x20; // totalTime + 0x8
}

startup {
  vars.finishedSplits = new HashSet<string>();
  vars.timerModel = new TimerModel {CurrentState = timer};
  //vars.cutscenes = new Dictionary<Tuple<string, int>, Tuple<string, int>> {}; // potential use for cutscene timers (currentStage, cutsceneID, cutsceneName, cutsceneLength)

  vars.allStages = new List<Tuple<int, int, string, string>> { // creates a list of tuples representing CurrentStage and the corresponding checkpoint (Chapter, Area, CurrentStage, Checkpoint ID)
    Tuple.Create(1, 1, "1-1-2-1", "Checkpoint 1"),
    Tuple.Create(1, 1, "1-1-3-1", "Checkpoint 2"),
    Tuple.Create(1, 1, "1-1-4-1", "Checkpoint 3"),
    Tuple.Create(1, 1, "1-1-5-2", "Checkpoint 4"),
    Tuple.Create(1, 1, "1-1-6-1", "Checkpoint 5"),
    Tuple.Create(1, 1, "1-1-8-1", "Checkpoint 6"),
    Tuple.Create(1, 1, "1-1-8-2-stageEnd", "Finishing Area 1"),

    Tuple.Create(1, 2, "1-2-2-1", "Checkpoint 1"),
    Tuple.Create(1, 2, "1-2-10-1", "Checkpoint 2 (Noir Space)"),
    Tuple.Create(1, 2, "1-2-3-1", "Checkpoint 3"),
    Tuple.Create(1, 2, "1-2-4-1", "Checkpoint 4"),
    Tuple.Create(1, 2, "1-2-5-1", "Checkpoint 5"),
    Tuple.Create(1, 2, "1-2-6-1", "Checkpoint 6"),
    Tuple.Create(1, 2, "1-2-7-1", "Checkpoint 7"),
    Tuple.Create(1, 2, "1-2-8-1", "Checkpoint 8"),
    Tuple.Create(1, 2, "1-2-9-1", "Checkpoint 9"),
    Tuple.Create(1, 2, "1-2-9-2-stageEnd", "Finishing Area 2"),

    Tuple.Create(1, 3, "1-3-1-2", "Checkpoint 1"),
    Tuple.Create(1, 3, "1-3-2-1", "Checkpoint 2"),
    Tuple.Create(1, 3, "1-3-3-1", "Checkpoint 3"),
    Tuple.Create(1, 3, "1-3-4-1", "Checkpoint 4"),
    Tuple.Create(1, 3, "1-3-5-1", "Checkpoint 5"),
    Tuple.Create(1, 3, "1-3-6-1", "Checkpoint 6"),
    Tuple.Create(1, 3, "1-3-7-1", "Checkpoint 7"),
    Tuple.Create(1, 3, "1-3-8-1", "Checkpoint 8"),
    Tuple.Create(1, 3, "1-3-8-2-stageEnd", "Finishing Area 3"),

    Tuple.Create(1, 4, "1-4-2-1", "Checkpoint 1"),
    Tuple.Create(1, 4, "1-4-3-1", "Checkpoint 2"),
    Tuple.Create(1, 4, "1-4-4-1", "Checkpoint 3"),
    Tuple.Create(1, 4, "1-4-5-1", "Checkpoint 4"),
    Tuple.Create(1, 4, "1-4-6-1", "Checkpoint 5"),
    Tuple.Create(1, 4, "1-4-7-1", "Checkpoint 6"),
    Tuple.Create(1, 4, "1-4-8-1", "Checkpoint 7"),
    Tuple.Create(1, 4, "1-4-8-2-stageEnd", "Finishing Area 4"),

    Tuple.Create(1, 5, "1-5-2-1", "Checkpoint 1"),
    Tuple.Create(1, 5, "1-5-3-1", "Checkpoint 2"),
    Tuple.Create(1, 5, "1-5-4-1", "Checkpoint 3"),
    Tuple.Create(1, 5, "1-5-5-1", "Checkpoint 4"),
    Tuple.Create(1, 5, "1-5-6-1", "Checkpoint 5"),
    Tuple.Create(1, 5, "1-5-7-1", "Checkpoint 6"),
    Tuple.Create(1, 5, "1-5-8-1", "Checkpoint 7"),
    Tuple.Create(1, 5, "1-5-9-1", "Checkpoint 8"),
    Tuple.Create(1, 5, "1-5-10-1", "Checkpoint 9"),
    Tuple.Create(1, 5, "1-5-11-1", "Checkpoint 10"),
    Tuple.Create(1, 5, "1-5-12-1-stageEnd", "Finishing Area 5"),

    Tuple.Create(1, 6, "1-6-3-2-stageEnd", "Finishing Area 6"),

    Tuple.Create(2, 1, "2-1-2-1", "Checkpoint 1"),
    Tuple.Create(2, 1, "2-1-3-1", "Checkpoint 2"),
    Tuple.Create(2, 1, "2-1-4-1", "Checkpoint 3"),
    Tuple.Create(2, 1, "2-1-5-1", "Checkpoint 4"),
    Tuple.Create(2, 1, "2-1-6-1", "Checkpoint 5"),
    Tuple.Create(2, 1, "2-1-9-1", "Checkpoint 6 (Noir Space)"),
    Tuple.Create(2, 1, "2-1-6-2", "Checkpoint 7"),
    Tuple.Create(2, 1, "2-1-7-1", "Checkpoint 8"),
    Tuple.Create(2, 1, "2-1-8-1-stageEnd", "Finishing Area 1"),

    Tuple.Create(2, 2, "2-2-2-1", "Checkpoint 1"),
    Tuple.Create(2, 2, "2-2-3-1", "Checkpoint 2"),
    Tuple.Create(2, 2, "2-2-4-1", "Checkpoint 3"),
    Tuple.Create(2, 2, "2-2-5-1", "Checkpoint 4"),
    Tuple.Create(2, 2, "2-2-6-1", "Checkpoint 5"),
    Tuple.Create(2, 2, "2-2-7-1", "Checkpoint 6"),
    Tuple.Create(2, 2, "2-2-7-3", "Checkpoint 7"),
    Tuple.Create(2, 2, "2-2-8-1", "Checkpoint 8"),
    Tuple.Create(2, 2, "2-2-8-5-stageEnd", "Finishing Area 2"),

    Tuple.Create(2, 3, "2-3-2-1", "Checkpoint 1"),
    Tuple.Create(2, 3, "2-3-3-1", "Checkpoint 2"),
    Tuple.Create(2, 3, "2-3-4-1", "Checkpoint 3"),
    Tuple.Create(2, 3, "2-3-5-1", "Checkpoint 4"),
    Tuple.Create(2, 3, "2-3-6-1", "Checkpoint 5"),
    Tuple.Create(2, 3, "2-3-7-1", "Checkpoint 6"),
    Tuple.Create(2, 3, "2-3-8-1", "Checkpoint 7"),
    Tuple.Create(2, 3, "2-3-9-1", "Checkpoint 8"),
    Tuple.Create(2, 3, "2-3-9-2-stageEnd", "Finishing Area 3"),

    Tuple.Create(2, 4, "2-4-2-1", "Checkpoint 1"),
    Tuple.Create(2, 4, "2-4-3-1", "Checkpoint 2"),
    Tuple.Create(2, 4, "2-4-4-1", "Checkpoint 3"),
    Tuple.Create(2, 4, "2-4-5-1", "Checkpoint 4"),
    Tuple.Create(2, 4, "2-4-6-1", "Checkpoint 5"),
    Tuple.Create(2, 4, "2-4-7-1", "Checkpoint 6"),
    Tuple.Create(2, 4, "2-4-8-1", "Checkpoint 7"),
    Tuple.Create(2, 4, "2-4-8-1-stageEnd", "Finishing Area 4"),

    Tuple.Create(2, 5, "2-5-2-1", "Checkpoint 1"),
    Tuple.Create(2, 5, "2-5-3-1", "Checkpoint 2"),
    Tuple.Create(2, 5, "2-5-4-1", "Checkpoint 3"),
    Tuple.Create(2, 5, "2-5-5-1", "Checkpoint 4"),
    Tuple.Create(2, 5, "2-5-6-1", "Checkpoint 5"),
    Tuple.Create(2, 5, "2-5-7-1", "Checkpoint 6"),
    Tuple.Create(2, 5, "2-5-8-1-stageEnd", "Finishing Area 5"),

    Tuple.Create(2, 6, "2-6-0-1-stageEnd", "Finishing Area 6"),

    Tuple.Create(3, 1, "3-1-2-1", "Checkpoint 1"),
    Tuple.Create(3, 1, "3-1-3-1", "Checkpoint 2"),
    Tuple.Create(3, 1, "3-1-4-1", "Checkpoint 3"),
    Tuple.Create(3, 1, "3-1-5-1", "Checkpoint 4"),
    Tuple.Create(3, 1, "3-1-6-1", "Checkpoint 5"),
    Tuple.Create(3, 1, "3-1-8-1", "Checkpoint 6 (Noir Space)"),
    Tuple.Create(3, 1, "3-1-9-1", "Checkpoint 7"),
    Tuple.Create(3, 1, "3-1-10-1-stageEnd", "Finishing Area 1"),

    Tuple.Create(3, 2, "3-2-2-1", "Checkpoint 1"),
    Tuple.Create(3, 2, "3-2-3-2", "Checkpoint 2"),
    Tuple.Create(3, 2, "3-2-4-1", "Checkpoint 3"),
    Tuple.Create(3, 2, "3-2-5-1", "Checkpoint 4"),
    Tuple.Create(3, 2, "3-2-6-1", "Checkpoint 5"),
    Tuple.Create(3, 2, "3-2-6-3", "Checkpoint 6"),
    Tuple.Create(3, 2, "3-2-7-1", "Checkpoint 7"),
    Tuple.Create(3, 2, "3-2-8-1", "Checkpoint 8"),
    Tuple.Create(3, 2, "3-2-9-1", "Checkpoint 9"),
    Tuple.Create(3, 2, "3-2-10-1", "Checkpoint 10"),
    Tuple.Create(3, 2, "3-2-11-1", "Checkpoint 11"),
    Tuple.Create(3, 2, "3-2-12-1", "Checkpoint 12 (Boss Start)"),
    Tuple.Create(3, 2, "3-2-12-2-stageEnd", "Finishing Area 2"),

    Tuple.Create(3, 3, "3-3-2-1", "Checkpoint 1"),
    Tuple.Create(3, 3, "3-3-3-1", "Checkpoint 2"),
    Tuple.Create(3, 3, "3-3-1-3", "Checkpoint 3"),
    Tuple.Create(3, 3, "3-3-4-1", "Checkpoint 4"),
    Tuple.Create(3, 3, "3-3-5-1", "Checkpoint 5"),
    Tuple.Create(3, 3, "3-3-6-1", "Checkpoint 6"),
    Tuple.Create(3, 3, "3-3-7-1", "Checkpoint 7"),
    Tuple.Create(3, 3, "3-3-8-1", "Checkpoint 8"),
    Tuple.Create(3, 3, "3-3-9-1", "Checkpoint 9"),
    Tuple.Create(3, 3, "3-3-10-1", "Checkpoint 10"),
    Tuple.Create(3, 3, "3-3-4-1-stageEnd", "Finishing Area 3"),

    Tuple.Create(3, 4, "3-4-2-1", "Checkpoint 1"),
    Tuple.Create(3, 4, "3-4-3-1", "Checkpoint 2"),
    Tuple.Create(3, 4, "3-4-4-1", "Checkpoint 3"),
    Tuple.Create(3, 4, "3-4-5-1", "Checkpoint 4"),
    Tuple.Create(3, 4, "3-4-6-1", "Checkpoint 5"),
    Tuple.Create(3, 4, "3-7-0-1", "Checkpoint 6 (Noir Space) "),
    Tuple.Create(3, 4, "3-4-7-1", "Checkpoint 7"),
    Tuple.Create(3, 4, "3-4-8-1-stageEnd", "Finishing Area 4"),

    Tuple.Create(3, 5, "3-5-1-3", "Checkpoint 1"),
    Tuple.Create(3, 5, "3-5-2-1", "Checkpoint 2"),
    Tuple.Create(3, 5, "3-5-3-1", "Checkpoint 3"),
    Tuple.Create(3, 5, "3-5-4-1", "Checkpoint 4"),
    Tuple.Create(3, 5, "3-5-4-1-stageEnd", "Finishing Area 5"),

    Tuple.Create(3, 6, "3-6-2-1-stageEnd", "Finishing Area 6"),

    Tuple.Create(4, 1, "4-1-2-1", "Checkpoint 1"),
    Tuple.Create(4, 1, "4-1-3-1", "Checkpoint 2"),
    Tuple.Create(4, 1, "4-1-4-1", "Checkpoint 3"),
    Tuple.Create(4, 1, "4-1-5-1", "Checkpoint 4"),
    Tuple.Create(4, 1, "4-1-6-1", "Checkpoint 5"),
    Tuple.Create(4, 1, "4-1-7-1", "Checkpoint 6"),
    Tuple.Create(4, 1, "4-1-8-1", "Checkpoint 7"),
    Tuple.Create(4, 1, "4-1-8-2-stageEnd", "Finishing Area 1"),

    Tuple.Create(4, 2, "4-2-2-1", "Checkpoint 1"),
    Tuple.Create(4, 2, "4-2-3-1", "Checkpoint 2"),
    Tuple.Create(4, 2, "4-2-4-1", "Checkpoint 3"),
    Tuple.Create(4, 2, "4-2-5-1", "Checkpoint 4"),
    Tuple.Create(4, 2, "4-2-6-1", "Checkpoint 5"),
    Tuple.Create(4, 2, "4-2-7-1", "Checkpoint 6"),
    Tuple.Create(4, 2, "4-2-8-1", "Checkpoint 7"),
    Tuple.Create(4, 2, "4-2-9-1", "Checkpoint 8"),
    Tuple.Create(4, 2, "4-2-9-2-stageEnd", "Finishing Area 2"),

    Tuple.Create(4, 3, "4-3-2-1", "Checkpoint 1"),
    Tuple.Create(4, 3, "4-3-3-1", "Checkpoint 2"),
    Tuple.Create(4, 3, "4-3-4-1", "Checkpoint 3"),
    Tuple.Create(4, 3, "4-3-5-1", "Checkpoint 4"),
    Tuple.Create(4, 3, "4-3-6-1", "Checkpoint 5"),
    Tuple.Create(4, 3, "4-3-7-1", "Checkpoint 6"),
    Tuple.Create(4, 3, "4-3-8-1", "Checkpoint 7"),
    Tuple.Create(4, 3, "4-3-8-4-stageEnd", "Finishing Area 3"),

    Tuple.Create(4, 4, "4-4-2-1", "Checkpoint 1"),
    Tuple.Create(4, 4, "4-5-1-1", "Checkpoint 2 (Boss Start)"),
    Tuple.Create(4, 4, "4-5-3-1", "Checkpoint 3 (Attack 1 Start)"),
    Tuple.Create(4, 4, "4-5-6-1", "Checkpoint 4 (Attack 2 Start)"),
    Tuple.Create(4, 4, "4-5-8-1", "Checkpoint 4 (Attack 2 Start)"),
    Tuple.Create(4, 4, "4-5-10-1-stageEnd", "Finishing Area 4"),

    Tuple.Create(4, 5, "4-6-2-1", "Checkpoint 1"),
    Tuple.Create(4, 5, "4-6-3-1", "Checkpoint 2"),
    Tuple.Create(4, 5, "4-6-4-1", "Checkpoint 3"),
    Tuple.Create(4, 5, "4-6-5-1", "Checkpoint 4"),
    Tuple.Create(4, 5, "4-6-6-1", "Checkpoint 5"),
    Tuple.Create(4, 5, "4-6-7-1", "Checkpoint 6"),
    Tuple.Create(4, 5, "4-6-8-1", "Checkpoint 7"),
    Tuple.Create(4, 5, "4-6-8-1-stageEnd", "Finishing Area 5"),

    Tuple.Create(4, 6, "4-7-4-1", "Checkpoint 1"),
    Tuple.Create(4, 6, "4-7-4-1-stageEnd", "Finishing Area 6"),

    Tuple.Create(5, 1, "5-1-1-2", "Checkpoint 1"),
    Tuple.Create(5, 1, "5-1-1-3", "Checkpoint 2"),
    Tuple.Create(5, 1, "5-1-1-4", "Checkpoint 3"),
    Tuple.Create(5, 1, "5-1-1-5", "Checkpoint 4"),
    Tuple.Create(5, 1, "5-1-1-6-stageEnd", "Finishing Area 1"),

    Tuple.Create(5, 2, "5-2-2-1", "Checkpoint 1"),
    Tuple.Create(5, 2, "5-2-3-1", "Checkpoint 2"),
    Tuple.Create(5, 2, "5-2-3-1-stageEnd", "Finishing Area 2")
  };

  settings.Add("currStageDisplay", false, "Display current chapter, area, checkpoint, & sub-checkpoint");
  settings.Add("ch1Splits", true, "Chapter 1 — The Birth:");
  settings.Add("ch2Splits", true, "Chapter 2 — The Surface:");
  settings.Add("ch3Splits", true, "Chapter 3 — The Monster:");
  settings.Add("ch4Splits", true, "Chapter 4 — The System:");
  settings.Add("ch5Splits", true, "Chapter 5 — The Purpose:");

  for (var ch = 1; ch <= 5; ch++) {
    if (ch < 5) {
      for (var a4 = 1; a4 <= 6; a4++) {
        settings.Add("ch" + ch.ToString() + "Area" + a4.ToString() + "Splits", true, "Area " + a4.ToString() + " splits:", "ch" + ch.ToString() + "Splits");
      }
    } else {
      for (var a5 = 1; a5 <= 2; a5++) {
        settings.Add("ch" + ch.ToString() + "Area" + a5.ToString() + "Splits", true, "Area " + a5.ToString() + " splits:", "ch" + ch.ToString() + "Splits");
      }
    }
  }

  foreach (var cp in vars.allStages) {
    string[] stageSplitter = cp.Item3.Split('-');
    //print(stageSplitter[stageSplitter.Length - 1]);
    if (stageSplitter[stageSplitter.Length - 1] == "stageEnd") {
      //print(">>>>> stageEnd fulfilled!");
      settings.Add(cp.Item3, true, cp.Item4, "ch" + cp.Item1.ToString() + "Area" + cp.Item2.ToString() + "Splits");
    } else {
      settings.Add(cp.Item3, false, cp.Item4, "ch" + cp.Item1.ToString() + "Area" + cp.Item2.ToString() + "Splits");
    }
  }

  vars.setTextComponent = (Action<string, string>)((id, text) => {
    var textSettings = timer.Layout.Components.Where(x => x.GetType().Name == "TextComponent").Select(x => x.GetType().GetProperty("Settings").GetValue(x, null));
    var textSetting = textSettings.FirstOrDefault(x => (x.GetType().GetProperty("Text1").GetValue(x, null) as string) == id);
    if (textSetting == null) {
      var textComponentAssembly = Assembly.LoadFrom("Components\\LiveSplit.Text.dll");
      var textComponent = Activator.CreateInstance(textComponentAssembly.GetType("LiveSplit.UI.Components.TextComponent"), timer);
      timer.Layout.LayoutComponents.Add(new LiveSplit.UI.Components.LayoutComponent("LiveSplit.Text.dll", textComponent as LiveSplit.UI.Components.IComponent));

      textSetting = textComponent.GetType().GetProperty("Settings", BindingFlags.Instance | BindingFlags.Public).GetValue(textComponent, null);
      textSetting.GetType().GetProperty("Text1").SetValue(textSetting, id);
    }

    if (textSetting != null)
    textSetting.GetType().GetProperty("Text2").SetValue(textSetting, text);
  });

  if (settings["currStageDisplay"])
    vars.setTextComponent("", "Please start the Game");
}

init {
  if (settings["currStageDisplay"])
    vars.setTextComponent("", "Please reach a valid Checkpoint");
  vars.currentStage = "1-1-1-1";
}

exit {
  if (timer.CurrentPhase != TimerPhase.Ended)
    vars.timerModel.Reset();
}

update {
  vars.currentStage =
    current.chapter.ToString() + "-" +
    current.area.ToString() + "-" +
    current.checkpoint.ToString() + "-" +
    (current.subCheckpoint + 1).ToString();

  if (settings["currStageDisplay"]) {
    if (((IEnumerable<Tuple<int, int, string, string>>)vars.allStages).Any(x => x.Item3.Equals(vars.currentStage))) {
      string output = "Ch. " + current.chapter + "–" + current.area + ", " + ((IEnumerable<Tuple<int, int, string, string>>)vars.allStages).Where(x => x.Item3.Equals(vars.currentStage)).FirstOrDefault().Item4 ?? "Not on a valid Checkpoint";
      vars.setTextComponent("", output);
    }
  }

  //print(timer.CurrentTime.RealTime.Value.TotalSeconds.ToString());
}

start {
  if (old.levelTime == 0.0 && current.levelTime > 0.0) {
    vars.finishedSplits.Clear();
    return true;
  }
}

split {
  if (old.chapter != current.chapter || old.area != current.area || old.checkpoint != current.checkpoint || old.subCheckpoint != current.subCheckpoint) {
    //print(">>>>> " + vars.currentStage);
    if (settings[vars.currentStage] && !vars.finishedSplits.Contains(vars.currentStage)) {
      vars.finishedSplits.Add(vars.currentStage);
      return true;
    }
  }

  return old.levelTime > 0 && current.levelTime == 0.0 && settings[vars.currentStage + "-stageEnd"];
}

reset {
  return
    current.chapter == 1 && current.area == 1 && current.checkpoint < 8 && old.levelTime > 0 && current.levelTime == 0.0 ||
    old.totalTime > 0 && current.totalTime == 0.0;
}

isLoading {
  return true;
}

gameTime {
  return TimeSpan.FromSeconds(current.totalTime + current.levelTime);
}
