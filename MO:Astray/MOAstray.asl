state("MOAstray") {
  int chapter      : 0x145CDE8, 0x3E8, 0xF8, 0x8, 0x18, 0x10, 0x58, 0x58, 0x20, 0x78;
  int area         : 0x145CDE8, 0x3E8, 0xF8, 0x8, 0x18, 0x10, 0x58, 0x58, 0x20, 0x7C;
  int checkpoint   : 0x145CDE8, 0x3E8, 0xF8, 0x8, 0x18, 0x10, 0x58, 0x58, 0x20, 0x80;
  int subCheckpoint: 0x145CDE8, 0x3E8, 0xF8, 0x8, 0x18, 0x10, 0x58, 0x58, 0x20, 0x84;
  //int inCutscene   : "mono.dll", 0x266180, 0x50, 0x7E0, 0x8, 0x20, 0x18, 0x20, 0x80; // broken
  float levelTime  : "mono.dll", 0x262A68, 0x50, 0xF18;
}

startup {
  vars.finishedSplits = new HashSet<string>();
  vars.timerModel = new TimerModel {CurrentState = timer};
  //vars.cutscenes = new Dictionary<Tuple<string, int>, Tuple<string, int>> {}; // potential use for cutscene timers
  //settings.Add("currStageDisplay", false, "Display current chapter, area, checkpoint, & sub-checkpoint");

  settings.Add("ch1Splits", true, "Chapter 1 — The Birth:");
    settings.Add("ch1Area1Splits", true, "Area 1 splits:", "ch1Splits");
      settings.Add("1-1-2-1", false, "Checkpoint 1", "ch1Area1Splits");
      settings.Add("1-1-3-1", false, "Checkpoint 2", "ch1Area1Splits");
      settings.Add("1-1-4-1", false, "Checkpoint 3", "ch1Area1Splits");
      settings.Add("1-1-5-1", false, "Checkpoint 4", "ch1Area1Splits");
        //settings.Add("1-1-5-2", false, "Checkpoint 4, Sub-Checkpoint 1", "ch1Area1Splits");
        //settings.Add("1-1-5-3", false, "Checkpoint 4, Sub-Checkpoint 2", "ch1Area1Splits");
      settings.Add("1-1-6-1", false, "Checkpoint 5", "ch1Area1Splits");
        //settings.Add("1-1-6-2", false, "Checkpoint 5, Sub-Checkpoint 1", "ch1Area1Splits");
      settings.Add("1-1-7-1", false, "Checkpoint 6", "ch1Area1Splits");
      settings.Add("1-1-8-1", false, "Checkpoint 7", "ch1Area1Splits");
      settings.Add("1-1-8-2-stageEnd", true, "Finishing Area 1", "ch1Area1Splits");
    settings.Add("ch1Area2Splits", true, "Area 2 splits:", "ch1Splits");
      settings.Add("1-2-2-1", false, "Checkpoint 1", "ch1Area2Splits");
      settings.Add("1-2-10-1", false, "Checkpoint 2 (Noir Space)", "ch1Area2Splits");
      settings.Add("1-2-3-1", false, "Checkpoint 3", "ch1Area2Splits");
      settings.Add("1-2-4-1", false, "Checkpoint 4", "ch1Area2Splits");
        //settings.Add("1-2-4-2", false, "Checkpoint 4, Sub-Checkpoint 1", "ch1Area2Splits");
      settings.Add("1-2-5-1", false, "Checkpoint 5", "ch1Area2Splits");
      settings.Add("1-2-6-1", false, "Checkpoint 6", "ch1Area2Splits");
      settings.Add("1-2-7-1", false, "Checkpoint 7", "ch1Area2Splits");
      settings.Add("1-2-8-1", false, "Checkpoint 8", "ch1Area2Splits");
      settings.Add("1-2-9-1", false, "Checkpoint 9", "ch1Area2Splits");
        //settings.Add("1-2-9-2", false, "Checkpoint 9, Sub-Checkpoint 1", "ch1Area2Splits");
      settings.Add("1-2-9-2-stageEnd", true, "Finishing Area 2", "ch1Area2Splits");
    settings.Add("ch1Area3Splits", true, "Area 3 splits:", "ch1Splits");
      settings.Add("1-3-1-2", false, "Checkpoint 1", "ch1Area3Splits");
      settings.Add("1-3-2-1", false, "Checkpoint 2", "ch1Area3Splits");
        //settings.Add("1-3-2-2", false, "Checkpoint 2, Sub-Checkpoint 1", "ch1Area3Splits");
      settings.Add("1-3-3-1", false, "Checkpoint 3", "ch1Area3Splits");
      settings.Add("1-3-4-1", false, "Checkpoint 4", "ch1Area3Splits");
      settings.Add("1-3-5-1", false, "Checkpoint 5", "ch1Area3Splits");
      settings.Add("1-3-6-1", false, "Checkpoint 6", "ch1Area3Splits");
      settings.Add("1-3-7-1", false, "Checkpoint 7", "ch1Area3Splits");
      settings.Add("1-3-8-1", false, "Checkpoint 8", "ch1Area3Splits");
        //settings.Add("1-3-8-2", false, "Checkpoint 8, Sub-Checkpoint 1", "ch1Area3Splits");
      settings.Add("1-3-8-2-stageEnd", true, "Finishing Area 3", "ch1Area3Splits");
    settings.Add("ch1Area4Splits", true, "Area 4 splits:", "ch1Splits"); // CONFUSION HERE
      settings.Add("1-4-2-1", false, "Checkpoint 1", "ch1Area4Splits");
      settings.Add("1-4-3-1", false, "Checkpoint 2", "ch1Area4Splits");
      settings.Add("1-4-4-1", false, "Checkpoint 3", "ch1Area4Splits");
      settings.Add("1-4-5-1", false, "Checkpoint 4", "ch1Area4Splits");
        //settings.Add("1-4-5-2", false, "Checkpoint 4, Sub-Checkpoint 1", "ch1Area4Splits");
      settings.Add("1-4-6-1", false, "Checkpoint 5", "ch1Area4Splits"); // CONFUSION HERE
        //settings.Add("1-4-6-2", false, "Checkpoint 5, Sub-Checkpoint 1", "ch1Area4Splits");
      settings.Add("1-4-7-1", false, "Checkpoint 6", "ch1Area4Splits");
      settings.Add("1-4-8-1", false, "Checkpoint 7", "ch1Area4Splits");
        //settings.Add("1-4-8-2", false, "Checkpoint 7, Sub-Checkpoint 1", "ch1Area4Splits");
      settings.Add("1-4-8-2-stageEnd", true, "Finishing Area 4", "ch1Area4Splits");
    settings.Add("ch1Area5Splits", true, "Area 5 splits:", "ch1Splits");
      settings.Add("1-5-2-1", false, "Checkpoint 1", "ch1Area5Splits");
      settings.Add("1-5-3-1", false, "Checkpoint 2", "ch1Area5Splits");
      settings.Add("1-5-4-1", false, "Checkpoint 3", "ch1Area5Splits");
      settings.Add("1-5-5-1", false, "Checkpoint 4", "ch1Area5Splits");
      settings.Add("1-5-6-1", false, "Checkpoint 5", "ch1Area5Splits");
        //settings.Add("1-5-6-2", false, "Checkpoint 5, Sub-Checkpoint 1", "ch1Area5Splits");
        //settings.Add("1-5-6-3", false, "Checkpoint 5, Sub-Checkpoint 2", "ch1Area5Splits");
      settings.Add("1-5-7-1", false, "Checkpoint 6", "ch1Area5Splits");
        //settings.Add("1-5-7-2", false, "Checkpoint 6, Sub-Checkpoint 1", "ch1Area5Splits");
      settings.Add("1-5-8-1", false, "Checkpoint 7", "ch1Area5Splits");
      settings.Add("1-5-9-1", false, "Checkpoint 8", "ch1Area5Splits");
      settings.Add("1-5-10-1", false, "Checkpoint 9", "ch1Area5Splits");
      settings.Add("1-5-11-1", false, "Checkpoint 10", "ch1Area5Splits");
      //settings.Add("1-5-12-1", false, "Checkpoint 11", "ch1Area5Splits");
      settings.Add("1-5-12-1-stageEnd", true, "Finishing Area 5", "ch1Area5Splits");
    settings.Add("ch1Area6Splits", true, "Area 6 splits:", "ch1Splits"); // when start?
      //settings.Add("1-6-1-1", false, "Checkpoint 1 (before Boss)", "ch1Area6Splits"); // when start?
      //settings.Add("1-6-3-1", false, "Checkpoint 2 (after Boss)", "ch1Area6Splits");
        //settings.Add("1-6-3-2", false, "Checkpoint 2, Sub-Checkpoint 1", "ch1Area6Splits");
      settings.Add("1-6-3-2-stageEnd", true, "Finishing Area 6", "ch1Area6Splits");

  settings.Add("ch2Splits", true, "Chapter 2 — The Surface:");
    settings.Add("ch2Area1Splits", true, "Area 1 splits:", "ch2Splits");
      settings.Add("2-1-2-1", false, "Checkpoint 1", "ch2Area1Splits");
      settings.Add("2-1-3-1", false, "Checkpoint 2", "ch2Area1Splits");
      settings.Add("2-1-4-1", false, "Checkpoint 3", "ch2Area1Splits");
      settings.Add("2-1-5-1", false, "Checkpoint 4", "ch2Area1Splits");
        //settings.Add("2-1-5-2", false, "Checkpoint 4, Sub-Checkpoint 1", "ch2Area1Splits");
      settings.Add("2-1-6-1", false, "Checkpoint 5", "ch2Area1Splits");
      settings.Add("2-1-9-1", false, "Checkpoint 6 (Noir Space)", "ch2Area1Splits");
      settings.Add("2-1-6-2", false, "Checkpoint 7", "ch2Area1Splits");
        //settings.Add("2-1-6-3", false, "Checkpoint 7, Sub-Checkpoint 1", "ch2Area1Splits");
      settings.Add("2-1-7-1", false, "Checkpoint 8", "ch2Area1Splits");
      //settings.Add("2-1-8-1", false, "Checkpoint 8", "ch2Area1Splits");
      settings.Add("2-1-8-1-stageEnd", true, "Finishing Area 1", "ch2Area1Splits");
    settings.Add("ch2Area2Splits", true, "Area 2 splits:", "ch2Splits");
      settings.Add("2-2-2-1", false, "Checkpoint 1", "ch2Area2Splits");
        //settings.Add("2-2-2-2", false, "Checkpoint 1, Sub-Checkpoint 1", "ch2Area2Splits");
      settings.Add("2-2-3-1", false, "Checkpoint 2", "ch2Area2Splits");
      settings.Add("2-2-4-1", false, "Checkpoint 3", "ch2Area2Splits");
      settings.Add("2-2-5-1", false, "Checkpoint 4", "ch2Area2Splits");
      settings.Add("2-2-6-1", false, "Checkpoint 5", "ch2Area2Splits");
        //settings.Add("2-2-6-2", false, "Checkpoint 5, Sub-Checkpoint 1", "ch2Area2Splits");
        //settings.Add("2-2-6-4", false, "Checkpoint 5, Sub-Checkpoint 2", "ch2Area2Splits");
      settings.Add("2-2-7-1", false, "Checkpoint 6", "ch2Area2Splits");
        //settings.Add("2-2-7-2", false, "Checkpoint 6, Sub-Checkpoint 1", "ch2Area2Splits");
      settings.Add("2-2-7-3", false, "Checkpoint 7", "ch2Area2Splits");
      settings.Add("2-2-8-1", false, "Checkpoint 8", "ch2Area2Splits");
        //settings.Add("2-2-8-2", false, "Checkpoint 8, Sub-Checkpoint 1", "ch2Area2Splits");
        //settings.Add("2-2-8-3", false, "Checkpoint 8, Sub-Checkpoint 2", "ch2Area2Splits");
        //settings.Add("2-2-8-4", false, "Checkpoint 8, Sub-Checkpoint 3", "ch2Area2Splits");
        //settings.Add("2-2-8-5", false, "Checkpoint 8, Sub-Checkpoint 4", "ch2Area2Splits");
      settings.Add("2-2-8-5-stageEnd", true, "Finishing Area 2", "ch2Area2Splits");
    settings.Add("ch2Area3Splits", true, "Area 3 splits:", "ch2Splits");
      settings.Add("2-3-2-1", false, "Checkpoint 1", "ch2Area3Splits");
        //settings.Add("2-3-2-2", false, "Checkpoint 1, Sub-Checkpoint 1", "ch2Area3Splits");
      settings.Add("2-3-3-1", false, "Checkpoint 2", "ch2Area3Splits");
      settings.Add("2-3-4-1", false, "Checkpoint 3", "ch2Area3Splits");
      settings.Add("2-3-5-1", false, "Checkpoint 4", "ch2Area3Splits");
      settings.Add("2-3-6-1", false, "Checkpoint 5", "ch2Area3Splits");
      settings.Add("2-3-7-1", false, "Checkpoint 6", "ch2Area3Splits");
        //settings.Add("2-3-7-2", false, "Checkpoint 6, Sub-Checkpoint 1", "ch2Area3Splits");
        //settings.Add("2-3-7-3", false, "Checkpoint 6, Sub-Checkpoint 2", "ch2Area3Splits");
        //settings.Add("2-3-7-4", false, "Checkpoint 6, Sub-Checkpoint 3", "ch2Area3Splits");
      settings.Add("2-3-8-1", false, "Checkpoint 7", "ch2Area3Splits");
        //settings.Add("2-3-8-2", false, "Checkpoint 7, Sub-Checkpoint 1", "ch2Area3Splits");
        //settings.Add("2-3-8-3", false, "Checkpoint 7, Sub-Checkpoint 2", "ch2Area3Splits");
      settings.Add("2-3-9-1", false, "Checkpoint 8", "ch2Area3Splits");
        //settings.Add("2-3-9-2", false, "Checkpoint 8, Sub-Checkpoint 1", "ch2Area3Splits");
      settings.Add("2-3-9-2-stageEnd", true, "Finishing Area 3", "ch2Area3Splits");
    settings.Add("ch2Area4Splits", true, "Area 4 splits:", "ch2Splits");
      settings.Add("2-4-2-1", false, "Checkpoint 1", "ch2Area4Splits");
      settings.Add("2-4-3-1", false, "Checkpoint 2", "ch2Area4Splits");
      settings.Add("2-4-4-1", false, "Checkpoint 3", "ch2Area4Splits");
        //settings.Add("2-4-4-2", false, "Checkpoint 3, Sub-Checkpoint 1", "ch2Area4Splits");
      settings.Add("2-4-5-1", false, "Checkpoint 4", "ch2Area4Splits");
        //settings.Add("2-4-5-2", false, "Checkpoint 4, Sub-Checkpoint 1", "ch2Area4Splits");
      settings.Add("2-4-6-1", false, "Checkpoint 5", "ch2Area4Splits");
        //settings.Add("2-4-6-2", false, "Checkpoint 5, Sub-Checkpoint 1", "ch2Area4Splits");
      settings.Add("2-4-7-1", false, "Checkpoint 6", "ch2Area4Splits");
        //settings.Add("2-4-7-2", false, "Checkpoint 6, Sub-Checkpoint 1", "ch2Area4Splits");
        //settings.Add("2-4-7-3", false, "Checkpoint 6, Sub-Checkpoint 2", "ch2Area4Splits");
      settings.Add("2-4-8-1", false, "Checkpoint 7", "ch2Area4Splits");
      settings.Add("2-4-8-1-stageEnd", true, "Finishing Area 4", "ch2Area4Splits");
    settings.Add("ch2Area5Splits", true, "Area 5 splits:", "ch2Splits");
      settings.Add("2-5-2-1", false, "Checkpoint 1", "ch2Area5Splits");
      settings.Add("2-5-3-1", false, "Checkpoint 2", "ch2Area5Splits");
      settings.Add("2-5-4-1", false, "Checkpoint 3", "ch2Area5Splits");
      settings.Add("2-5-5-1", false, "Checkpoint 4", "ch2Area5Splits");
      settings.Add("2-5-6-1", false, "Checkpoint 5", "ch2Area5Splits");
      settings.Add("2-5-7-1", false, "Checkpoint 6", "ch2Area5Splits");
      //settings.Add("2-5-8-1", false, "Checkpoint 7", "ch2Area5Splits");
      settings.Add("2-5-8-1-stageEnd", true, "Finishing Area 5", "ch2Area5Splits");
    settings.Add("ch2Area6Splits", true, "Area 6 splits:", "ch2Splits");
      settings.Add("2-6-0-1-stageEnd", true, "Finishing Area 6", "ch2Area6Splits");

  settings.Add("ch3Splits", true, "Chapter 3 — The Monster:");
    settings.Add("ch3Area1Splits", true, "Area 1 splits:", "ch3Splits");
      //settings.Add("3-1-1-2", false, "Start, Sub-Checkpoint 1", "ch3Area1Splits");
      settings.Add("3-1-2-1", false, "Checkpoint 1", "ch3Area1Splits");
        //settings.Add("3-1-2-2", false, "Checkpoint 1, Sub-Checkpoint 1", "ch3Area1Splits");
      settings.Add("3-1-3-1", false, "Checkpoint 2", "ch3Area1Splits");
        //settings.Add("3-1-3-2", false, "Checkpoint 2, Sub-Checkpoint 1", "ch3Area1Splits");
        //settings.Add("3-1-3-3", false, "Checkpoint 2, Sub-Checkpoint 2", "ch3Area1Splits");
      settings.Add("3-1-4-1", false, "Checkpoint 3", "ch3Area1Splits");
      settings.Add("3-1-5-1", false, "Checkpoint 4", "ch3Area1Splits");
        //settings.Add("3-1-5-3", false, "Checkpoint 4, Sub-Checkpoint 1", "ch3Area1Splits");
      settings.Add("3-1-6-1", false, "Checkpoint 5", "ch3Area1Splits");
      settings.Add("3-1-8-1", false, "Checkpoint 6 (Noir Space)", "ch3Area1Splits");
      settings.Add("3-1-9-1", false, "Checkpoint 7", "ch3Area1Splits");
      //settings.Add("3-1-10-1", false, "Checkpoint 8", "ch3Area1Splits");
      settings.Add("3-1-10-1-stageEnd", true, "Finishing Area 1", "ch3Area1Splits");
    settings.Add("ch3Area2Splits", true, "Area 2 splits:", "ch3Splits");
      settings.Add("3-2-2-1", false, "Checkpoint 1", "ch3Area2Splits");
      settings.Add("3-2-3-2", false, "Checkpoint 2", "ch3Area2Splits");
      settings.Add("3-2-4-1", false, "Checkpoint 3", "ch3Area2Splits");
      settings.Add("3-2-5-1", false, "Checkpoint 4", "ch3Area2Splits");
        //settings.Add("3-2-5-2", false, "Checkpoint 4, Sub-Checkpoint 1", "ch3Area2Splits");
      settings.Add("3-2-6-1", false, "Checkpoint 5", "ch3Area2Splits");
        //settings.Add("3-2-6-2", false, "Checkpoint 5, Sub-Checkpoint 1", "ch3Area2Splits");
      settings.Add("3-2-6-3", false, "Checkpoint 6", "ch3Area2Splits");
      settings.Add("3-2-7-1", false, "Checkpoint 7", "ch3Area2Splits");
        //settings.Add("3-2-7-2", false, "Checkpoint 7, Sub-Checkpoint 1", "ch3Area2Splits");
      settings.Add("3-2-8-1", false, "Checkpoint 8", "ch3Area2Splits");
        //settings.Add("3-2-8-2", false, "Checkpoint 8, Sub-Checkpoint 1", "ch3Area2Splits");
      settings.Add("3-2-9-1", false, "Checkpoint 9", "ch3Area2Splits");
        //settings.Add("3-2-9-2", false, "Checkpoint 9, Sub-Checkpoint 1", "ch3Area2Splits");
      settings.Add("3-2-10-1", false, "Checkpoint 10", "ch3Area2Splits");
        //settings.Add("3-2-10-2", false, "Checkpoint 10, Sub-Checkpoint 1", "ch3Area2Splits");
      settings.Add("3-2-11-1", false, "Checkpoint 11", "ch3Area2Splits");
        //settings.Add("3-2-11-2", false, "Checkpoint 11, Sub-Checkpoint 1", "ch3Area2Splits");
      settings.Add("3-2-12-1", false, "Checkpoint 12 (Boss Start)", "ch3Area2Splits");
      //settings.Add("3-2-12-2", false, "Checkpoint 12", "ch3Area2Splits");
      settings.Add("3-2-12-2-stageEnd", true, "Finishing Area 2", "ch3Area2Splits");
    settings.Add("ch3Area3Splits", true, "Area 3 splits:", "ch3Splits");
      settings.Add("3-3-2-1", false, "Checkpoint 1", "ch3Area3Splits");
        //settings.Add("3-3-2-2", false, "Checkpoint 1, Sub-Checkpoint 1", "ch3Area3Splits");
        //settings.Add("3-3-2-3", false, "Checkpoint 1, Sub-Checkpoint 2", "ch3Area3Splits");
        //settings.Add("3-3-2-4", false, "Checkpoint 1, Sub-Checkpoint 3", "ch3Area3Splits");
        //settings.Add("3-3-2-5", false, "Checkpoint 1, Sub-Checkpoint 4", "ch3Area3Splits");
      settings.Add("3-3-3-1", false, "Checkpoint 2", "ch3Area3Splits");
      settings.Add("3-3-1-3", false, "Checkpoint 3", "ch3Area3Splits");
        //settings.Add("3-3-1-4", false, "Checkpoint 3, Sub-Checkpoint 1", "ch3Area3Splits");
      settings.Add("3-3-4-1", false, "Checkpoint 4", "ch3Area3Splits");
      settings.Add("3-3-5-1", false, "Checkpoint 5", "ch3Area3Splits");
        //settings.Add("3-3-5-2", false, "Checkpoint 5, Sub-Checkpoint 1", "ch3Area3Splits");
        //settings.Add("3-3-5-3", false, "Checkpoint 5, Sub-Checkpoint 2", "ch3Area3Splits");
      settings.Add("3-3-6-1", false, "Checkpoint 6", "ch3Area3Splits");
      settings.Add("3-3-7-1", false, "Checkpoint 7", "ch3Area3Splits");
      settings.Add("3-3-8-1", false, "Checkpoint 8", "ch3Area3Splits");
        //settings.Add("3-3-8-2", false, "Checkpoint 8, Sub-Checkpoint 1", "ch3Area3Splits");
        //settings.Add("3-3-8-3", false, "Checkpoint 8, Sub-Checkpoint 2", "ch3Area3Splits");
      settings.Add("3-3-9-1", false, "Checkpoint 9", "ch3Area3Splits");
        //settings.Add("3-3-9-2", false, "Checkpoint 9, Sub-Checkpoint 1", "ch3Area3Splits");
      settings.Add("3-3-10-1", false, "Checkpoint 10", "ch3Area3Splits");
        //settings.Add("3-3-10-2", false, "Checkpoint 10, Sub-Checkpoint 1", "ch3Area3Splits");
        //settings.Add("3-3-10-3", false, "Checkpoint 10, Sub-Checkpoint 2", "ch3Area3Splits");
      settings.Add("3-3-4-1-stageEnd", true, "Finishing Area 3", "ch3Area3Splits");
    settings.Add("ch3Area4Splits", true, "Area 4 splits:", "ch3Splits");
      settings.Add("3-4-2-1", false, "Checkpoint 1", "ch3Area4Splits");
        //settings.Add("3-4-2-2", false, "Checkpoint 1, Sub-Checkpoint 1", "ch3Area4Splits");
      settings.Add("3-4-3-1", false, "Checkpoint 2", "ch3Area4Splits");
      settings.Add("3-4-4-1", false, "Checkpoint 3", "ch3Area4Splits");
      settings.Add("3-4-5-1", false, "Checkpoint 4", "ch3Area4Splits");
      settings.Add("3-4-6-1", false, "Checkpoint 5", "ch3Area4Splits");
      settings.Add("3-7-0-1", false, "Checkpoint 6 (Noir Space) ", "ch3Area4Splits");
        //settings.Add("3-7-1-1", false, "Checkpoint 6, Sub-Checkpoint 1", "ch3Area4Splits");
        //settings.Add("3-7-2-1", false, "Checkpoint 6, Sub-Checkpoint 2", "ch3Area4Splits");
        //settings.Add("3-7-3-1", false, "Checkpoint 6, Sub-Checkpoint 3", "ch3Area4Splits");
        //settings.Add("3-7-4-1", false, "Checkpoint 6, Sub-Checkpoint 4", "ch3Area4Splits");
        //settings.Add("3-7-5-1", false, "Checkpoint 6, Sub-Checkpoint 5", "ch3Area4Splits");
        //settings.Add("3-7-6-1", false, "Checkpoint 6, Sub-Checkpoint 6", "ch3Area4Splits");
        //settings.Add("3-7-7-1", false, "Checkpoint 6, Sub-Checkpoint 6", "ch3Area4Splits");
      settings.Add("3-4-7-1", false, "Checkpoint 7", "ch3Area4Splits");
      //settings.Add("3-4-8-1", false, "Checkpoint 8", "ch3Area4Splits");
      settings.Add("3-4-8-1-stageEnd", true, "Finishing Area 4", "ch3Area4Splits");
    settings.Add("ch3Area5Splits", true, "Area 5 splits:", "ch3Splits");
      settings.Add("3-5-1-3", false, "Checkpoint 1", "ch3Area5Splits");
      settings.Add("3-5-2-1", false, "Checkpoint 2", "ch3Area5Splits");
        //settings.Add("3-5-2-2", false, "Checkpoint 2, Sub-Checkpoint 1", "ch3Area5Splits");
      settings.Add("3-5-3-1", false, "Checkpoint 3", "ch3Area5Splits");
        //settings.Add("3-5-3-2", false, "Checkpoint 3, Sub-Checkpoint 1", "ch3Area5Splits");
      settings.Add("3-5-4-1", false, "Checkpoint 4", "ch3Area5Splits");
      settings.Add("3-5-4-1-stageEnd", true, "Finishing Area 5", "ch3Area5Splits");
    settings.Add("ch3Area6Splits", true, "Area 6 splits:", "ch3Splits");
      //settings.Add("3-6-1-1", false, "Start (before Boss)", "ch3Area6Splits");
      //settings.Add("3-6-2-1", false, "Checkpoint 1 (after Boss)", "ch3Area6Splits");
      settings.Add("3-6-2-1-stageEnd", true, "Finishing Area 6", "ch3Area6Splits");

  settings.Add("ch4Splits", true, "Chapter 4 — The System:");
    settings.Add("ch4Area1Splits", true, "Area 1 splits:", "ch4Splits");
      settings.Add("4-1-2-1", false, "Checkpoint 1", "ch4Area1Splits");
        //settings.Add("4-1-2-2", false, "Checkpoint 1, Sub-Checkpoint 1", "ch4Area1Splits");
      settings.Add("4-1-3-1", false, "Checkpoint 2", "ch4Area1Splits");
        //settings.Add("4-1-3-2", false, "Checkpoint 2, Sub-Checkpoint 1", "ch4Area1Splits");
      settings.Add("4-1-4-1", false, "Checkpoint 3", "ch4Area1Splits");
        //settings.Add("4-1-4-2", false, "Checkpoint 3, Sub-Checkpoint 1", "ch4Area1Splits");
        //settings.Add("4-1-4-3", false, "Checkpoint 3, Sub-Checkpoint 2", "ch4Area1Splits");
      settings.Add("4-1-5-1", false, "Checkpoint 4", "ch4Area1Splits");
        //settings.Add("4-1-5-2", false, "Checkpoint 4, Sub-Checkpoint 1", "ch4Area1Splits");
      settings.Add("4-1-6-1", false, "Checkpoint 5", "ch4Area1Splits");
        //settings.Add("4-1-6-3", false, "Checkpoint 5, Sub-Checkpoint 1", "ch4Area1Splits");
        //settings.Add("4-1-6-4", false, "Checkpoint 5, Sub-Checkpoint 2", "ch4Area1Splits");
      settings.Add("4-1-7-1", false, "Checkpoint 6", "ch4Area1Splits");
        //settings.Add("4-1-7-2", false, "Checkpoint 6, Sub-Checkpoint 1", "ch4Area1Splits");
      settings.Add("4-1-8-1", false, "Checkpoint 7", "ch4Area1Splits");
        //settings.Add("4-1-8-2", false, "Checkpoint 7, Sub-Checkpoint 1", "ch4Area1Splits");
      settings.Add("4-1-8-2-stageEnd", true, "Finishing Area 1", "ch4Area1Splits");
    settings.Add("ch4Area2Splits", true, "Area 2 splits:", "ch4Splits");
      //settings.Add("4-2-1-2", false, "Start, Sub-Checkpoint 1", "ch4Area2Splits");
      settings.Add("4-2-2-1", false, "Checkpoint 1", "ch4Area2Splits");
        //settings.Add("4-2-2-2", false, "Checkpoint 1, Sub-Checkpoint 1", "ch4Area2Splits");
      settings.Add("4-2-3-1", false, "Checkpoint 2", "ch4Area2Splits");
      settings.Add("4-2-4-1", false, "Checkpoint 3", "ch4Area2Splits");
        //settings.Add("4-2-4-2", false, "Checkpoint 3, Sub-Checkpoint 1", "ch4Area2Splits");
      settings.Add("4-2-5-1", false, "Checkpoint 4", "ch4Area2Splits");
        //settings.Add("4-2-5-2", false, "Checkpoint 4, Sub-Checkpoint 1", "ch4Area2Splits");
      settings.Add("4-2-6-1", false, "Checkpoint 5", "ch4Area2Splits");
      settings.Add("4-2-7-1", false, "Checkpoint 6", "ch4Area2Splits");
      settings.Add("4-2-8-1", false, "Checkpoint 7", "ch4Area2Splits");
        //settings.Add("4-2-8-2", false, "Checkpoint 7, Sub-Checkpoint 1", "ch4Area2Splits");
        //settings.Add("4-2-8-3", false, "Checkpoint 7, Sub-Checkpoint 2", "ch4Area2Splits");
        //settings.Add("4-2-8-4", false, "Checkpoint 7, Sub-Checkpoint 3", "ch4Area2Splits");
      settings.Add("4-2-9-1", false, "Checkpoint 8", "ch4Area2Splits");
        //settings.Add("4-2-9-2", false, "Checkpoint 7, Sub-Checkpoint 1", "ch4Area2Splits");
      settings.Add("4-2-9-2-stageEnd", true, "Finishing Area 2", "ch4Area2Splits");
    settings.Add("ch4Area3Splits", true, "Area 3 splits:", "ch4Splits");
      settings.Add("4-3-2-1", false, "Checkpoint 1", "ch4Area3Splits");
      settings.Add("4-3-3-1", false, "Checkpoint 2", "ch4Area3Splits");
        //settings.Add("4-3-3-2", false, "Checkpoint 2, Sub-Checkpoint 1", "ch4Area3Splits");
      settings.Add("4-3-4-1", false, "Checkpoint 3", "ch4Area3Splits");
        //settings.Add("4-3-4-2", false, "Checkpoint 3, Sub-Checkpoint 1", "ch4Area3Splits");
      settings.Add("4-3-5-1", false, "Checkpoint 4", "ch4Area3Splits");
        //settings.Add("4-3-5-2", false, "Checkpoint 4, Sub-Checkpoint 1", "ch4Area3Splits");
      settings.Add("4-3-6-1", false, "Checkpoint 5", "ch4Area3Splits");
        //settings.Add("4-3-6-2", false, "Checkpoint 5, Sub-Checkpoint 1", "ch4Area3Splits");
        //settings.Add("4-3-6-3", false, "Checkpoint 5, Sub-Checkpoint 2", "ch4Area3Splits");
      settings.Add("4-3-7-1", false, "Checkpoint 6", "ch4Area3Splits");
        //settings.Add("4-3-7-2", false, "Checkpoint 6, Sub-Checkpoint 1", "ch4Area3Splits");
        //settings.Add("4-3-7-3", false, "Checkpoint 6, Sub-Checkpoint 2", "ch4Area3Splits");
      settings.Add("4-3-8-1", false, "Checkpoint 7", "ch4Area3Splits");
        //settings.Add("4-3-8-2", false, "Checkpoint 7, Sub-Checkpoint 1", "ch4Area3Splits");
        //settings.Add("4-3-8-3", false, "Checkpoint 7, Sub-Checkpoint 2", "ch4Area3Splits");
        //settings.Add("4-3-8-4", false, "Checkpoint 7, Sub-Checkpoint 3", "ch4Area3Splits");
      settings.Add("4-3-8-4-stageEnd", true, "Finishing Area 3", "ch4Area3Splits");
    settings.Add("ch4Area4Splits", true, "Area 4 splits:", "ch4Splits");
      settings.Add("4-4-2-1", false, "Checkpoint 1", "ch4Area4Splits");
        //settings.Add("4-4-3-1", false, "Checkpoint 1, Sub-Checkpoint 1", "ch4Area4Splits");
        //settings.Add("4-4-4-1", false, "Checkpoint 1, Sub-Checkpoint 2", "ch4Area4Splits");
      settings.Add("4-5-2-1", false, "Checkpoint 2", "ch4Area4Splits");
        //settings.Add("4-5-3-1", false, "Checkpoint 2, Sub-Checkpoint 1", "ch4Area4Splits");
        //settings.Add("4-5-4-1", false, "Checkpoint 2, Sub-Checkpoint 2", "ch4Area4Splits");
        //settings.Add("4-5-5-1", false, "Checkpoint 2, Sub-Checkpoint 3", "ch4Area4Splits");
        //settings.Add("4-5-6-1", false, "Checkpoint 2, Sub-Checkpoint 4", "ch4Area4Splits");
        //settings.Add("4-5-7-1", false, "Checkpoint 2, Sub-Checkpoint 5", "ch4Area4Splits");
        //settings.Add("4-5-8-1", false, "Checkpoint 2, Sub-Checkpoint 6", "ch4Area4Splits");
        //settings.Add("4-5-9-1", false, "Checkpoint 2, Sub-Checkpoint 7", "ch4Area4Splits");
        //settings.Add("4-5-10-1", false, "Checkpoint 2, Sub-Checkpoint 8", "ch4Area4Splits");
      settings.Add("4-5-10-1-stageEnd", true, "Finishing Area 4", "ch4Area4Splits");
    settings.Add("ch4Area5Splits", true, "Area 5 splits:", "ch4Splits");
      //settings.Add("4-6-1-2", false, "Start, Sub-Checkpoint 1", "ch4Area6Splits");
      settings.Add("4-6-2-1", false, "Checkpoint 1", "ch4Area5Splits");
      settings.Add("4-6-3-1", false, "Checkpoint 2", "ch4Area5Splits");
      settings.Add("4-6-4-1", false, "Checkpoint 3", "ch4Area5Splits");
      settings.Add("4-6-5-1", false, "Checkpoint 4", "ch4Area5Splits");
      settings.Add("4-6-6-1", false, "Checkpoint 5", "ch4Area5Splits");
      settings.Add("4-6-7-1", false, "Checkpoint 6", "ch4Area5Splits");
      //settings.Add("4-6-7-2", false, "Checkpoint 6, Sub-Checkpoint 1", "ch4Area6Splits");
      settings.Add("4-6-8-1", false, "Checkpoint 7", "ch4Area5Splits");
      settings.Add("4-6-8-1-stageEnd", true, "Finishing Area 5", "ch4Area5Splits");
    settings.Add("ch4Area6Splits", true, "Area 6 splits:", "ch4Splits");
      settings.Add("4-7-4-1", false, "Checkpoint 1", "ch4Area6Splits");
      //settings.Add("4-7-7-2", false, "Checkpoint 1, Sub-Checkpoint 1", "ch4Area6Splits");
      settings.Add("4-7-4-1-stageEnd", true, "Finishing Area 6", "ch4Area6Splits");

  settings.Add("ch5Splits", true, "Chapter 5 — The Purpose:");
    settings.Add("ch5Area1Splits", true, "Area 1 splits:", "ch5Splits");
      settings.Add("5-1-1-2", false, "Checkpoint 1", "ch5Area1Splits");
      settings.Add("5-1-1-3", false, "Checkpoint 2", "ch5Area1Splits");
      settings.Add("5-1-1-4", false, "Checkpoint 3", "ch5Area1Splits");
      settings.Add("5-1-1-5", false, "Checkpoint 4", "ch5Area1Splits");
      settings.Add("5-1-1-6-stageEnd", true, "Finishing Area 1", "ch5Area1Splits");
    settings.Add("ch5Area2Splits", true, "Area 2 splits:", "ch5Splits");
      settings.Add("5-2-2-1", false, "Checkpoint 1", "ch5Area2Splits");
      settings.Add("5-2-3-1", true, "Finishing the Run", "ch5Area2Splits");
}

