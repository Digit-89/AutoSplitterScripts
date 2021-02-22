state("mx") {
	int playerID         : "mx.exe", 0x20D1B0;
	int playersInRace    : "mx.exe", 0x4325538;

	int firstLapCPs      : "mx.exe", 0x4323704;
	int normalLapCPs     : "mx.exe", 0x4323708;

	//double tickRate      : "mx.exe", 0x162B90;
	int raceTicks        : "mx.exe", 0x4324898;
	//int serverStartTicks : "mx.exe", 0x43248A0;

	string512 trackName  : "mx.exe", 0x43212B8, 0x0;
}

startup {
	vars.timerModel = new TimerModel { CurrentState = timer };

	settings.Add("cpNumberHint", true, "Display a hint when number of checkpoints and splits doesn't line up");

	timer.CurrentTimingMethod = TimingMethod.GameTime;
}

init {
	current.CPs = 0;
	vars.noSplit = false;
	vars.startTicks = 0;
	vars.checkpointWatcher = (MemoryWatcher<int>)null;
	vars.idWatcher = (MemoryWatcher<int>)null;

	vars.updateWatchers = (Action) (() => {
		if (current.playersInRace > 0) {
			IntPtr ptr = IntPtr.Zero;
			for (int i = 0; i < current.playersInRace; ++i) {
				vars.idWatcher = new MemoryWatcher<int>(new DeepPointer("mx.exe", 0x4324DB8 + 0xC * i));
				vars.idWatcher.Update(game);

				if (vars.idWatcher.Current == current.playerID) {
					vars.checkpointWatcher = new MemoryWatcher<int>(new DeepPointer("mx.exe", 0x4324DBC + 0xC * i));
					break;
				}
			}
		}
	});

	vars.message = (Action) (() => {
		if (settings["cpNumberHint"] && current.normalLapCPs > 0 && timer.Run.Count != current.normalLapCPs)
			MessageBox.Show(
				"You currently have " + timer.Run.Count + " splits, but this track has " + current.normalLapCPs + " checkpoints!",
				"MX Simulator Auto Splitter",
				MessageBoxButtons.OK,
				MessageBoxIcon.Information
			);
	});

	vars.wait = (Action<int>) ((time) => {
		System.Threading.Tasks.Task.Run(async () => {
			await System.Threading.Tasks.Task.Delay(time);
		}).Wait();
	});

	vars.updateWatchers();
	vars.message();
}

update {
	if (vars.idWatcher == null || vars.checkpointWatcher == null) {
		vars.updateWatchers();
		return false;
	}

	vars.idWatcher.Update(game);
	vars.checkpointWatcher.Update(game);
	current.CPs = vars.checkpointWatcher.Current;
	current.id = vars.idWatcher.Current;

	if (current.id != current.playerID) vars.updateWatchers();

	if (settings.ResetEnabled && timer.CurrentPhase == TimerPhase.Ended && old.id == current.id && old.CPs < current.CPs) {
		vars.timerModel.Reset();
		vars.timerModel.Start();

		vars.wait(20);
	}

	if (old.firstLapCPs != old.firstLapCPs || old.normalLapCPs != current.normalLapCPs) vars.message();
}

start {
	if (old.CPs != current.CPs && current.CPs == current.firstLapCPs || current.CPs - current.firstLapCPs > 0  && (current.CPs - current.firstLapCPs) % current.normalLapCPs == 0) {
		vars.startTicks = current.raceTicks;
		return true;
	}
}

split {
	if (old.id == current.id && old.CPs != current.CPs || old.id != current.id && old.CPs == current.CPs) {
		if (old.playersInRace < current.playersInRace) return false;
		int expectedCP = old.CPs + 1, actualCP = current.CPs;

		if (timer.CurrentSplitIndex == timer.Run.Count - 1) vars.startTicks = current.raceTicks;
		return true;
	}
}

reset {
	if (old.raceTicks > current.raceTicks) {
		vars.wait(500);
		vars.updateWatchers();
		return true;
	}
}

gameTime {
	return TimeSpan.FromSeconds((current.raceTicks - vars.startTicks) * 0.0078125);
}

isLoading {
	return true;
}

exit {
	vars.timerModel.Reset();
}