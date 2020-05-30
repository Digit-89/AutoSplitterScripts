state("A Proof of Concept 1.1") {
    int room: 0x6C2DB8;
    int time: 0x6C2DE0;
}

startup {
    settings.Add("libsplits", false, "Splits when going anywhere in Library:");
        settings.Add("12to11", false, "Enter Power Plant from Library", "libsplits");
        settings.Add("12to6", false, "Enter Main Frame from Library", "libsplits");
        settings.Add("12to5", false, "Enter Museum from Library", "libsplits");
        settings.Add("12to14", false, "Enter Woods from Library", "libsplits");
        settings.Add("12to15", false, "Enter Great Door from Library", "libsplits");

    settings.Add("libbacksplits", false, "Splits when arriving back in Library:");
        settings.Add("11to12", false, "Leave Power Plant to Library", "libbacksplits");
        settings.Add("7to12", false, "Leave Main Frame to Library", "libbacksplits");
        settings.Add("10to12", false, "Leave Back Door level to Library", "libbacksplits");
        settings.Add("5to12", false, "Leave Museum to Library", "libbacksplits");

    settings.Add("othersplits", false, "Other splits:");
        settings.Add("14to12", false, "Leave Woods to Library", "othersplits");
        settings.Add("15to13", false, "Enter Archive from Big Orb Room", "othersplits");


    settings.Add("framesplits", false, "Special Main Frame splits:");
        settings.Add("6to7", false, "Enter second Part of Main Frame", "framesplits");
        settings.Add("7to9", false, "Enter Back Door Corridor from Main Frame", "framesplits");
        settings.Add("9to10", false, "Enter Back Door level from Corridor", "framesplits");
}

start {
    return old.room == 1 && current.room == 4;
}

split {
    return old.room != current.room && settings[old.room + "to" + current.room];
}

reset {
    return
        old.room != 0 && old.room != 4 && current.room == 0 ||
        current.room == 0 && current.time > 250 && current.time < 280;
}