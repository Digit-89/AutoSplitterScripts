state ("LoneLand-Win64-Shipping") {
  int   crystalNo : 0x3FB58E0, 0x128, 0x328;
  int   crystalID : 0x3A0C998, 0x280, 0xC8, 0x118, 0x38, 0x28, 0x0;
  float igt       : 0x3F93A20, 0x30, 0x384;
}

startup {
  settings.Add("crystalSplits", false, "Split when collecting crystals (numerical order):");
    settings.Add("crystal10", false, "Crystal No. 10", "crystalSplits");
    settings.Add("crystal20", false, "Crystal No. 20", "crystalSplits");
    settings.Add("crystal30", false, "Crystal No. 30", "crystalSplits");
    settings.Add("crystal40", false, "Crystal No. 40", "crystalSplits");
    settings.Add("crystal50", false, "Crystal No. 50", "crystalSplits");
    settings.Add("crystal60", false, "Crystal No. 60", "crystalSplits");
    settings.Add("crystal70", false, "Crystal No. 70", "crystalSplits");
    settings.Add("crystal80", false, "Crystal No. 80", "crystalSplits");
    settings.Add("crystal90", false, "Crystal No. 90", "crystalSplits");
    settings.Add("crystal100", false, "Crystal No. 100", "crystalSplits");
}

start {
  return old.igt <= 0.0 && current.igt > 0.0;
}

split {
  return
    old.crystalNo < current.crystalNo && settings["crystal" + current.crystalNo.ToString()] ||
    old.crystalID != current.crystalID && (current.crystalID == 295 || current.crystalID == 22);
}

reset {
  return old.igt > current.igt;
}