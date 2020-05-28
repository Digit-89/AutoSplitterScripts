state("DepanneurNocturne") {
    int money: "mono.dll", 0x01F72C4, 0x54, 0x288, 0x0, 0x44;
    int state: "UnityPlayer.dll", 0x0FF392C, 0x8;
}

startup {
    settings.Add("artifactsroom", true, "Split when entering Eugénie's room of artifacts");

    settings.Add("moneyplussplits", false, "Split when collecting a coin");
        settings.Add("plusmoney1", false, "Collect Coin N° 1", "moneyplussplits");
        settings.Add("plusmoney2", false, "Collect Coin N° 2", "moneyplussplits");
        settings.Add("plusmoney3", false, "Collect Coin N° 3", "moneyplussplits");
        settings.Add("plusmoney4", false, "Collect Coin N° 4", "moneyplussplits");
        settings.Add("plusmoney5", false, "Collect Coin N° 5", "moneyplussplits");
        settings.Add("plusmoney6", false, "Collect Coin N° 6", "moneyplussplits");
        settings.Add("plusmoney7", false, "Collect Coin N° 7", "moneyplussplits");
        settings.Add("plusmoney8", false, "Collect Coin N° 8", "moneyplussplits");
        settings.Add("plusmoney9", false, "Collect Coin N° 9", "moneyplussplits");
        settings.Add("plusmoney10", false, "Collect Coin N° 10", "moneyplussplits");
        settings.Add("plusmoney11", false, "Collect Coin N° 11", "moneyplussplits");
        settings.Add("plusmoney12", false, "Collect Coin N° 12", "moneyplussplits");
        settings.Add("plusmoney13", false, "Collect Coin N° 13", "moneyplussplits");
        settings.Add("plusmoney14", false, "Collect Coin N° 14", "moneyplussplits");
        settings.Add("plusmoney15", false, "Collect Coin N° 15", "moneyplussplits");

    settings.Add("moneyminussplits", false, "Split when using a coin");
        settings.Add("minusmoney1", false, "Use Coin N° 1", "moneyminussplits");
        settings.Add("minusmoney2", false, "Use Coin N° 2", "moneyminussplits");
        settings.Add("minusmoney3", false, "Use Coin N° 3", "moneyminussplits");
        settings.Add("minusmoney4", false, "Use Coin N° 4", "moneyminussplits");
        settings.Add("minusmoney5", false, "Use Coin N° 5", "moneyminussplits");
        settings.Add("minusmoney6", false, "Use Coin N° 6", "moneyminussplits");
        settings.Add("minusmoney7", false, "Use Coin N° 7", "moneyminussplits");
        settings.Add("minusmoney8", false, "Use Coin N° 8", "moneyminussplits");
        settings.Add("minusmoney9", false, "Use Coin N° 9", "moneyminussplits");
        settings.Add("minusmoney10", false, "Use Coin N° 10", "moneyminussplits");
        settings.Add("minusmoney11", false, "Use Coin N° 11", "moneyminussplits");
        settings.Add("minusmoney12", false, "Use Coin N° 12", "moneyminussplits");
        settings.Add("minusmoney13", false, "Use Coin N° 13", "moneyminussplits");
        settings.Add("minusmoney14", false, "Use Coin N° 14", "moneyminussplits");
        settings.Add("minusmoney15", false, "Use Coin N° 15", "moneyminussplits");
}

init {
    vars.gotMoney = 0;
    vars.usedMoney = 0;
}

update {
    if (old.money < current.money) {
        vars.gotMoney++;
    }

    if (old.money > current.money) {
        vars.useMoney++;
    }
}

start {
    if (old.state != current.state && current.state == 3) {
        vars.gotMoney = 0;
        vars.useMoney = 0;
        return true;
    }
}

split {
    return
        old.state == current.state - 1 ||
        old.state != current.state && current.state == 6 && settings["artifactsroom"] ||
        old.money < current.money && settings["plusmoney" + vars.gotMoney] ||
        old.money > current.money && settings["minusmoney" + vars.useMoney];
}

reset {
    return old.state != current.state && current.state == 2;
}
