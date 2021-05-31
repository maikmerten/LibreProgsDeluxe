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

// shared entity attributes

.float first_frame;
.float last_frame;

.entity owned_ent;

// ###############################################
// Animation controller
// ###############################################

void() controller_animation_think = {
    local entity o;
    local float nextframe;

    if(self.health < 0) {
        SUB_Remove();
        return;
    }

    o = self.owner;
    nextframe = o.frame;


    if(self.speed > 0) {
        nextframe++;
    } else {
        nextframe--;
    }

    if(nextframe > o.last_frame) {
        nextframe = o.first_frame;
    } else if(nextframe < o.first_frame) {
        nextframe = o.last_frame;
    }

    o.frame = nextframe;
    self.nextthink = time + fabs(self.speed);
};


void(entity controller, entity ctrl_owner, float fps) controller_animation_setup = {
    controller.owner = ctrl_owner;
    // compute time between thinks: (1 / framerate)
    controller.speed = (1 / fps);

    controller.think = controller_animation_think;
    controller.nextthink = time + (controller.speed);
};


// ###############################################
// model trains (trains with angles adjusted to target)
// ###############################################

void() modeltrain_setup;

void() modeltrain_next = {
    local entity targ;
    targ = self.goalentity;

    // we arrived at current target. If the target
    // specifies a new speed, take it!
    if(targ.speed) {
        self.speed = fabs(targ.speed);
    }
    
    if(!targ.target) {
        // if there's no next target, remove train
        if(self.owned_ent) {
            // ensure owned controllers get destroyed, too
            remove(self.owned_ent);
        }
        remove(self);
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


void() modeltrain_setup = {
    local entity targ;

    targ = find(world, targetname, self.target);
    self.goalentity = targ;

    // orient towards first target
    self.angles = vectoangles(targ.origin - self.origin);

    setorigin(self, targ.origin);

    self.think = modeltrain_next;
    self.think();
};