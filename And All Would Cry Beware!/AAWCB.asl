state("AndAllWouldCryBeware") {
    int area  : "UnityPlayer.dll", 0x1092D68, 0xE48;
    int entities: "UnityPlayer.dll", 0x10545C0, 0x9CC, 0x28, 0x8, 0x84, 0x210;
}

startup {
    settings.Add("areasplits", true, "Split when entering a new area");
        settings.Add("7to21", false, "Wayfarer Offices", "areasplits");
        settings.Add("21to27", true, "Mysterious Alien World", "areasplits");
        settings.Add("16to11", true, "A Fresh Start", "areasplits");

    settings.Add("eventsplits", false, "Split when doing certain events");
        settings.Add("7-6", false, "Pick up Pistol", "eventsplits");
        settings.Add("6-5", false, "Pick up Green Key", "eventsplits");
        settings.Add("5-4", false, "Destroy Elevator", "eventsplits");
        settings.Add("4-3", false, "Defeat Security Mech", "eventsplits");
        settings.Add("MAW", false, "Defeat any boss in the Mysterious Alien World or collect Fire Orb", "eventsplits");
        settings.Add("16to7", false, "Defeat Transformed Rebekah", "eventsplits");
}

init {
    vars.lastRealArea = 0;
    vars.storeNewArea = 0;
    vars.allRealAreas = new HashSet<int>() { 7, 11, 16, 21, 27 };
}

update {
    if (old.area != current.area && vars.allRealAreas.Contains(current.area)) {
        vars.storeNewArea = current.area;
    }
}

start {
    if (old.area != 7 && current.area == 7) {
        vars.lastRealArea = current.area;
        vars.storeNewArea = current.area;
        return true;
    }
}

split {
    if (old.area != current.area && vars.allRealAreas.Contains(vars.lastRealArea) && vars.allRealAreas.Contains(vars.storeNewArea)) {
        if (settings[vars.lastRealArea.ToString() + "to" + vars.storeNewArea.ToString()]) {
            print(">>>>> got split because lastRealArea is " + vars.lastRealArea + " and storeNewArea is " + vars.storeNewArea);
            vars.lastRealArea = vars.storeNewArea;
            return true;
        } else if (vars.allRealAreas.Contains(vars.lastRealArea) && vars.storeNewArea == 21 ||
                   vars.allRealAreas.Contains(vars.lastRealArea) && vars.storeNewArea == 27) {
            vars.lastRealArea = vars.storeNewArea;
        }
    }
    
    return
        old.entities > current.entities && current.area == 21 && settings[old.entities.ToString() + "-" + current.entities.ToString()] ||
        old.entities == current.entities + 1 && current.area == 27 && settings["MAW"] ||
        vars.lastRealArea == 11 && old.area != 9 && current.area == 9 ||
        vars.lastRealArea == 7 && old.area != 8 && current.area == 8;
}
