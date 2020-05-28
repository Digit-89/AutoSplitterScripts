state("DepanneurNocturne") {
    int money: "mono.dll", 0x01F72C4, 0x54, 0x288, 0x0, 0x44;
    int state: "UnityPlayer.dll", 0x0FF392C, 0x8;
}

startup {
    settings.Add("money+splits", false, "Split when collecting a coin");

    settings.Add("money-splits", false, "Split when using a coin");
}

start {
    return old.state == 2 && current.state == 3;
}

split {
    return
        old.state != current.state && current.state == 4 ||
        old.money < current.money && settings["money+splits"] ||
        old.money > current.money && settings["money-splits"];
}