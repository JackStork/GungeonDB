/*
CS 2300 Project Phase 3
Mason Coleman, Jacob Massengill, Jack Stork
12/2/2021
*/

create database gungeonDB;
use gungeonDB;

/* Create tables */

create table Characters(
  name varchar(50) not null,
  primary key (name)
);

create table CharacterSkin(
  skinName varchar(50) not null,
  unlockMethod varchar(1000),
  skinCharacter varchar(50) not null,
  primary key (skinName),
  foreign key (skinCharacter) references Characters(name)
);


create table Run(
  runNo int not null,
  runCharacter varchar(50) not null,
  primary key (runNo),
  foreign key (runCharacter) references Characters(name)
);

create table Weapons(
  weaponName varchar(50) not null,
  baseDamage int,
  tier char(1) not null,
  weapDescription varchar(1000),
  primary key (weaponName)
);

create table W_W_Synergy(
  weaponOne varChar(50) not null,
  weaponTwo varChar(50) not null,
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