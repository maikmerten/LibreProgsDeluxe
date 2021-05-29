/*  Copyright (C) 2021 Maik Merten

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

    See file, 'COPYING', for details.
*/


/*QUAKED misc_lighttrain (0 1 0) (-8 -8 -8) (8 8 8) BRIGHT

A dynamic light travelling along a path

"speed"       travel-speed (100 if not set)
"target"      targetname of first path node
"mdl"         path to model
*/
void() misc_lighttrain = {
    if(!self.speed) {
        self.speed = 100;
    }

    if(!self.mdl) {
        self.mdl = "progs/s_light.spr";
    }

    if(!self.target) {
        objerror("No target given for misc_lighttrain");
    }

	self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_PUSH;
	self.blocked = SUB_Null;
	self.use = SUB_Null;
    if(self.spawnflags & 1) {
        self.effects |= EF_BRIGHTLIGHT;
    } else {
        self.effects |= EF_DIMLIGHT;
    }

    precache_sound("misc/null.wav");
	self.noise = "misc/null.wav";
	self.noise1 = "misc/null.wav";

	precache_model(self.mdl);
	setmodel(self, self.mdl);
    setsize(self, '0 0 0', '0 0 0');

	self.nextthink = self.ltime + 0.1;
	self.think = func_train_find;
}