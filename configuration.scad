belt_type = "GT2"; // T2.5, T5, HTD3, MXL, GT2

belt_tooth_distance = 
	(belt_type=="T2.5") ? 2.5 :
	(belt_type=="T5") ? 5 : 
	(belt_type=="HTD3") ? 3 : 
	(belt_type=="MXL") ? 2.032 : 
	(belt_type=="GT2") ? 2 : 
	0;

belt_tooth_ratio = 
	(belt_type=="T2.5") ? 0.5 :
	(belt_type=="T5") ? 0.75 : 
	(belt_type=="HTD3") ? 0.75 : 
	(belt_type=="MXL") ? 0.64 : 
	(belt_type=="GT2") ? 0.5 : 
	0;

belt_tooth_width = 
	(belt_type=="HTD3") ? 1.3 :
	(belt_type=="GT2") ? 0.5 :
	1;

