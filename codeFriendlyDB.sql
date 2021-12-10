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
  runNo int not null auto_increment,
  runCharacter varchar(50) not null,
  primary key (runNo),
  foreign key (runCharacter) references Characters(charName)
);

create table Weapons(
  weaponName varchar(50) not null,
  baseDamage float,
  tier char(1),
  weapDescription varchar(1000),
  sellPrice float,
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

/* Chamber Info */
insert into Chambers (chamberNo)
values (1);
insert into Chambers (chamberNo)
values (1.5);
insert into Chambers (chamberNo)
values (2);
insert into Chambers (chamberNo)
values (2.5);
insert into Chambers (chamberNo)
values (3);
insert into Chambers (chamberNo)
values (4);
insert into Chambers (chamberNo)
values (5);

/* NPC Info */

/* Weapons Info */
insert into Weapons (weaponName, baseDamage, weapDescription, sellPrice)
values ("Rusty Sidearm", 16.4, "The Hunter's starting gun.", 0);
insert into Weapons (weaponName, baseDamage, weapDescription, sellPrice)
values ("Marine Sidearm", 14.5, "The Marine's starting gun.", 0);
insert into Weapons (weaponName, baseDamage, weapDescription, sellPrice)
values ("Rogue Special", 13.6, "The Pilot's starting gun.", 0);
insert into Weapons (weaponName, baseDamage, tier, weapDescription, sellPrice)
values ("Blasphemy", 28, "B", "The Bullet's starting gun. Fires a beam at full HP, which does extra damage. Can be swung to destroy bullets.", 30);
insert into Weapons (weaponName, baseDamage, tier, weapDescription, sellPrice)
values ("Casey", 50, "D", "Melee weapon that can damage nearby enemies and reflect bullets after charged. Increases curse by +2.", 16);
insert into Weapons (weaponName, baseDamage, tier, weapDescription, sellPrice)
values ("Shotgun Full of Hate", 54.5, "A", "Shotgun that fires a spread of 6 bullets (2 poison, 2 regular, a piercing nail, and a bouncing skull).", 41);
insert into Weapons (weaponName, baseDamage, tier, weapDescription, sellPrice)
values ("A.W.P", 30.5, "A", "Fires a piercing bullet with extremely fast bullet speed.", 41);
insert into Weapons (weaponName, baseDamage, tier, weapDescription, sellPrice)
values ("Shotgun Full of Love", 51.1, "A", "Fires a spread of 6 projectiles (two pink bullets, and exploding star, a candy, and two teddy bears). Projectiles have a chance to charm enemies.", 41);

/* Sort weapon info by tier */
/* alter table Weapons order by tier desc; */

/* Weapon Weapon Synergy Info */
insert into W_W_Synergy (weaponOne, weaponTwo, synergyEffect)
values ("Casey", "Shotgun Full of Hate", "Casey becomes spiked and fires a spread of 6 nails each time it is swung. When an enemy gets hit, they become red and take damage over time.");
insert into W_W_Synergy (weaponOne, weaponTwo, synergyEffect)
values ("Shotgun Full of Hate", "Shotgun Full of Love", "Shotgun Full of Hate and Shotgun Full of Love are dual-wielded.");

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


/* Relationship Insertion to Simulate In-Game Additions */

/* Create run number */
-- insert into Run (runCharacter)
-- values ("The Marine");
-- insert into Run (runCharacter)
-- values ("The Bullet");

/* Adding guns */
-- insert into CurrentlyHasWeapon (weaponName, runNo)
-- values ("Marine Sidearm", 1);
-- insert into CurrentlyHasWeapon (weaponName, runNo)
-- values ("Casey", 1);
-- insert into CurrentlyHasWeapon (weaponName, runNo)
-- values ("Shotgun Full of Hate", 1);
-- insert into CurrentlyHasWeapon (weaponName, runNo)
-- values ("A.W.P", 1);
-- insert into CurrentlyHasWeapon (weaponName, runNo)
-- values ("Shotgun Full of Love", 1);
-- insert into CurrentlyHasWeapon(weaponName, runNo)
-- values ("Blasphemy", 2);

/* Adding items */
-- insert into CurrentlyHasItem (itemName, runNo)
-- values ("Explosive Decoy", 1);
-- insert into CurrentlyHasItem (itemName, runNo)
-- values ("Monster Blood", 1);
-- insert into CurrentlyHasItem (itemName, runNo)
-- values ("Scope", 1);
-- insert into CurrentlyHasItem(itemName, runNo)
-- values ("Master Round I", 2);
-- insert into CurrentlyHasItem(itemName, runNo)
-- values ("Monster Blood", 2);


/* Select statements to see contents of tables */

/* Output all synergies of a run */
-- select r.runNo as RunNumber, ww.synergyEffect as CurrentWeaponSynergies
-- from Run as r, W_W_Synergy as ww
-- where exists (select *
-- 			     from CurrentlyHasWeapon as chw
--               where chw.weaponName = ww.weaponOne)
-- and exists (select *
--             from CurrentlyHasWeapon as chw
-- 		       where chw.weaponName = ww.weaponTwo);
            
-- select r.runNo as RunNumber, wi.synergyEffect as CurrentWeaponItemSynergies
-- from Run as r, W_I_Synergy as wi
-- where exists (select *
-- 			  from CurrentlyHasWeapon as chw
--               where chw.weaponName = wi.weaponName)
-- and exists (select *
--             from CurrentlyHasItem as chi
-- 		    where chi.itemName = wi.itemName);
            
-- select r.runNo as RunNumber, ii.synergyEffect as CurrentItemSynergies
-- from Run as r, I_I_Synergy as ii
-- where exists (select *
-- 			  from CurrentlyHasItem as chi
--               where chi.itemName = ii.itemOne)
-- and exists (select *
--             from CurrentlyHasItem as chi
-- 		    where chi.itemName = ii.itemTwo);

/* Output net worth of a run */
-- select SUM(w.sellPrice) as TotalWeaponValue
-- from Weapons as w, CurrentlyHasWeapon as chw
-- where w.weaponName = chw.weaponName and chw.runNo = 1;


-- select SUM(i.sellPrice) as TotalItemValue
-- from Items as i, CurrentlyHasItem as chi
-- where i.itemName = chi.itemName and chi.runNo = 1;


/* Output number of enemies fought in run */




/* Character Info */
-- select all charName
-- from Characters;

/* Weapon Info */
-- select all weaponName, baseDamage, tier, weapDescription, sellPrice
-- from Weapons;

/* Weapon Weapon Synergy Info */
-- select all weaponOne, weaponTwo, synergyEffect
-- from W_W_Synergy;

/* Item Info */
-- select all itemName, effect, tier, sellPrice, itemType
-- from Items;

/* Item Item Synergy Info */
-- select all itemOne, itemTwo, synergyEffect
-- from I_I_Synergy;

/* Weapon Item Synergy Info */
-- select all weaponName, itemName, synergyEffect
-- from W_I_Synergy;




/* Specialized Select Statements */

-- drop database gungeonDB;
