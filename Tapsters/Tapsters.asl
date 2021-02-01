state("Tapsters") {
	int coins : "mono-2.0-bdwgc.dll", 0x495A90, 0xD98, 0x620, 0x5D0, 0x0;
}

startup {
	vars.coinAmounts = new List<int>();

	vars.onStart = (EventHandler)((s, e) => {
		vars.coinAmounts.Clear();
		for (int i = 1; i <= 10; i += 9) {
			for (int j = 1; j <= 9; ++j) {
				vars.coinAmounts.Add(i * j * 10000);
			}
		}

		vars.coinAmounts.Add(1000000);
	});

	vars.onStart(null, null);

	timer.OnStart += vars.onStart;

	vars.coinAmounts.Sort();

	foreach (int c in vars.coinAmounts)
		settings.Add(c.ToString(), false, c == 1000000 ? "1m" : (c / 1000).ToString() + "k");
}

start {
	return old.coins == 0 && current.coins > 0;
}

split {
	foreach (int c in vars.coinAmounts)
		if (old.coins < c && current.coins >= c && settings[c.ToString()]) {
			vars.coinAmounts.Remove(c);
			return true;
		}
}

reset {
	return old.coins > 0 && new[]{10, 100, 500}.All(x => x != old.coins) && current.coins == 0;
}

shutdown {
	timer.OnStart += vars.onStart;
}