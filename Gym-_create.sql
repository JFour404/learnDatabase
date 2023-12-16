-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-12-16 19:12:18.47

-- Oracle sql developer version 22.2.1

-- tables
-- Table: Abonementas
CREATE TABLE Abonementas (
    abonementasID uniqueidentifier  NOT NULL,
    abonementoPlanasID uniqueidentifier  NOT NULL,
    galiojimoPradzia date  NOT NULL,
    galiojimoPabaiga date  NOT NULL,
    CONSTRAINT Abonementas_pk PRIMARY KEY  (abonementasID)
);

-- Table: AbonementoPlanas
CREATE TABLE AbonementoPlanas (
    abonementoPlanasID uniqueidentifier  NOT NULL,
    kaina numeric(3,2)  NOT NULL,
    arTerminuota bit  NOT NULL,
    privalumai nvarchar(max)  NOT NULL,
    CONSTRAINT AbonementoPlanas_pk PRIMARY KEY  (abonementoPlanasID)
);

-- Table: IndividualiTreniruote
CREATE TABLE IndividualiTreniruote (
    klientoID uniqueidentifier  NOT NULL,
    trenerioID uniqueidentifier  NOT NULL,
    treniruotesPlanoID uniqueidentifier  NOT NULL
);

-- Table: Inventorius
CREATE TABLE Inventorius (
    irangaID uniqueidentifier  NOT NULL,
    sportoZonaID uniqueidentifier  NOT NULL
);

-- Table: Iranga
CREATE TABLE Iranga (
    irangaID uniqueidentifier  NOT NULL,
    tipas varchar(30)  NOT NULL,
    gamintojas varchar(30)  NOT NULL,
    verte int  NOT NULL,
    aprasas nvarchar(max)  NOT NULL,
    CONSTRAINT Iranga_pk PRIMARY KEY  (irangaID)
);

-- Table: Klientas
CREATE TABLE Klientas (
    klientoID uniqueidentifier  NOT NULL,
    naudotojoID uniqueidentifier  NOT NULL,
    sportoPlanasID uniqueidentifier  NOT NULL,
    mitybosPlanasID uniqueidentifier  NOT NULL,
    abonementasID uniqueidentifier  NOT NULL,
    CONSTRAINT Klientas_pk PRIMARY KEY  (klientoID)
);

-- Table: MitybosPlanas
CREATE TABLE MitybosPlanas (
    mitybosPlanasID uniqueidentifier  NOT NULL,
    sudaresTrenerisID uniqueidentifier  NOT NULL,
    laikotarpis date  NOT NULL,
    kalorijosPerDiena int  NOT NULL,
    dienosAngliavandeniai int  NOT NULL,
    dienosRiebalai int  NOT NULL,
    dienosBaltymai int  NOT NULL,
    dienosVandensKiekis float(2)  NOT NULL,
    instrukcija nvarchar(max)  NOT NULL,
    CONSTRAINT MitybosPlanas_pk PRIMARY KEY  (mitybosPlanasID)
);

-- Table: Naudotojas
CREATE TABLE Naudotojas (
    naudotojoID uniqueidentifier  NOT NULL,
    slaptazodis varchar(30)  NOT NULL,
    role varchar(30)  NOT NULL,
    vardas varchar(30)  NOT NULL,
    pavarde varchar(30)  NOT NULL,
    asmensKodas int  NOT NULL,
    CONSTRAINT Naudotojas_pk PRIMARY KEY  (naudotojoID)
);

-- Table: Pratimas
CREATE TABLE Pratimas (
    pratimasID uniqueidentifier  NOT NULL,
    pavadinimas varchar(30)  NOT NULL,
    instrukcija nvarchar(max)  NOT NULL,
    CONSTRAINT Pratimas_pk PRIMARY KEY  (pratimasID)
);

-- Table: PratimoSpecifikacija
CREATE TABLE PratimoSpecifikacija (
    pratimoSpecifikacijaID uniqueidentifier  NOT NULL,
    pakartojimai int  NOT NULL,
    serijos int  NOT NULL,
    poilsisTarpSeriju date  NOT NULL,
    CONSTRAINT PratimoSpecifikacija_pk PRIMARY KEY  (pratimoSpecifikacijaID)
);

-- Table: PratimuSarasas
CREATE TABLE PratimuSarasas (
    treniruotesPlanoID uniqueidentifier  NOT NULL,
    pratimasID uniqueidentifier  NOT NULL
);

-- Table: SpecifikacijuSarasas
CREATE TABLE SpecifikacijuSarasas (
    pratimasID uniqueidentifier  NOT NULL,
    pratimoSpecifikacijaID uniqueidentifier  NOT NULL
);

