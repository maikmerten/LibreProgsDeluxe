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


void() misc_explosion_use = {

    // show explosion effect
    WriteByte(MSG_BROADCAST, SVC_TEMPENTITY);
    WriteByte(MSG_BROADCAST, TE_EXPLOSION);
    WriteCoord(MSG_BROADCAST, self.origin_x);
    WriteCoord(MSG_BROADCAST, self.origin_y);
    WriteCoord(MSG_BROADCAST, self.origin_z);

    // inflict damage
    if(self.dmg) {
        T_RadiusDamage(self, self, self.dmg, self);
    }

    // call targets
    if(self.target) {
        SUB_UseTargets();
    }

    local entity explosprite;
    explosprite = spawn();
    explosprite.owner = self;
    explosprite.origin_x = self.origin_x;
    explosprite.origin_y = self.origin_y;
    explosprite.origin_z = self.origin_z;

    // call perfectly fine explosion sprite animation function from weapons.qc
    self = explosprite;
    BecomeExplosion();
}


/*QUAKED misc_explosion (0.9 0.6 0.3) (-8 -8 -8) (8 8 8) X X X X X X X X X X

"delay"       delay for triggering targeted entities
"dmg"         radius-damage to be inflicted
"target"      targetname of other entities
"targetname"  name to target entity with

*/
void() misc_explosion = {
    self.touch = SUB_Null;
    self.use = misc_explosion_use;
}