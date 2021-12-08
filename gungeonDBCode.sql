/*
CS 2300 Project Phase 3
Mason Coleman, Jacob Massengill, Jack Stork
12/2/2021
*/

create database gungeonDB;
use gungeonDB;

/* Create tables */

create table Characters(
  charName varchar(50) not null,
  primary key (charName)
);

create table CharacterSkin(
  skinName varchar(50) not null,
  unlockMethod varchar(1000),
  skinCharacter varchar(50) not null,
  primary key (skinName),
  foreign key (skinCharacter) references Characters(charName)
);


create table Run(
  runNo int not null,
  runCharacter varchar(50) not null,
  primary key (runNo),
  foreign key (runCharacter) references Characters(charName)
);

create table Weapons(
  weaponName varchar(50) not null,
  baseDamage float,
  tier char(1),
  weapDescription varchar(1000),
  primary key (weaponName)
);

create table W_W_Synergy(
  weaponOne varchar(50) not null,
  weaponTwo varchar(50) not null,
  synergyEffect varchar(1000),
  primary key (weaponOne, weaponTwo),
  foreign key (weaponOne) references Weapons(weaponName),
  foreign key (weaponTwo) references Weapons(weaponName)
);

create table CurrentlyHasWeapon(
  weaponName varchar(50) not null,
  runNo int not null,
  primary key (weaponName, runNo),
  foreign key (weaponName) references Weapons(weaponName),
  foreign key (runNo) references Run(runNo)
);

create table Items(
  itemName varchar(50) not null,
  effect varchar(1000),
  tier char(1),
  sellPrice float,
  itemType varchar(50),
  primary key (itemName)
);

create table I_I_Synergy(
  itemOne varchar(50) not null,
  itemTwo varchar(50) not null,
  synergyEffect varchar (1000),
  primary key (itemOne, itemTwo),
  foreign key (itemOne) references Items(itemName),
  foreign key (itemTwo) references Items(itemName)
);

create table CurrentlyHasItem(
  itemName varchar(50) not null,
  runNo int not null,
  primary key (itemName, runNo),
  foreign key (itemName) references Items(itemName),
  foreign key (runNo) references Run(runNo)
);

create table W_I_Synergy(
  weaponName varchar(50) not null,
  itemName varchar(50) not null,
  synergyEffect varchar(1000),
  primary key (weaponName, itemName),
  foreign key (weaponName) references Weapons(weaponName),
  foreign key (itemName) references Items(itemName)
);

create table Enemies(
  enemyName varchar(50) not null,
  jammed bool,
  hp int,
  attacks varchar(1000),
  primary key (enemyName)
);

create table Enemies_Fought(
  enemyName varchar(50) not null,
  runNo int not null,
  primary key (enemyName, runNo),
  foreign key (enemyName) references Enemies(enemyName),
  foreign key (runNo) references Run(runNo)
);

create table NPCs(
  npcName varchar(50) not null,
  service varchar(1000),
  primary key (npcName)
);

create table NPC_Interaction(
  npcName varchar(50) not null,
  runNo int not null,
  primary key (npcName, runNo),
  foreign key (npcName) references NPCs(npcName),
  foreign key (runNo) references Run(runNo)
);

create table Chambers(
  chamberNo float not null,
  primary key (chamberNo)
);

create table Enemy_Appears_On(
  enemyName varchar(50) not null,
  chamberNo float not null,
  primary key (enemyName, chamberNo),
  foreign key (enemyName) references Enemies(enemyName),
  foreign key (chamberNo) references Chambers(chamberNo)
);

create table NPC_Appears_On(
  npcName varchar(50) not null,
  chamberNo float not null,
  primary key (npcName, chamberNo),
  foreign key (npcName) references NPCs(npcName),
  foreign key (chamberNo) references Chambers(chamberNo)
);

/* Adding game information to tables */

