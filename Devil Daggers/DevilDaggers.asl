state("dd") {
	float igt : 0x1F30C0, 0x1A0;
}

startup {
	vars.splitIndex = 0;
	vars.splitTime = new List<float> {
		3, 14, 19, 24, 39, 49, 64, 79, 94, 109, 117, 119, 134,
		144, 154, 164, 174, 177, 184, 189, 194, 199, 229, 239,
		244, 262, 274, 289, 304, 330, 350, 365, 370, 375, 397,
		400, 406, 415, 417, 418, 418, 419, 424, 427, 430, 440,
		441, 445, 450, 452, 454, 456, 459, 462, 470, 472, 473,
		474, 484, 485, 486, 491, 492, 497, 502, 507
	};
}

start {
	if (current.igt > old.igt && current.igt < 0.1) {
		vars.splitIndex = 0;
		return true;
	}
}

split {
	try {
		if (current.igt >= vars.splitTime[vars.splitIndex]) {
			vars.splitIndex++;
			return true;
		}
	} catch {}
}

reset {
	return old.igt > current.igt;
}