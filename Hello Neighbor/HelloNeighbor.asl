state("HelloNeighbor-Win64-Shipping") {
	int loading: 0x29C2C44;
	int control: 0x2C4C258, 0xC8, 0x258, 0xAE0, 0x1B8;
}

start {
	return old.control == 0 && current.control == 1;
}

isLoading {
	return current.loading == 0;
}