-- Table: SportoKlubas
CREATE TABLE SportoKlubas (
    sportoKlubasID uniqueidentifier  NOT NULL,
    pavadinimas varchar(30)  NOT NULL,
    adresas varchar(30)  NOT NULL,
    plotas decimal(4,2)  NOT NULL,
    kontaktai nvarchar(max)  NOT NULL,
    CONSTRAINT SportoKlubas_pk PRIMARY KEY  (sportoKlubasID)
);

-- Table: SportoKlubuSarasas
CREATE TABLE SportoKlubuSarasas (
    abonementoPlanasID uniqueidentifier  NOT NULL,
    sportoKlubasID uniqueidentifier  NOT NULL
);

-- Table: SportoPlanas
CREATE TABLE SportoPlanas (
    sportoPlanasID uniqueidentifier  NOT NULL,
    sudaresTrenerisID uniqueidentifier  NOT NULL,
    laikotarpis date  NOT NULL,
    instrukcija nvarchar(max)  NOT NULL,
    CONSTRAINT SportoPlanas_pk PRIMARY KEY  (sportoPlanasID)
);

-- Table: SportoZona
CREATE TABLE SportoZona (
    sportoZonaID uniqueidentifier  NOT NULL,
    sportoKlubasID uniqueidentifier  NOT NULL,
    plotas decimal(4,2)  NOT NULL,
    CONSTRAINT SportoZona_pk PRIMARY KEY  (sportoZonaID)
);

-- Table: Treneris
CREATE TABLE Treneris (
    trenerioID uniqueidentifier  NOT NULL,
    naudotojoID uniqueidentifier  NOT NULL,
    issilavinimas varchar(30)  NOT NULL,
    darboStazas int  NOT NULL,
    CONSTRAINT Treneris_pk PRIMARY KEY  (trenerioID)
);

-- Table: TreniruociuSarasas
CREATE TABLE TreniruociuSarasas (
    sportoPlanasID uniqueidentifier  NOT NULL,
    treniruotesID uniqueidentifier  NOT NULL
);

-- Table: TreniruotesPlanas
CREATE TABLE TreniruotesPlanas (
    treniruotesPlanoID uniqueidentifier  NOT NULL,
    sportoZonaID uniqueidentifier  NOT NULL,
    treniruotesTipas varchar(30)  NOT NULL,
    dienosNumeris int  NOT NULL,
    aprasas nvarchar(max)  NOT NULL,
    CONSTRAINT TreniruotesPlanas_pk PRIMARY KEY  (treniruotesPlanoID)
);

-- foreign keys
-- Reference: Abonementas_AbonementoPlanas (table: Abonementas)
ALTER TABLE Abonementas ADD CONSTRAINT Abonementas_AbonementoPlanas
    FOREIGN KEY (abonementoPlanasID)
    REFERENCES AbonementoPlanas (abonementoPlanasID);

-- Reference: IndividualiTreniruote_Klientas (table: IndividualiTreniruote)
ALTER TABLE IndividualiTreniruote ADD CONSTRAINT IndividualiTreniruote_Klientas
    FOREIGN KEY (klientoID)
    REFERENCES Klientas (klientoID);

-- Reference: IndividualiTreniruote_Treneris (table: IndividualiTreniruote)
ALTER TABLE IndividualiTreniruote ADD CONSTRAINT IndividualiTreniruote_Treneris
    FOREIGN KEY (trenerioID)
    REFERENCES Treneris (trenerioID);

-- Reference: IndividualiTreniruote_Treniruote (table: IndividualiTreniruote)
ALTER TABLE IndividualiTreniruote ADD CONSTRAINT IndividualiTreniruote_Treniruote
    FOREIGN KEY (treniruotesPlanoID)
    REFERENCES TreniruotesPlanas (treniruotesPlanoID);

-- Reference: Inventorius_Iranga (table: Inventorius)
ALTER TABLE Inventorius ADD CONSTRAINT Inventorius_Iranga
    FOREIGN KEY (irangaID)
    REFERENCES Iranga (irangaID);

-- Reference: Inventorius_SportoZona (table: Inventorius)
ALTER TABLE Inventorius ADD CONSTRAINT Inventorius_SportoZona
    FOREIGN KEY (sportoZonaID)
    REFERENCES SportoZona (sportoZonaID);

-- Reference: Klientas_Abonementas (table: Klientas)
ALTER TABLE Klientas ADD CONSTRAINT Klientas_Abonementas
    FOREIGN KEY (abonementasID)
    REFERENCES Abonementas (abonementasID);

-- Reference: Klientas_MitybosPlanas (table: Klientas)
ALTER TABLE Klientas ADD CONSTRAINT Klientas_MitybosPlanas
    FOREIGN KEY (mitybosPlanasID)
    REFERENCES MitybosPlanas (mitybosPlanasID);

