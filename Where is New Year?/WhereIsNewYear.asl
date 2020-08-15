state("where_is_2016") {
  int screen: "where_is_2016.exe", 0x0742C84, 0x214, 0x48;
}

/*state("where_is_2017") {
  int screen: 0xB43B0, 0x0;
  //static address: where_is_2017.exe+5CB860
}*/

state("Where is 2018") {
  int screen: 0x00DC7B8, 0x0;
  //static address: "Where is 2018.exe"+6A7F98
}

state("Where is 2019") {
  int screen: 0x00FFF00, 0x0;
  //static address: "Where is 2019.exe"+6B2D88
}

state("Where is 2020") {
  int screen: 0x0101780, 0x0;
  //static address: "Where is 2020.exe"+6C2DB8
}

start {		
  return
    (game.ProcessName == "where_is_2016" && old.screen == 8 && current.screen == 20) ||
    // (game.ProcessName == "where_is_2017" && old.screen == 3 && current.screen == 4) ||
    (game.ProcessName == "Where is 2018" && old.screen == 2 && current.screen == 3) ||
    (game.ProcessName == "Where is 2019" && old.screen == 3 && current.screen == 5) ||
    (game.ProcessName == "Where is 2020" && old.screen == 3 && current.screen == 6) ;
}

reset {
  return
    game.ProcessName != "where_is_2016" &&
    (old.screen != 2 && current.screen == 2 ||
    old.screen != 0 && current.screen == 0);
}

split {
  if (game.ProcessName == "where_is_2016") {
    return
      current.screen == 20 && (old.screen == 28 || old.screen == 44 || old.screen == 62);
  }

  return
    // (game.ProcessName == "where_is_2017" && current.screen > 8 && current.screen == old.screen + 1) ||
    (game.ProcessName == "Where is 2018" && old.screen != current.screen) ||
    (game.ProcessName == "Where is 2019" && old.screen != 8 && old.screen != 9 && old.screen != 38 && old.screen != 39 && old.screen != 41 && old.screen < current.screen) ||
    (game.ProcessName == "Where is 2020" && old.screen < current.screen);
}
