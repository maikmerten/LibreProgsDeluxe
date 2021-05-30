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

// ###############################################
// Animation controller
// ###############################################

void() controller_animation_think = {
    local entity o = self.owner;
    local float nextframe = o.frame;

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
