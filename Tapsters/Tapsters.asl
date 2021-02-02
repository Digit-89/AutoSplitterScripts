state("Tapsters") {
	int coins : "mono-2.0-bdwgc.dll", 0x495A90, 0xD98, 0x620, 0x5D0, 0x0;
}

startup {
	vars.coinAmounts = new int[]{100, 1000, 5000, 10000, 50000, 100000, 500000, 1000000};

	foreach (int c in vars.coinAmounts) {
		int index = Array.IndexOf(vars.coinAmounts, c);
		settings.Add(c.ToString(), false, (index == 0 ? c.ToString() : index == vars.coinAmounts.Length - 1 ? "1 m" : (c / 1000).ToString() + " k") + " coins");
	}

	vars.doneSplits = new HashSet<int>();

	vars.onStart = (EventHandler)((s, e) => { vars.doneSplits.Clear(); });
	timer.OnStart += vars.onStart;
}

start {
	return old.coins == 0 && current.coins > 0;
}

split {
	foreach (int c in vars.coinAmounts)
		if (old.coins < c && current.coins >= c && settings[c.ToString()] && !vars.doneSplits.Contains(c)) {
			vars.doneSplits.Add(c);
			return true;
		}
}

reset {
	return old.coins > 0 && new[]{10, 100, 500}.All(x => x != old.coins) && current.coins == 0;
}

shutdown {
	timer.OnStart += vars.onStart;
}
