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
  baseDamage int,
  tier char(1) not null,
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
  price int,
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

drop database gungeonDB;