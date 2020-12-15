state("where_is_2016") {
  int screen: "where_is_2016.exe", 0x0742C84, 0x214, 0x48;
}

/*state("where_is_2017") {
  int screen: 0x5CB860;
}*/

state("Where is 2018") {
  int screen: 0x6A7F98;
}

state("Where is 2019") {
  int screen: 0x6B2D88;
}

state("Where is 2020") {
  int screen: 0x6C2DB8;
}

init {
  vars.game = 0;
  switch (game.ProcessName) {
    case "where_is_2016": vars.game = 2016;
    case "where_is_2017": vars.game = 2017;
    case "Where is 2018": vars.game = 2018;
    case "Where is 2019": vars.game = 2019;
    case "Where is 2020": vars.game = 2020;
  }

  vars.screenChange = (Func(<int, int, bool>) ((old, curr) => {
    return old.screen == old && current.screen == curr ? true : false;
  });
}

start {

  switch ((int)vars.game) {
    case 2016: return vars.screenChange(8, 20);
    //case 2017: return vars.screenChange(3, 4);
    case 2018: return vars.screenChange(2, 3);
    case 2019: return vars.screenChange(3, 5);
    case 2020: return vars.screenChange(3, 6);
  }
}

reset {
  return
    vars.game != 2016 &&
    (old.screen != 2 && current.screen == 2 ||
    old.screen != 0 && current.screen == 0);
}

split {
  return
    vars.game == 2016 && current.screen == 20 && new[]{28, 44, 62}.Contains(old.screen);
    //vars.game == 2017 && current.screen > 8 && current.screen == old.screen + 1 ||
    vars.game == 2018 && old.screen != current.screen ||
    vars.game == 2019 && old.screen < current.screen && !(new[]{8, 9, 38, 39, 41}.Contains(old.screen)) ||
    vars.game == 2020 && old.screen < current.screen;
}