-- Reference: Klientas_Naudotojas (table: Klientas)
ALTER TABLE Klientas ADD CONSTRAINT Klientas_Naudotojas
    FOREIGN KEY (naudotojoID)
    REFERENCES Naudotojas (naudotojoID);

-- Reference: Klientas_SportoPlanas (table: Klientas)
ALTER TABLE Klientas ADD CONSTRAINT Klientas_SportoPlanas
    FOREIGN KEY (sportoPlanasID)
    REFERENCES SportoPlanas (sportoPlanasID);

-- Reference: MitybosPlanas_Treneris (table: MitybosPlanas)
ALTER TABLE MitybosPlanas ADD CONSTRAINT MitybosPlanas_Treneris
    FOREIGN KEY (sudaresTrenerisID)
    REFERENCES Treneris (trenerioID);

-- Reference: PratimuSarasas_Pratimas (table: PratimuSarasas)
ALTER TABLE PratimuSarasas ADD CONSTRAINT PratimuSarasas_Pratimas
    FOREIGN KEY (pratimasID)
    REFERENCES Pratimas (pratimasID);

-- Reference: PratimuSarasas_Treniruote (table: PratimuSarasas)
ALTER TABLE PratimuSarasas ADD CONSTRAINT PratimuSarasas_Treniruote
    FOREIGN KEY (treniruotesPlanoID)
    REFERENCES TreniruotesPlanas (treniruotesPlanoID);

-- Reference: SpecifikacijuSarasas_Pratimas (table: SpecifikacijuSarasas)
ALTER TABLE SpecifikacijuSarasas ADD CONSTRAINT SpecifikacijuSarasas_Pratimas
    FOREIGN KEY (pratimasID)
    REFERENCES Pratimas (pratimasID);

-- Reference: SpecifikacijuSarasas_PratimoSpecifikacija (table: SpecifikacijuSarasas)
ALTER TABLE SpecifikacijuSarasas ADD CONSTRAINT SpecifikacijuSarasas_PratimoSpecifikacija
    FOREIGN KEY (pratimoSpecifikacijaID)
    REFERENCES PratimoSpecifikacija (pratimoSpecifikacijaID);

-- Reference: SportoKlubuSarasas_AbonementoPlanas (table: SportoKlubuSarasas)
ALTER TABLE SportoKlubuSarasas ADD CONSTRAINT SportoKlubuSarasas_AbonementoPlanas
    FOREIGN KEY (abonementoPlanasID)
    REFERENCES AbonementoPlanas (abonementoPlanasID);

-- Reference: SportoKlubuSarasas_SportoKlubas (table: SportoKlubuSarasas)
ALTER TABLE SportoKlubuSarasas ADD CONSTRAINT SportoKlubuSarasas_SportoKlubas
    FOREIGN KEY (sportoKlubasID)
    REFERENCES SportoKlubas (sportoKlubasID);

-- Reference: SportoPlanas_Treneris (table: SportoPlanas)
ALTER TABLE SportoPlanas ADD CONSTRAINT SportoPlanas_Treneris
    FOREIGN KEY (sudaresTrenerisID)
    REFERENCES Treneris (trenerioID);

-- Reference: SportoZona_SportoKlubas (table: SportoZona)
ALTER TABLE SportoZona ADD CONSTRAINT SportoZona_SportoKlubas
    FOREIGN KEY (sportoKlubasID)
    REFERENCES SportoKlubas (sportoKlubasID);

-- Reference: Treneris_Naudotojas (table: Treneris)
ALTER TABLE Treneris ADD CONSTRAINT Treneris_Naudotojas
    FOREIGN KEY (naudotojoID)
    REFERENCES Naudotojas (naudotojoID);

-- Reference: TreniruociuSarasas_SportoPlanas (table: TreniruociuSarasas)
ALTER TABLE TreniruociuSarasas ADD CONSTRAINT TreniruociuSarasas_SportoPlanas
    FOREIGN KEY (sportoPlanasID)
    REFERENCES SportoPlanas (sportoPlanasID);

-- Reference: TreniruociuSarasas_Treniruote (table: TreniruociuSarasas)
ALTER TABLE TreniruociuSarasas ADD CONSTRAINT TreniruociuSarasas_Treniruote
    FOREIGN KEY (treniruotesID)
    REFERENCES TreniruotesPlanas (treniruotesPlanoID);

-- Reference: Treniruote_SportoZona (table: TreniruotesPlanas)
ALTER TABLE TreniruotesPlanas ADD CONSTRAINT Treniruote_SportoZona
    FOREIGN KEY (sportoZonaID)
    REFERENCES SportoZona (sportoZonaID);

-- End of file.

