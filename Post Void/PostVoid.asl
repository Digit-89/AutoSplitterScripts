state("Post Void") {
    double lvlid: 0x04B2780, 0x2C, 0x10, 0x18, 0x100;
    double fulltime: 0x04B2780, 0x2C, 0x10, 0x18, 0xE0;
    double lvltime: 0x04B2780, 0x2C, 0x10, 0x18, 0xD0;
}

startup {
    settings.Add("lvlSplits", true, "Choose which level(s) to split on:");
        settings.Add("0to1", true, "After Level 1", "lvlSplits");
        settings.Add("1to2", true, "After Level 2", "lvlSplits");
        settings.Add("2to3", true, "After Level 3", "lvlSplits");
        settings.Add("3to4", true, "After Level 4", "lvlSplits");
        settings.Add("4to5", true, "After Level 5", "lvlSplits");
        settings.Add("5to6", true, "After Level 6", "lvlSplits");
        settings.Add("6to7", true, "After Level 7", "lvlSplits");
        settings.Add("7to8", true, "After Level 8", "lvlSplits");
        settings.Add("8to9", true, "After Level 9", "lvlSplits");
        settings.Add("9to10", true, "After Level 10", "lvlSplits");
        settings.Add("finalSplit", true, "After Level 11", "lvlSplits");
}

init {
    vars.finalLevel = false;
}

start {
    if (old.fulltime == 0 && current.fulltime > 0) {
        vars.finalLevel = false;
        return true;
    }
}

split {
    if (current.lvlid == 10 && old.lvltime == 0) vars.finalLevel = true;
    return
        old.lvlid < current.lvlid && settings[old.lvlid + "to" + current.lvlid] ||
        vars.finalLevel == true && old.lvltime > 0 && current.lvltime == 0 && settings["finalSplit"];
}

reset {
    return current.fulltime == 0 && old.fulltime > 0;
}

isLoading {
    return true;
}

gameTime {
    if (current.fulltime != 0) return TimeSpan.FromSeconds(current.fulltime);
}
