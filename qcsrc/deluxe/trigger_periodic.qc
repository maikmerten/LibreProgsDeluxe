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

void() trigger_periodic_think = {
    SUB_UseTargets();

    self.nextthink = time + self.wait;
}


/*QUAKED trigger_periodic (0.5 0.5 0.5) (-8 -8 -8) (8 8 8)

"target"      targetname of entities to be triggered
"wait"        time between trigger activation (default is 1 for 1 Hz trigger)
*/

void() trigger_periodic = {
    if(!self.wait) {
        self.wait = 1;
    }

    self.think = trigger_periodic_think;
    self.think();
};