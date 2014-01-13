//call like getNetName(IT_ARMOR3); and it returns "Red ARmor"
//or getNetName(self.items) or getNetname(self.weapon)
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
		{	if (world.worldtype == 0)
				return "Silver key";
			if (world.worldtype == 1)
				return "Silver runkey";
			if (world.worldtype == 2)
				return "Silver keycard";
		}
		case 262144:
		{	if (world.worldtype == 0)
				return "Gold key";
			if (world.worldtype == 1)
				return "Gold runkey";
			if (world.worldtype == 2)
				return "Gold keycard";
		}
		case 524288:
			return "Ring of Shadows";
		case 1048576:
			return "Pentagram of Protection";
		case 2097152:
			return "Biohazard Suit";
		case 4194304:
			return "Quad Damage";

		default:
			return string_null;
	}
};

string getMapname(string m) =
{
	switch(m) 
	{
		case "start":
			return "Introduction...";
		case "e1m1":
			return "The Slipgate Complex";
		case "e1m2":
			return "Castle of the Damned";
		case "e1m3":
			return "The Necropolis";
		case "e1m4":
			return "The Gristly Grotto";
		case "e1m5":
			return "Gloom Keep";
		case "e1m6":
			return "The Door to Cthon";
		case "e1m7":
			return "The House of Cthon";
		case "e1m8":
			return "Ziggurat Vertigo";

		case "e2m1":
			return "The Installation";
		case "e2m2":
			return "The Ogre Citadel";
		case "e2m3":
			return "The Crypt of Decay";
		case "e2m4":
			return "The Ebon Fortress";
		case "e2m5":
			return "The Wizard's Manse";
		case "e2m6":
			return "The Dismal Oubliette";
		case "e2m7":
			return "The Underearth";

		case "e3m1":
			return "Termination Central";
		case "e3m2":
			return "The Vaults of Zin";
		case "e3m3":
			return "The Tomb of Terror";
		case "e3m4":
			return "Satan's Dark Delight";
		case "e3m5":
			return "The Wind Tunnels";
		case "e3m6":
			return "Chambers of Torment";
		case "e3m7":
			return "The Haunted Halls";

		case "e4m1":
			return "The Sewage System";
		case "e4m2":
			return "The Tower of Despair";
		case "e4m3":
			return "The Elder God Shrine";
		case "e4m4":
			return "The Palace of Hate";
		case "e4m5"":
			return "Hell's Atrium";
		case "e4m6"":
			return "The Pain Maze";
		case "e4m7"":
			return "Azure Agony";
		case "e4m8":
			return "The Nameless City";
		case "end"":
			return "Shub-Niggurath's Pit";

		default:
			return string_null;
	}
};
