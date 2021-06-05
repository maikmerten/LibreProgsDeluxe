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


// ###############################################
// model trains (trains with angles adjusted to target)
// ###############################################

void() modeltrain_next = {
    local entity targ;
    targ = self.goalentity;

    // we arrived at current target. If the target
    // specifies a new speed, take it!
    if(targ.speed) {
        self.speed = fabs(targ.speed);
    }

    if(targ.spawnflags & 1) {
        // KILLTRAIN spawnflag set
        if(self.owned_ent) {
            // ensure owned controllers get destroyed, too
            remove(self.owned_ent);
        }
        remove(self);
        return;
    }

    if(targ.spawnflags & 2) {
        // STOPANIM spawnflag set
        if(self.owned_ent) {
            self.owned_ent.think = SUB_Null;
        }
    }

    if(targ.spawnflags & 4) {
        // SETFRAME spawnflag set
        self.frame = targ.frame;
    }
    
    if(!targ.target) {
        // if there's no next target, stop train
        return;
    }

    // find next target
    targ = find(world, targetname, targ.target);
    if(!targ) {
        objerror("modeltrain_next: could not find next target");
    }
    self.goalentity = targ;

    // orient towards new target
    self.angles = vectoangles(targ.origin - self.origin);

    // move towards new target
    SUB_CalcMove(targ.origin, self.speed, modeltrain_next);
};


void() misc_modeltrain_dolaunch = {
    local entity targ;
    local entity anim_controller;
    
    if(!self.speed) {
        self.speed = 100;
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

    setmodel(self, self.mdl);
    setsize(self, '0 0 0', '0 0 0');

    if(self.last_frame) {
        // if there is an animation frame range, start animation
        anim_controller = spawn();
        self.owned_ent = anim_controller;
        controller_animation_setup(anim_controller, self, 10);
    }

    // find first path node
    targ = find(world, targetname, self.target);
    self.goalentity = targ;

    // orient towards first target
    self.angles = vectoangles(targ.origin - self.origin);

    setorigin(self, targ.origin);

    self.think = modeltrain_next;
    self.think();
};

/*QUAKED path_corner_modeltrain (0.7 0.3 0) (-8 -8 -8) (8 8 8) KILLTRAIN STOPANIM SETFRAME

A model travelling along a path. Start travel directly after spawning.

"speed"        new speed for modeltrain arriving at this path node
"target"       targetname of next path node
"frame"        set model frame to this frame number (needs SETFRAME spawnflag, combine with STOPANIM)

*/

void() path_corner_modeltrain = {
    self.classname = "path_corner_modeltrain";
};


/*QUAKED misc_modeltrain (0 1 0) (-8 -8 -8) (8 8 8) LIGHT BRIGHTLIGHT
{
    model({"path": mdl, "skin": 0, "frame": first_frame});
}

A model travelling along a path. Start travel directly after spawning.

"speed"        travel-speed (100 if not set)
"target"       targetname of first path node
"mdl"          path to model
"first_frame"  for animation: first frame
"last_frame"   for animation: last frame

*/
void() misc_modeltrain = {
    if(!self.mdl) {
        self.mdl = "progs/s_light.spr";
    }
    precache_model(self.mdl);
    misc_modeltrain_dolaunch();
};


/*QUAKED misc_modeltrain_launcher (0 1 0) (-8 -8 -8) (8 8 8) LIGHT BRIGHTLIGHT
{
    model({"path": mdl, "skin": 0, "frame": first_frame});
}

Creates a new model travelling along a path

"speed"        travel-speed (100 if not set)
"target"       targetname of first path node
"targetname"   name to be targeted with
"mdl"          path to model
"first_frame"  for animation: first frame
"last_frame"   for animation: last frame

*/

void() misc_modeltrain_launcher_use;
void() misc_modeltrain_launcher = {
    if(!self.mdl) {
        self.mdl = "progs/s_light.spr";
    }
    precache_model(self.mdl);
    self.use = misc_modeltrain_launcher_use;
};

void() misc_modeltrain_launcher_use = {
    local entity newent;
    local entity oldself;
    oldself = self;

    newent = spawn();
    newent.origin = self.origin;
    newent.spawnflags = self.spawnflags;
    newent.speed = self.speed;
    newent.target = self.target;
    newent.mdl = self.mdl;
    newent.first_frame = self.first_frame;
    newent.last_frame = self.last_frame;

    self = newent;
    misc_modeltrain_dolaunch();
    self = oldself;
}
