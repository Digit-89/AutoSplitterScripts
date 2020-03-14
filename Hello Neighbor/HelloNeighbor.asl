state("HelloNeighbor-Win64-Shipping") {
	int loading: "HelloNeighbor-Win64-Shipping.exe", 0x29C2C44;
	int control: "HelloNeighbor-Win64-Shipping.exe", 0x2C4C258, 0xC8, 0x258, 0xAE0, 0x1B8;
}

init {
	vars.currLoading = 0;
}

update {
	if (old.loadingOn != current.loadingOn) {
		print (">>>>> loadOn changed from " + old.loadingOn + " to " + current.loadingOn);
	}
	if (old.loadingOff != current.loadingOff) {
		print (">>>>> loadOff changed from " + old.loadingOff + " to " + current.loadingOff);
	}
}

start {
	return old.control == 0 && current.control == 1;
}

isLoading {
	return current.loading == 0;
}
