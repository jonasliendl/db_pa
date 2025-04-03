create table MafiaFamilien (
    Bezeichnung varchar(255),
    Stammort varchar(255),
    GeschJaehrlicherUmsatz real,
    primary key (Bezeichnung)
);

create table Mafiosis (
    Spitzname varchar(255),
    "Alter" integer,
    Beschreibung varchar(255),
    Aufenthaltsort varchar(255),
    FamilienBezeichnung varchar(255),
    primary key (Spitzname)
);

create table StraftatKategorie (
    Bezeichnung varchar(255),
    Beschreibung varchar(255),
    primary key (Bezeichnung)
);

create table Straftaten (
    Vorgangsnummer integer,
    Ort varchar(255),
    Beschreibung varchar(255),
    KategorieBezeichnung varchar(255),
    primary key (Vorgangsnummer)
);

create table rekrutiert (
    SpitznameAgent varchar(255),
    SpitznameKomplize varchar(255),
    Datum date,
    constraint rekrutiert_pk primary key (SpitznameAgent, SpitznameKomplize) 
);

create table begeht (
    Spitzname varchar(255),
    Vorgangsnummer integer,
    constraint begeht_pk primary key (Spitzname, Vorgangsnummer)
);