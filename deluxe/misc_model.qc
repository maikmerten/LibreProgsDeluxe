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


.float first_frame;
.float last_frame;


void() misc_model_think = {
    float nextframe = self.frame;

    if(self.speed > 0) {
        nextframe++;
    } else {
        nextframe--;
    }

    if(nextframe > self.last_frame) {
        nextframe = self.first_frame;
    } else if(nextframe < self.first_frame) {
        nextframe = self.last_frame;
    }

    self.frame = nextframe;
    self.nextthink = time + fabs(self.speed);
}

/*QUAKED misc_model (0 0.5 1) (-8 -8 -8) (8 8 8)
{
    model({"path": mdl, "skin": skin, "frame": frame});
}

"mdl"          model file to be displayed
"frame"        model frame to be display
"first_frame"  for animation: first frame
"last_frame"   for animation: last frame
"speed"        for animation: animation speed (frames per second)
"skin"         model skin to be used

*/
void() misc_model = {

    precache_model(self.mdl);
    setmodel(self, self.mdl);


    if(!self.frame) {
        self.frame = self.first_frame;
    }
    
    // no frame range? Don't animate!
    if(!self.last_frame) {
        makestatic(self);
        return;
    }

    if(!self.speed) {
        // default to 10 frames per second (100 ms between thinks)
        self.speed = 10;
    }

    // compute time between thinks: (1 / framerate)
    self.speed = 1 / self.speed;


    self.think = misc_model_think;
    self.nextthink = time;
}