/* Character Info */
insert into Characters (charName)
values ("The Convict");
insert into Characters (charName)
values ("The Hunter");
insert into Characters (charName)
values ("The Marine");
insert into Characters (charName)
values ("The Pilot");
insert into Characters (charName)
values ("The Cultist");
insert into Characters (charName)
values ("The Bullet");
insert into Characters (charName)
values ("The Robot");
insert into Characters (charName)
values ("The Paradox");
insert into Characters (charName)
values ("The Gunslinger");

/* Character Skin Info */


/* Weapons Info */
insert into Weapons (weaponName, baseDamage, weapDescription)
values ("Rusty Sidearm", 16.4, "The Hunter's starting gun.");
insert into Weapons (weaponName, baseDamage, weapDescription)
values ("Marine Sidearm", 14.5, "The Marine's starting gun.");
insert into Weapons (weaponName, baseDamage, weapDescription)
values ("Rogue Special", 13.6, "The Pilot's starting gun.");
insert into Weapons (weaponName, baseDamage, tier, weapDescription)
values ("Blasphemy", 28, "B", "The Bullet's starting gun. Fires a beam at full HP, which does extra damage. Can be swung to destroy bullets.");
insert into Weapons (weaponName, baseDamage, tier, weapDescription)
values ("Casey", 50, "D", "Melee weapon that can damage nearby enemies and reflect bullets after charged. Increases curse by +2.");
insert into Weapons (weaponName, baseDamage, tier, weapDescription)
values ("Shotgun Full of Hate", 54.5, "A", "Shotgun that fires a spread of 6 bullets (2 poison, 2 regular, a piercing nail, and a bouncing skull).");
insert into Weapons (weaponName, baseDamage, tier, weapDescription)
values ("A.W.P", 30.5, "A", "Fires a piercing bullet with extremely fast bullet speed.");
/* Sort weapon info by tier */
/* alter table Weapons order by tier desc; */

/* Weapon Weapon Synergy Info */
insert into W_W_Synergy (weaponOne, weaponTwo, synergyEffect)
values ("Casey", "Shotgun Full of Hate", "Casey becomes spiked and fires a spread of 6 nails each to it is swung. When an enemy gets hit, they become red and take damage over time.");

/* Items Info */
insert into Items (itemName, effect, itemType)
values ("Master Round I", "Grants an extra heart container.", "Passive");
insert into Items (itemName, effect, tier, sellPrice, itemType)
values ("Scope", "Reduces shot spread by 60%.", "D", 16, "Passive");
insert into Items (itemName, effect, tier, sellPrice, itemType)
values ("Explosive Decoy", "Places a decoy that enemies will target. Can be used to steal from shops.", "C", 21, "Active");
insert into Items (itemName, effect, tier, sellPrice, itemType)
values ("Monster Blood", "Taking damage spawns a pool of poison. Grants a heart container and immunity to poison.", "C", 21, "Passive");

/* Item Item Synergy Info */
insert into I_I_Synergy (itemOne, itemTwo, synergyEffect)
values ("Explosive Decoy", "Monster Blood", "Explosive decoy explodes and creates a pool of poison when attacked.");

/* Weapon Item Synergy Info */
insert into W_I_Synergy (weaponName, itemName, synergyEffect)
values ("A.W.P", "Scope", "Spinning 360 degrees before firing the A.W.P grants a 3-second damage buff that gives the next shot +50% damage. Can stack.");

/* Select statements to see contents of tables */

/* Character Info */
select all charName
from Characters;

/* Weapon Info */
select all weaponName, baseDamage, tier, weapDescription
from Weapons;

/* Weapon Weapon Synergy Info */
select all weaponOne, weaponTwo, synergyEffect
from W_W_Synergy;

/* Item Info */
select all itemName, effect, tier, sellPrice, itemType
from Items;

/* Item Item Synergy Info */
select all itemOne, itemTwo, synergyEffect
from I_I_Synergy;

/* Weapon Item Synergy Info */
select all weaponName, itemName, synergyEffect
from W_I_Synergy;

drop database gungeonDB;