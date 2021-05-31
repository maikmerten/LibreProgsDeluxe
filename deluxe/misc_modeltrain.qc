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


/*QUAKED misc_modeltrain (0 1 0) (-8 -8 -8) (8 8 8) LIGHT BRIGHTLIGHT
{
    model({"path": mdl, "skin": 0, "frame": first_frame});
}

A dynamic light travelling along a path

"speed"        travel-speed (100 if not set)
"target"       targetname of first path node
"mdl"          path to model
"first_frame"  for animation: first frame
"last_frame"   for animation: last frame

*/
void() misc_modeltrain = {
    local entity anim_controller;
    
    if(!self.speed) {
        self.speed = 100;
    }

    if(!self.mdl) {
        self.mdl = "progs/s_light.spr";
    }

    if(!self.target) {
        objerror("No target given for misc_modeltrain");
    }

    self.solid = SOLID_NOT;
    self.movetype = MOVETYPE_PUSH;
    self.blocked = SUB_Null;
    self.use = SUB_Null;
    if(self.spawnflags & 2) {
        self.effects |= EF_BRIGHTLIGHT;
    } else if(self.spawnflags & 1) {
        self.effects |= EF_DIMLIGHT;
    }

    precache_model(self.mdl);
    setmodel(self, self.mdl);
    setsize(self, '0 0 0', '0 0 0');

    if(self.last_frame) {
        // if there is an animation frame range, start animation
        anim_controller = spawn();
        self.owned_ent = anim_controller;
        controller_animation_setup(anim_controller, self, 10);
    }

    modeltrain_setup();
};