init {
  vars.currentStage = "1-1-1-1";
  vars.totalTime = 0;
}

exit {
  if (timer.CurrentPhase != TimerPhase.Ended)
    vars.timerModel.Reset();
}

/*update {
  print(timer.CurrentTime.RealTime.Value.TotalSeconds.ToString());
}*/

start {
  if (vars.currentStage == "1-1-1-1" && old.levelTime == 0.0 && current.levelTime > 0.0) {
    vars.totalTime = 0;
    return true;
  }
}

split {
  if (old.chapter != current.chapter || old.area != current.area || old.checkpoint != current.checkpoint || old.subCheckpoint != current.subCheckpoint) {
    vars.currentStage =
      current.chapter.ToString() + "-" +
      current.area.ToString() + "-" +
      current.checkpoint.ToString() + "-" +
      (current.subCheckpoint + 1).ToString();
    print(">>>>> " + vars.currentStage);
    if (settings[vars.currentStage] && !vars.finishedSplits.Contains(vars.currentStage)) {
      vars.finishedSplits.Add(vars.currentStage);
      return true;
    }
  }

  return old.levelTime > 0 && current.levelTime == 0.0 && settings[vars.currentStage + "-stageEnd"];
}

reset {
  return vars.currentStage == "1-1-0-0";
}

isLoading {
  return true;
}

gameTime {
  if (old.levelTime > 0 && current.levelTime == 0.0)
    vars.totalTime += old.levelTime;

  return TimeSpan.FromSeconds(vars.totalTime + current.levelTime);
}
