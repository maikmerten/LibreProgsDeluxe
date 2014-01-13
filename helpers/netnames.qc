//call like getNetName(IT_ARMOR3); and it returns "Red ARmor"
//called from dropBackpack() and startItem(). fills in any netnames that are missing. and overrides the others.
string getNetname(float item_number) =
{//gnounc
	switch(item_number) 
	{
		case 4096:
			return "Axe";
		case 1:
			return "Shotgun";
		case 2:
			return "Super Shotgun";
		case 4:
			return "Nailgun";
		case 8:
			return "Perforator";
		case 16:
			return "Grenade Launcher";
		case 32:
			return "Rocket Launcher";
		case 64:
			return "Lightning Gun";
		case 128:
			return "Extra Weapon";
		case 256:
			return "Shells";
		case 512:
			return "Nails";
		case 1024:
			return "Rockets";
		case 2048:
			return "Cells";
		case 8192:
			return "Green Armor";
		case 16384:
			return "Yellow Armor";
		case 32768:
			return "Red Armor";
		case 65536:
			return "Mega Health";
		case 131072:
			return "Silver Key";
		case 262144:
			return "Gold Key";
		case 524288:
			return "Ring of Shadows";
		case 1048576:
			return "Pentagram of Protection";
		case 2097152:
			return "Biohazard Suit";
		case 4194304:
			return "Quad Damage";
		default:
			return "unlisted number";
	}
};
