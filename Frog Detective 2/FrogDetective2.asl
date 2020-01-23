state("Frog_Detective_2") {
	int load: "UnityPlayer.dll", 0x1516CA8, 0xCAC;
}

startup {
	settings.Add("office", true, "Splits in the Office");
		settings.Add("office_phone.start", false, "after the Phone Call", "office");
		settings.Add("office_magnifier.start", false, "after grabbing the Magnifier", "office");
		settings.Add("office_lobstercop_intro.start", false, "after talking to Lobster Cop", "office");
		settings.Add("office_notebook.start", false, "after decorating the Notebook", "office");
		settings.Add("office_hallway_door.start", true, "after leaving the Office", "office");
		settings.Add("officewrapup_call.end", true, "after the final Phone Call (POSTGAME)", "office");

	settings.Add("warlock", true, "Splits in Warlock Woods");
		settings.Add("warlock_mandy.all_pies_found", true, "after finishing Mandy's Task", "warlock");
		settings.Add("warlock_victor.pie", false, "after finishing Victor's Task", "warlock");
		settings.Add("warlock_carlos.hat", false, "after finishing Carlos' Task", "warlock");
		settings.Add("warlock_noddy.rug", false, "after finishing Noddy's Task", "warlock");
		settings.Add("warlock_ralph.tools", false, "after finishing Ralph's Task", "warlock");
		settings.Add("warlock_mary.money", false, "after finishing Mary's Task", "warlock");
		settings.Add("warlock_susan.hook", false, "after finishing Susan's Task", "warlock");
		settings.Add("warlock_phone.end", false, "after talking to Barney", "warlock");
		settings.Add("warlock_glasses.start", false, "after finding the Glasses", "warlock");
		settings.Add("warlock_inviz_wiz_door.start", true, "after entering Lola's House", "warlock");
		settings.Add("wizhouse_wizard.start", true, "after talking to Lola", "warlock");
		settings.Add("parade_confront.end", false, "after being confronted by the Village", "warlock");
}

init {
	string logPath = Environment.GetEnvironmentVariable("appdata")+"\\..\\LocalLow\\Worm Club\\Frog Detective 2\\output_log.txt";
	try {
		FileStream fs = new FileStream(logPath, FileMode.Open, FileAccess.Write, FileShare.ReadWrite);
		fs.SetLength(0);
		fs.Close();
	} catch {
		print("Can't open Frog log");
	}
	vars.line = "";
	vars.reader = new StreamReader(new FileStream(logPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite));
	vars.canSplit = 0;
	vars.node = "";
}
 
exit {
	timer.IsGameTimePaused = true;
	vars.reader = null;
}

update {
	if (vars.reader == null) return false;
	vars.line = vars.reader.ReadLine();
}

reset {
	return (old.load != 4 && current.load == 4);
}

split {
    if (vars.canSplit == 0 && vars.line != null && vars.line.StartsWith("Running node")) {   
        vars.node = vars.line.Split(' ')[2];     
        print("got " + vars.node);
        if (settings[vars.node]) {
			vars.canSplit = 1;
		}
    }
    if (vars.canSplit == 1 && vars.line != null && settings[vars.node] && vars.line.StartsWith("--- Dialogue complete! ---")) {
	print("SPLIT");
        vars.canSplit = 0;
        return true;
    }
}

isLoading {
	return (current.load == 7 || current.load == 9);
}
