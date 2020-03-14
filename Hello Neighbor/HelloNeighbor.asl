state("HelloNeighbor-Win64-Shipping") {
	int loadingOff: "HelloNeighbor-Win64-Shipping.exe", 0x2C1B644;
	int loadingOn : "HelloNeighbor-Win64-Shipping.exe", 0x29C2C44;
	int control   : "HelloNeighbor-Win64-Shipping.exe", 0x2C4C258, 0xC8, 0x258, 0xAE0, 0x1B8;
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
	if (old.loadingOn == 1 && current.loadingOn == 0 && vars.currLoading != 1) {
		print (">>>>>>> loading is now ON");
		vars.currLoading = 1;
	}
	if (old.loadingOff == 0 && current.loadingOff != 0 && vars.currLoading != 0) {
		print (">>>>>>> loading is now OFF");
		vars.currLoading = 0;
	}
	return vars.currLoading == 1;
}