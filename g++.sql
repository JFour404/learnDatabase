DROP TABLE NAUDOTOJAS CASCADE CONSTRAINTS;
DROP TABLE SPORTOKLUBAS CASCADE CONSTRAINTS;
DROP TABLE SPORTOPLANAS CASCADE CONSTRAINTS;
DROP TABLE SPORTOZONA CASCADE CONSTRAINTS;
DROP TABLE TRENERIS CASCADE CONSTRAINTS;
DROP TABLE ABONEMENTAS CASCADE CONSTRAINTS;
DROP TABLE TRENIRUOTESPLANAS CASCADE CONSTRAINTS;
DROP TABLE MITYBOSPLANAS CASCADE CONSTRAINTS;
DROP TABLE IRANGA CASCADE CONSTRAINTS;
DROP TABLE PRATIMOINFORMACIJA CASCADE CONSTRAINTS;
DROP TABLE PRATIMOSPECIFIKACIJA CASCADE CONSTRAINTS;
DROP TABLE PRATIMAS CASCADE CONSTRAINTS;
DROP TABLE TRENIRUOCIUSARASAS CASCADE CONSTRAINTS;
DROP TABLE PRATIMUSARASAS CASCADE CONSTRAINTS;
DROP TABLE ABONEMENTOPLANAS CASCADE CONSTRAINTS;
DROP TABLE SPORTOKLUBUSARASAS CASCADE CONSTRAINTS;
DROP TABLE INDIVIDUALITRENIRUOTE CASCADE CONSTRAINTS;
DROP TABLE INVENTORIUS CASCADE CONSTRAINTS;
DROP TABLE KLIENTAS CASCADE CONSTRAINTS;

CREATE TABLE Naudotojas (
    naudotojoID RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    slaptazodis VARCHAR2(30) NOT NULL,
    role VARCHAR2(30) NOT NULL,
    vardas VARCHAR2(30) NOT NULL,
    pavarde VARCHAR2(30) NOT NULL,
    asmensKodas NUMBER(10) NOT NULL
);

CREATE TABLE SportoKlubas (
    sportoKlubasID RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    pavadinimas VARCHAR2(30) NOT NULL,
    adresas VARCHAR2(30) NOT NULL,
    plotas NUMBER(6,2) NOT NULL,
    kontaktai CLOB NOT NULL
);

CREATE TABLE SportoPlanas (
    sportoPlanasID RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    sudaresTrenerisID RAW(16) NOT NULL,
    laikotarpis DATE NOT NULL,
    instrukcija CLOB NOT NULL
);

CREATE TABLE SportoZona (
    sportoZonaID RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    sportoKlubasID RAW(16) NOT NULL,
    plotas NUMBER(6,2) NOT NULL
);

CREATE TABLE Treneris (
    trenerioID RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    naudotojoID RAW(16) NOT NULL,
    issilavinimas VARCHAR2(30) NOT NULL,
    darboStazas NUMBER(3) NOT NULL
);

CREATE TABLE Abonementas (
    abonementasID RAW(16) PRIMARY KEY,
    abonementoPlanasID RAW(16) NOT NULL,
    galiojimoPradzia DATE NOT NULL,
    galiojimoPabaiga DATE NOT NULL
);

CREATE TABLE TreniruotesPlanas (
    treniruotesPlanoID RAW(16) PRIMARY KEY,
    sportoZonaID RAW(16) NOT NULL,
    treniruotesTipas VARCHAR2(30) NOT NULL,
    dienosNumeris NUMBER(2) NOT NULL,
    aprasas CLOB NOT NULL
);

CREATE TABLE MitybosPlanas (
    mitybosPlanasID RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    sudaresTrenerisID RAW(16) NOT NULL,
    laikotarpis DATE NOT NULL,
    kalorijosPerDiena NUMBER(5) NOT NULL,
    dienosAngliavandeniai NUMBER(5) NOT NULL,
    dienosRiebalai NUMBER(5) NOT NULL,
    dienosBaltymai NUMBER(5) NOT NULL,
    dienosVandensKiekis FLOAT(2) NOT NULL,
    instrukcija CLOB NOT NULL
);

CREATE TABLE Iranga (
    irangaID RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    tipas VARCHAR2(30) NOT NULL,
    gamintojas VARCHAR2(30) NOT NULL,
    verte NUMBER(10) NOT NULL,
    aprasas CLOB NOT NULL
);

CREATE TABLE PratimoInformacija (
    pratimoInfoID RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    pavadinimas VARCHAR2(30) NOT NULL,
    instrukcija VARCHAR2(100) NOT NULL
);

CREATE TABLE PratimoSpecifikacija (
    pratimoSpecifikacijaID RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    pakartojimai NUMBER(5) NOT NULL,
    serijos NUMBER(5) NOT NULL,
    poilsisTarpSeriju NUMBER(5) NOT NULL
);

CREATE TABLE Pratimas (
    pratimasID RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    pratimoInfoID RAW(16) NOT NULL,
    pratimoSpecifikacijaID RAW(16) NOT NULL
);

CREATE TABLE TreniruociuSarasas (
    sportoPlanasID RAW(16) NOT NULL,
    treniruotesPlanoID RAW(16) NOT NULL
);

CREATE TABLE PratimuSarasas (
    treniruotesPlanoID RAW(16) NOT NULL,
    pratimasID RAW(16) NOT NULL
);

CREATE TABLE AbonementoPlanas (
    abonementoPlanasID RAW(16) PRIMARY KEY,
    kaina NUMBER(10,2) NOT NULL,
    arTerminuota NUMBER(1) NOT NULL,
    privalumai CLOB NOT NULL
);

CREATE TABLE SportoKlubuSarasas (
    abonementoPlanasID RAW(16) NOT NULL,
    sportoKlubasID RAW(16) NOT NULL
);

CREATE TABLE Klientas (
    klientoID RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    naudotojoID RAW(16) NOT NULL,
    sportoPlanasID RAW(16) NOT NULL,
    mitybosPlanasID RAW(16) NOT NULL,
    abonementasID RAW(16) NOT NULL
);

CREATE TABLE IndividualiTreniruote (
    klientoID RAW(16) NOT NULL,
    trenerioID RAW(16) NOT NULL,
    treniruotesPlanoID RAW(16) NOT NULL
);

CREATE TABLE Inventorius (
    irangaID RAW(16) NOT NULL,
    sportoZonaID RAW(16) NOT NULL
);

-- Constraints --
ALTER TABLE SportoPlanas ADD CONSTRAINT FK_SpPl_Treneris FOREIGN KEY (sudaresTrenerisID) REFERENCES Treneris(trenerioID);
ALTER TABLE SportoZona ADD CONSTRAINT FK_SpZo_SpKl FOREIGN KEY (sportoKlubasID) REFERENCES SportoKlubas(sportoKlubasID);
ALTER TABLE Treneris ADD CONSTRAINT FK_Tren_Naud FOREIGN KEY (naudotojoID) REFERENCES Naudotojas(naudotojoID);
ALTER TABLE Abonementas ADD CONSTRAINT FK_Abon_AbonPlan FOREIGN KEY (abonementoPlanasID) REFERENCES AbonementoPlanas(abonementoPlanasID);
ALTER TABLE TreniruotesPlanas ADD CONSTRAINT FK_TrenPlan_SpZo FOREIGN KEY (sportoZonaID) REFERENCES SportoZona(sportoZonaID);
ALTER TABLE MitybosPlanas ADD CONSTRAINT FK_Mityb_Tren FOREIGN KEY (sudaresTrenerisID) REFERENCES Treneris(trenerioID);
ALTER TABLE Pratimas ADD CONSTRAINT FK_Prat_PratInfo FOREIGN KEY (pratimoInfoID) REFERENCES PratimoInformacija(pratimoInfoID);
ALTER TABLE Pratimas ADD CONSTRAINT FK_Prat_PratSpec FOREIGN KEY (pratimoSpecifikacijaID) REFERENCES PratimoSpecifikacija(pratimoSpecifikacijaID);
ALTER TABLE TreniruociuSarasas ADD CONSTRAINT FK_TrenSar_SpPl FOREIGN KEY (sportoPlanasID) REFERENCES SportoPlanas(sportoPlanasID);
ALTER TABLE TreniruociuSarasas ADD CONSTRAINT FK_TrenSar_TrenPl FOREIGN KEY (treniruotesPlanoID) REFERENCES TreniruotesPlanas(treniruotesPlanoID);
ALTER TABLE PratimuSarasas ADD CONSTRAINT FK_PratSar_TrenPl FOREIGN KEY (treniruotesPlanoID) REFERENCES TreniruotesPlanas(treniruotesPlanoID);
ALTER TABLE PratimuSarasas ADD CONSTRAINT FK_PratSar_Prat FOREIGN KEY (pratimasID) REFERENCES Pratimas(pratimasID);
ALTER TABLE SportoKlubuSarasas ADD CONSTRAINT FK_SpKlSar_AbonPlan FOREIGN KEY (abonementoPlanasID) REFERENCES AbonementoPlanas(abonementoPlanasID);
ALTER TABLE SportoKlubuSarasas ADD CONSTRAINT FK_SpKlSar_SpKl FOREIGN KEY (sportoKlubasID) REFERENCES SportoKlubas(sportoKlubasID);
ALTER TABLE Klientas ADD CONSTRAINT FK_Kl_Naud FOREIGN KEY (naudotojoID) REFERENCES Naudotojas(naudotojoID);
ALTER TABLE Klientas ADD CONSTRAINT FK_Kl_SpPlan FOREIGN KEY (sportoPlanasID) REFERENCES SportoPlanas(sportoPlanasID);
ALTER TABLE Klientas ADD CONSTRAINT FK_Kl_MitPlan FOREIGN KEY (mitybosPlanasID) REFERENCES MitybosPlanas(mitybosPlanasID);
ALTER TABLE Klientas ADD CONSTRAINT FK_Kl_Abon FOREIGN KEY (abonementasID) REFERENCES Abonementas(abonementasID);
ALTER TABLE IndividualiTreniruote ADD CONSTRAINT FK_IndTr_Kl FOREIGN KEY (klientoID) REFERENCES Klientas(klientoID);
ALTER TABLE IndividualiTreniruote ADD CONSTRAINT FK_IndTr_Tr FOREIGN KEY (trenerioID) REFERENCES Treneris(trenerioID);
ALTER TABLE IndividualiTreniruote ADD CONSTRAINT FK_IndTr_TrenPlan FOREIGN KEY (treniruotesPlanoID) REFERENCES TreniruotesPlanas(treniruotesPlanoID);
ALTER TABLE Inventorius ADD CONSTRAINT FK_Inv_SpZo FOREIGN KEY (sportoZonaID) REFERENCES SportoZona(sportoZonaID);
ALTER TABLE Inventorius ADD CONSTRAINT FK_Inv_Iran FOREIGN KEY (irangaID) REFERENCES Iranga(IrangaID);

INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (1, 4, '2017-07-28', '1987-06-09');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (2, 4, '1990-12-13', '2016-03-27');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (3, 1, '2000-04-11', '1978-03-05');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (4, 6, '1973-05-27', '2010-10-11');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (5, 2, '2017-01-31', '1983-10-15');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (6, 1, '1982-05-10', '1972-05-13');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (7, 5, '2023-11-05', '2005-05-15');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (8, 5, '2005-01-09', '1997-02-11');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (9, 4, '2006-09-15', '1977-08-05');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (10, 1, '2004-03-09', '1973-06-21');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (11, 3, '1970-03-27', '1987-01-09');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (12, 5, '2011-02-11', '1990-03-12');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (13, 2, '2002-08-09', '2006-07-02');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (14, 4, '1977-04-10', '1981-03-15');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (15, 5, '1974-05-25', '1986-07-28');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (16, 2, '1974-08-11', '1972-08-30');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (17, 2, '2016-05-07', '2008-06-26');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (18, 4, '2020-07-24', '1974-07-12');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (19, 1, '1973-12-14', '1970-02-20');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (20, 4, '1985-08-30', '1982-09-02');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (21, 2, '1998-08-14', '1974-05-14');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (22, 1, '2009-04-18', '2012-11-01');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (23, 6, '2011-12-28', '2016-01-11');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (24, 5, '2017-10-19', '2001-06-26');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (25, 3, '2009-04-05', '2022-01-03');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (26, 5, '1982-04-02', '2019-05-24');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (27, 6, '2011-08-04', '1984-10-28');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (28, 5, '1979-10-24', '2007-09-03');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (29, 3, '1981-11-22', '1993-10-28');
INSERT INTO `Abonementas` (`abonementasID`, `abonementoPlanasID`, `galiojimoPradzia`, `galiojimoPabaiga`) VALUES (30, 2, '1986-03-26', '1983-05-15');


INSERT INTO `AbonementoPlanas` (`abonementoPlanasID`, `kaina`, `arTerminuota`, `privalumai`) VALUES (1, '20.00', 0, 'Aut optio minus omnis voluptatem cumque.');
INSERT INTO `AbonementoPlanas` (`abonementoPlanasID`, `kaina`, `arTerminuota`, `privalumai`) VALUES (2, '15.00', 0, 'Voluptate temporibus ut ipsum magni et veritatis porro.');
INSERT INTO `AbonementoPlanas` (`abonementoPlanasID`, `kaina`, `arTerminuota`, `privalumai`) VALUES (3, '25.00', 0, 'Accusantium laboriosam qui facilis molestiae similique assumenda qui.');
INSERT INTO `AbonementoPlanas` (`abonementoPlanasID`, `kaina`, `arTerminuota`, `privalumai`) VALUES (4, '15.00', 0, 'Expedita dicta ex placeat quaerat id modi.');
INSERT INTO `AbonementoPlanas` (`abonementoPlanasID`, `kaina`, `arTerminuota`, `privalumai`) VALUES (5, '25.00', 1, 'Et aliquam et animi animi at voluptas ratione.');
INSERT INTO `AbonementoPlanas` (`abonementoPlanasID`, `kaina`, `arTerminuota`, `privalumai`) VALUES (6, '30.00', 0, 'Qui doloremque quos possimus hic unde dolorem minima.');


INSERT INTO `IndividualiTreniruote` (`klientoID`, `trenerioID`, `treniruotesPlanoID`) VALUES (1, 1, 1);
INSERT INTO `IndividualiTreniruote` (`klientoID`, `trenerioID`, `treniruotesPlanoID`) VALUES (2, 2, 2);
INSERT INTO `IndividualiTreniruote` (`klientoID`, `trenerioID`, `treniruotesPlanoID`) VALUES (3, 3, 3);
INSERT INTO `IndividualiTreniruote` (`klientoID`, `trenerioID`, `treniruotesPlanoID`) VALUES (4, 4, 4);
INSERT INTO `IndividualiTreniruote` (`klientoID`, `trenerioID`, `treniruotesPlanoID`) VALUES (5, 5, 5);


INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (25, 14);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (47, 15);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (40, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (26, 10);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (30, 10);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (19, 13);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (33, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (26, 12);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (12, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (19, 6);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (33, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (22, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (31, 11);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (7, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (27, 6);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (3, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (25, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (28, 12);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (17, 7);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (10, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (8, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (40, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (23, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (14, 7);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (6, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (46, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (39, 6);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (50, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (40, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (14, 7);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (42, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (12, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (25, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (13, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (18, 7);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (33, 13);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (30, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (12, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (38, 15);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (43, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (49, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (22, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (25, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (42, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (28, 11);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (32, 6);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (29, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (15, 10);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (18, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (41, 7);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (4, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (7, 14);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (6, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (50, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (44, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (29, 14);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (42, 10);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (2, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (21, 7);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (48, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (23, 15);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (49, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (29, 13);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (43, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (50, 11);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (28, 6);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (43, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (21, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (17, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (42, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (33, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (6, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (40, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (31, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (44, 7);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (43, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (8, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (22, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (48, 7);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (3, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (8, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (17, 11);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (19, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (38, 7);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (18, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (14, 7);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (30, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (3, 15);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (33, 6);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (1, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (13, 12);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (34, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (14, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (8, 10);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (43, 6);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (19, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (42, 14);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (1, 7);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (41, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (17, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (46, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (2, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (27, 15);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (4, 12);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (4, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (20, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (32, 7);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (17, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (18, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (20, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (12, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (24, 14);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (40, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (27, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (26, 7);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (30, 6);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (41, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (35, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (47, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (25, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (36, 11);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (30, 7);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (11, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (8, 11);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (45, 14);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (11, 11);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (4, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (24, 10);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (48, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (20, 12);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (41, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (15, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (35, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (17, 10);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (48, 14);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (45, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (17, 15);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (33, 14);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (41, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (7, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (11, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (39, 12);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (43, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (37, 14);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (25, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (26, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (16, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (31, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (38, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (28, 12);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (45, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (15, 6);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (13, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (39, 15);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (3, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (20, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (46, 15);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (16, 10);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (40, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (24, 6);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (30, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (29, 12);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (50, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (21, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (29, 10);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (36, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (7, 10);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (14, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (7, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (23, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (20, 11);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (49, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (27, 12);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (30, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (17, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (10, 13);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (32, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (28, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (48, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (17, 14);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (15, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (3, 12);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (25, 14);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (9, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (3, 14);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (37, 15);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (13, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (37, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (45, 13);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (19, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (13, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (37, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (50, 10);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (34, 15);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (49, 11);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (7, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (1, 11);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (32, 11);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (13, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (27, 14);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (46, 10);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (18, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (19, 14);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (26, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (47, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (12, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (3, 11);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (45, 14);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (21, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (23, 11);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (24, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (45, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (5, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (14, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (17, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (12, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (41, 6);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (2, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (44, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (11, 13);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (23, 15);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (19, 6);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (41, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (46, 7);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (8, 10);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (31, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (2, 14);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (48, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (42, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (50, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (16, 6);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (2, 6);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (35, 12);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (49, 15);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (47, 15);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (16, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (36, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (15, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (12, 6);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (44, 13);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (48, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (16, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (1, 12);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (43, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (25, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (16, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (12, 10);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (47, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (37, 10);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (13, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (10, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (19, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (39, 14);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (11, 13);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (24, 15);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (42, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (9, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (28, 14);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (6, 13);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (15, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (47, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (36, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (14, 10);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (8, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (10, 13);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (43, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (11, 7);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (47, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (39, 14);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (8, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (32, 2);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (20, 10);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (43, 14);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (18, 13);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (1, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (1, 7);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (3, 11);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (11, 3);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (32, 8);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (1, 13);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (30, 12);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (46, 15);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (47, 11);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (44, 9);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (12, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (9, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (12, 15);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (29, 4);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (8, 10);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (43, 10);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (8, 13);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (39, 6);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (40, 5);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (7, 11);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (37, 11);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (13, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (26, 13);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (34, 1);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (44, 6);
INSERT INTO `Inventorius` (`irangaID`, `sportoZonaID`) VALUES (11, 8);


INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (1, 'hantelis', 'Tunturi', 234, 'Ut explicabo quo corrupti et.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (2, ' svarmuo', ' Funfit', 54, 'Sapiente sequi dignissimos atque aperiam.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (3, ' svarmuo', ' Funfit', 163, 'Libero laudantium voluptatem dolorum.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (4, ' svarmuo', ' Tiguar', 213, 'Eveniet sunt odio dolorum culpa dolor.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (5, ' svarmuo', ' Tiguar', 54, 'Qui fugit mollitia aut et.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (6, ' stakles rankoms', 'Tunturi', 84, 'Dignissimos illo est officiis et id voluptate temporibus.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (7, ' svarmuo', ' Funfit', 116, 'Dolor in est necessitatibus ea.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (8, ' dviratis', ' Funfit', 155, 'Distinctio voluptate consequatur inventore quis.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (9, ' stanga', 'Tunturi', 159, 'Pariatur aliquid animi magni sed illum delectus.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (10, ' stanga', ' Tiguar', 108, 'Nihil impedit eveniet quibusdam id aliquam.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (11, 'hantelis', ' Tiguar', 35, 'Incidunt praesentium ex quis voluptatem recusandae rem ad consequatur.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (12, 'hantelis', ' Tiguar', 185, 'Magni assumenda non corrupti suscipit.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (13, ' begimo takelis', 'Tunturi', 216, 'Ullam quia exercitationem sit unde.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (14, ' stakles kojoms', ' Tiguar', 232, 'Non doloremque sit molestiae nemo tempore deleniti.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (15, ' narvas', ' Tiguar', 178, 'Voluptatem nihil cumque sunt assumenda eligendi quos.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (16, ' dviratis', 'Tunturi', 75, 'Facilis explicabo voluptate perspiciatis cumque.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (17, ' stanga', ' Tiguar', 114, 'Voluptatem quos animi aspernatur laudantium in rem dignissimos ut.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (18, ' suoliukas', ' Funfit', 70, 'Non distinctio est ullam velit id.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (19, 'hantelis', 'Tunturi', 27, 'Voluptatem labore perferendis optio non esse consequatur officia.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (20, ' stanga', ' Tiguar', 131, 'Rem provident fugiat ipsa dolorem.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (21, ' svarmuo', ' Tiguar', 83, 'Eligendi qui rerum eius consequatur animi harum doloremque.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (22, ' dviratis', ' Tiguar', 12, 'Aut nobis harum consequatur provident.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (23, ' svarmuo', ' Tiguar', 111, 'Quas quos autem sapiente voluptatem recusandae autem.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (24, ' stanga', 'Tunturi', 162, 'Hic quae excepturi aliquid minima asperiores sunt et.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (25, ' suoliukas', ' Tiguar', 248, 'Magnam ab repellat et veritatis.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (26, ' narvas', 'Tunturi', 197, 'Distinctio tempora nisi voluptatum saepe.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (27, 'hantelis', ' Tiguar', 178, 'Non dolorum consequatur vel voluptas et quos.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (28, ' stanga', 'Tunturi', 185, 'Nihil sed illo omnis perspiciatis voluptatem omnis.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (29, ' begimo takelis', 'Tunturi', 207, 'Sint repellendus ullam illum et nemo ratione pariatur quis.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (30, ' svarmuo', ' Funfit', 36, 'Alias fugit est corrupti sunt et.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (31, ' stanga', ' Tiguar', 232, 'Velit ipsum rerum consequatur quas.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (32, ' begimo takelis', 'Tunturi', 74, 'Officiis ipsa id facilis amet.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (33, ' suoliukas', ' Tiguar', 180, 'Odit explicabo facere sint.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (34, ' suoliukas', 'Tunturi', 181, 'Iste quis eum suscipit quibusdam mollitia quibusdam.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (35, ' svarmuo', ' Funfit', 230, 'Vel et mollitia consequatur et.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (36, ' suoliukas', 'Tunturi', 112, 'Mollitia minus nisi sapiente consequatur et.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (37, ' narvas', 'Tunturi', 148, 'Modi non qui nisi delectus possimus tempora.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (38, ' stanga', 'Tunturi', 204, 'Explicabo enim rem ipsa eum sed.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (39, ' stanga', ' Funfit', 167, 'Veritatis ut ratione et exercitationem corrupti.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (40, ' svarmuo', ' Funfit', 44, 'Ipsam reiciendis omnis ut ut vitae autem.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (41, ' suoliukas', 'Tunturi', 131, 'Quia recusandae harum placeat ipsum eum dolore.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (42, ' svarmuo', ' Funfit', 115, 'Vero ipsum dignissimos consequatur facilis consequatur.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (43, ' svarmuo', 'Tunturi', 230, 'Quisquam porro quia et cum qui asperiores.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (44, ' svarmuo', ' Funfit', 61, 'Accusantium et labore et autem fuga ipsam saepe.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (45, ' stakles kojoms', ' Funfit', 106, 'Reiciendis velit aut delectus odit et enim doloribus.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (46, ' svarmuo', ' Funfit', 20, 'Qui architecto voluptatem qui et non aperiam.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (47, ' dviratis', ' Funfit', 175, 'Recusandae voluptatum similique rerum omnis fugiat tempore error.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (48, ' stakles kojoms', 'Tunturi', 55, 'Totam sed velit ea illo.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (49, ' stanga', ' Funfit', 155, 'Voluptatem sit debitis fugit debitis sint et.');
INSERT INTO `Iranga` (`irangaID`, `tipas`, `gamintojas`, `verte`, `aprasas`) VALUES (50, ' dviratis', 'Tunturi', 170, 'Fuga consequuntur molestias laboriosam aliquid.');


INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (1, 3, 19, 28, 18);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (2, 4, 6, 19, 26);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (3, 8, 22, 4, 11);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (4, 12, 14, 17, 2);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (5, 16, 23, 22, 25);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (6, 17, 13, 17, 24);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (7, 19, 17, 25, 22);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (8, 33, 4, 21, 19);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (9, 34, 12, 14, 29);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (10, 36, 28, 14, 14);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (11, 37, 26, 1, 4);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (12, 38, 1, 6, 8);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (13, 42, 27, 9, 30);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (14, 45, 5, 7, 21);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (15, 49, 9, 20, 28);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (16, 51, 17, 5, 17);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (17, 52, 30, 25, 13);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (18, 58, 7, 23, 27);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (19, 60, 10, 3, 10);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (20, 61, 29, 4, 20);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (21, 64, 23, 6, 12);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (22, 67, 26, 30, 1);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (23, 68, 30, 14, 3);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (24, 69, 26, 12, 7);
INSERT INTO `Klientas` (`klientoID`, `naudotojoID`, `sportoPlanasID`, `mitybosPlanasID`, `abonementasID`) VALUES (25, 75, 10, 9, 23);


INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (1, 1, '0000-00-00', 2162, 244, 195, 149, '2814', 'Voluptates eaque voluptas saepe. Dignissimos vel nemo aut iure vel aperiam.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (2, 2, '0000-00-00', 2818, 181, 106, 101, '2525', 'Laboriosam ut et et maxime placeat omnis mollitia. Aliquid quasi unde quos nesciunt quos cumque perspiciatis.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (3, 3, '0000-00-00', 3690, 175, 114, 245, '2752', 'Iste dolor temporibus autem. Velit delectus ullam quia et voluptatum beatae ea quaerat. Magnam occaecati sequi minus dolor eveniet porro.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (4, 4, '0000-00-00', 3135, 294, 195, 68, '3862', 'Non doloribus veniam quis maxime deserunt aut. Excepturi voluptas nihil aut voluptatem ipsa iste incidunt.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (5, 5, '0000-00-00', 1667, 214, 124, 129, '3016', 'Inventore optio placeat quia dolorum ex. Quidem quia error quasi soluta nobis necessitatibus voluptatibus.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (6, 6, '0000-00-00', 2462, 253, 114, 143, '2034', 'Nam quidem ut beatae vero officiis eum fugit et. Distinctio nostrum hic tempore sed provident.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (7, 7, '0000-00-00', 2379, 284, 182, 244, '3160', 'Odit praesentium excepturi nostrum porro. Quam cupiditate laudantium est.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (8, 8, '0000-00-00', 3994, 267, 194, 162, '2404', 'Aliquid libero laudantium minima optio tempore maiores. Laborum ipsum qui ad sit perferendis. Repellat ut rerum quis voluptate minima.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (9, 9, '0000-00-00', 2196, 142, 183, 249, '3207', 'Omnis error quo enim aut molestias labore quia. Et voluptas aut voluptatibus doloremque amet id itaque.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (10, 10, '0000-00-00', 2753, 133, 159, 231, '3477', 'Pariatur voluptates tenetur nihil nemo sint architecto voluptates non. Sit repellendus porro velit rem quam enim dolorem. Rerum voluptatum ipsum perspiciatis odit.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (11, 1, '0000-00-00', 3621, 170, 103, 64, '3149', 'Sit perspiciatis omnis culpa. Eum in ut dicta vero vitae odit. Velit debitis sed ut asperiores.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (12, 2, '0000-00-00', 2612, 137, 182, 110, '2744', 'Cum velit quia aut cupiditate. Omnis nihil eligendi impedit aut enim quisquam ab.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (13, 3, '0000-00-00', 2264, 230, 156, 169, '3371', 'Iste animi voluptates illo est aperiam. Amet a ea aut impedit. Qui totam aut sed aspernatur perferendis possimus qui.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (14, 4, '0000-00-00', 2040, 284, 138, 113, '2235', 'Possimus non animi perferendis temporibus nostrum non vero. Id placeat non ab in qui.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (15, 5, '0000-00-00', 2425, 148, 114, 183, '3199', 'Iusto similique qui quos voluptatem aut. Natus velit ut est.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (16, 6, '0000-00-00', 3729, 169, 140, 119, '3245', 'Voluptatem numquam quia soluta quisquam. Qui commodi qui quisquam.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (17, 7, '0000-00-00', 1196, 264, 115, 133, '2131', 'Tempore quis beatae ratione magnam in quam ut. Dolores ipsam id minima earum distinctio quos. Asperiores occaecati soluta hic in dignissimos repellat non.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (18, 8, '0000-00-00', 2749, 250, 193, 243, '3397', 'Eligendi et sint illum pariatur dolorem sunt aut. Vel ipsam ipsa maxime tempore maiores.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (19, 9, '0000-00-00', 1278, 188, 136, 107, '2483', 'Qui sit hic laborum aspernatur sed. Quibusdam id maiores atque et et recusandae aut. Animi autem ipsa dolore odit.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (20, 10, '0000-00-00', 3372, 285, 109, 238, '2375', 'Laborum sint et consequatur quibusdam molestiae non neque molestiae. Veritatis rerum omnis possimus praesentium at atque omnis.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (21, 1, '0000-00-00', 1921, 148, 119, 237, '3722', 'Voluptatem est ipsum odit. Natus voluptas qui dignissimos qui et et possimus.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (22, 2, '0000-00-00', 3835, 228, 167, 87, '3174', 'Quibusdam pariatur est maxime autem quae omnis quaerat itaque. Dolorem dolor quis a quibusdam atque.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (23, 3, '0000-00-00', 1184, 200, 99, 105, '2751', 'Aut nobis qui sequi qui modi sequi molestiae quis. Ex atque aliquid id reprehenderit.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (24, 4, '0000-00-00', 3085, 290, 110, 83, '3825', 'Aut distinctio omnis voluptas cupiditate odit. Veniam facere dolorem consequatur velit culpa. Iste voluptas et eligendi rerum velit aliquam dolore.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (25, 5, '0000-00-00', 3085, 291, 141, 125, '2070', 'Alias ratione dolores rerum nesciunt rem aut. Quia tempore nisi eum temporibus esse ea aspernatur. Rem et illum in et dolorem velit maiores.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (26, 6, '0000-00-00', 2834, 242, 129, 221, '3705', 'Quod unde dolores minima ea culpa eligendi et. Sequi odio ut labore aut cum.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (27, 7, '0000-00-00', 3012, 237, 152, 51, '3608', 'Unde excepturi pariatur quas laudantium impedit. Ad enim voluptatibus reiciendis libero vel esse voluptate. Nihil enim est earum et itaque debitis molestiae.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (28, 8, '0000-00-00', 1699, 241, 196, 234, '3064', 'Ea id corporis non natus. Tempora numquam eius molestiae laborum nihil qui et mollitia.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (29, 9, '0000-00-00', 2466, 244, 190, 185, '2482', 'Perspiciatis ut animi ad impedit quae iste dolorem. Ad dolores porro quia aut neque nihil. Quia cumque nam sed eveniet quos quia.');
INSERT INTO `MitybosPlanas` (`mitybosPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `kalorijosPerDiena`, `dienosAngliavandeniai`, `dienosRiebalai`, `dienosBaltymai`, `dienosVandensKiekis`, `instrukcija`) VALUES (30, 10, '0000-00-00', 1705, 202, 118, 202, '3425', 'Dicta deleniti cumque voluptas ut. Aut eos ipsum non. Quibusdam fuga asperiores tempora aut.');


INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (1, 'Aut natus sunt similique.', 'treneris', 'Alexis', 'Howell', 24287449);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (2, 'Sed et sit est eligendi.', 'treneris', 'Rahsaan', 'Wunsch', 48339360);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (3, 'Aperiam at aut est ut quia.', ' klientas', 'Kamron', 'Lebsack', 60072450);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (4, 'Rerum voluptate placeat est.', ' klientas', 'Jarrett', 'Kreiger', 68134426);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (5, 'Quo odio ipsam cum ut.', 'admin', 'Mya', 'Glover', 45504297);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (6, 'Dolore mollitia iste et rem.', 'admin', 'Frieda', 'Hansen', 95578026);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (7, 'Porro soluta qui ad nihil.', 'treneris', 'Jerry', 'Little', 90211171);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (8, 'Aut consequuntur non debitis.', ' klientas', 'Madge', 'Marquardt', 68751074);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (9, 'Beatae aliquid ea voluptatem.', 'treneris', 'Haley', 'Wisoky', 57424934);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (10, 'Ex dolor in eligendi.', 'treneris', 'Xzavier', 'Sauer', 46622341);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (11, 'Earum quia minima modi.', 'admin', 'Osvaldo', 'Denesik', 86723688);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (12, 'Est ut qui voluptas.', ' klientas', 'Reba', 'Hermiston', 70513608);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (13, 'Eveniet ut dolor et expedita.', 'admin', 'Margie', 'Watsica', 53794789);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (14, 'Ullam omnis ex similique.', 'treneris', 'Frieda', 'Berge', 62415439);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (15, 'Et assumenda nihil ut.', 'admin', 'Bailey', 'Runte', 91310903);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (16, 'Totam molestias quia rem.', ' klientas', 'Sigrid', 'Bahringer', 65538678);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (17, 'Consectetur autem totam quam.', ' klientas', 'Drew', 'Monahan', 66209843);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (18, 'Non perferendis est porro.', 'admin', 'Torrey', 'Hilll', 10808733);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (19, 'Itaque ullam voluptatibus in.', ' klientas', 'Leatha', 'Johnston', 3551912);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (20, 'Sequi rerum quia qui.', 'treneris', 'Domenico', 'Walter', 13090906);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (21, 'Est tempore ad et alias et.', 'admin', 'Lucio', 'Schmeler', 83811807);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (22, 'Iste eos aut sunt veniam.', 'treneris', 'Ava', 'Welch', 14749667);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (23, 'Non optio et aut in.', 'treneris', 'Dale', 'Heller', 52374029);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (24, 'Est saepe dolorem numquam.', 'admin', 'Dallin', 'Weimann', 70230864);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (25, 'Totam est et voluptatem quis.', 'treneris', 'Wilton', 'Kirlin', 35405467);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (26, 'Sed sit sit blanditiis.', 'admin', 'Chanel', 'Hamill', 39668608);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (27, 'Sit saepe dolores iure rerum.', 'treneris', 'Asha', 'Koelpin', 82618254);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (28, 'Qui est beatae qui soluta.', 'treneris', 'Dejuan', 'Crona', 85246522);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (29, 'Sunt rerum fugiat beatae aut.', 'admin', 'Nettie', 'Erdman', 40047546);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (30, 'At delectus veniam dicta vel.', 'treneris', 'Vivian', 'Pollich', 86792455);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (31, 'Quis consequatur veniam nisi.', 'treneris', 'Myrtle', 'Volkman', 23741225);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (32, 'Iusto minima ea optio ipsum.', 'treneris', 'Carroll', 'Klein', 22347039);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (33, 'Quia adipisci dolorum magni.', ' klientas', 'Skyla', 'Lemke', 61947979);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (34, 'Omnis delectus quidem vel.', ' klientas', 'Evan', 'Balistreri', 34782552);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (35, 'Ducimus dicta qui illo saepe.', 'admin', 'Orion', 'Wehner', 6738280);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (36, 'Ut assumenda et ullam in.', ' klientas', 'Nikita', 'Powlowski', 8519726);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (37, 'Nemo beatae magnam sit.', ' klientas', 'Assunta', 'Erdman', 84666758);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (38, 'Ut aut saepe doloremque.', ' klientas', 'King', 'Beier', 31990301);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (39, 'Sit odit tenetur voluptatem.', 'admin', 'Armando', 'Schneider', 27772560);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (40, 'Enim ea quia quis unde.', 'treneris', 'Elizabeth', 'Wuckert', 10967768);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (41, 'Et aut debitis ea et est.', 'admin', 'Adrienne', 'Hickle', 61957077);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (42, 'Autem eum odio sunt sed.', ' klientas', 'Luciano', 'Lockman', 17670630);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (43, 'Sit est aut velit velit.', 'treneris', 'Alexandrea', 'Mertz', 67305407);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (44, 'Laboriosam aut eos ea est.', 'admin', 'Karolann', 'Jones', 84090331);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (45, 'Fugiat sint unde at natus.', ' klientas', 'Nicolas', 'Hauck', 47929234);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (46, 'Iste aut nam sed quisquam.', 'admin', 'Karen', 'Fay', 83143052);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (47, 'Sed non facere modi non quos.', 'treneris', 'Judson', 'Leuschke', 44836290);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (48, 'Omnis molestias sit magni et.', 'admin', 'Fatima', 'Vandervort', 91012999);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (49, 'Ea earum rem ipsa velit.', ' klientas', 'Madyson', 'Kertzmann', 39045003);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (50, 'Unde maxime ea quod.', 'admin', 'Irma', 'Goodwin', 47667594);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (51, 'Maxime illum rerum et alias.', ' klientas', 'Rachael', 'Mayert', 59271550);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (52, 'Vel id molestiae ea ut.', ' klientas', 'Luella', 'Willms', 11866831);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (53, 'Debitis voluptas sit fugit.', 'admin', 'Green', 'Crist', 28548294);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (54, 'Natus non harum quia.', 'admin', 'Millie', 'Mann', 56165364);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (55, 'Sequi molestiae enim illum.', 'treneris', 'Stuart', 'Kuphal', 19606484);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (56, 'Unde fuga nostrum ea sit.', 'admin', 'Barton', 'Walter', 71135601);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (57, 'Qui amet sit non.', 'treneris', 'Elliott', 'Hartmann', 86482820);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (58, 'Qui ea ut mollitia dolorum.', ' klientas', 'Omer', 'Little', 33113593);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (59, 'Ut laborum qui quis.', 'treneris', 'Noah', 'Thompson', 54327061);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (60, 'Esse qui occaecati et.', ' klientas', 'Jamey', 'Cronin', 39919847);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (61, 'Quo amet non nihil et enim.', ' klientas', 'Aiden', 'Ullrich', 3504789);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (62, 'Dolorem natus sed qui.', 'treneris', 'Efrain', 'Doyle', 32415032);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (63, 'Ab et voluptatem omnis non.', 'treneris', 'Clara', 'Collier', 54488014);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (64, 'Id provident quasi enim.', ' klientas', 'Leslie', 'Rempel', 8832986);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (65, 'Pariatur ut eum molestias.', 'treneris', 'Shany', 'Kuhn', 26044163);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (66, 'Eum eos in qui veritatis.', 'treneris', 'Iva', 'Jakubowski', 24198400);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (67, 'Deleniti qui et incidunt in.', ' klientas', 'Jerad', 'Renner', 69104619);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (68, 'Aspernatur eos vero sint.', ' klientas', 'Jimmy', 'Feeney', 83420627);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (69, 'Dolores facilis iure sed sit.', ' klientas', 'Alexandre', 'Orn', 37277239);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (70, 'Quia ut facere ut ut qui.', 'treneris', 'Alberta', 'Skiles', 53790118);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (71, 'Voluptate a dolorem facilis.', 'treneris', 'Maegan', 'Rolfson', 34367360);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (72, 'Quis et soluta officia a.', 'admin', 'Constance', 'McClure', 85442511);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (73, 'Dolores hic temporibus et.', 'treneris', 'Roxane', 'Nikolaus', 94559040);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (74, 'Eos sit ut laborum iure.', 'admin', 'Heath', 'Sipes', 74695287);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (75, 'Doloribus et cupiditate ut.', ' klientas', 'Adelia', 'Bartoletti', 92277519);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (76, 'Nemo non qui harum iste.', 'admin', 'Edythe', 'Walter', 29220106);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (77, 'Nam quos sed alias error.', ' klientas', 'Rubie', 'Herman', 50146109);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (78, 'Quia provident cum nam quia.', 'treneris', 'Dylan', 'Mayert', 73498902);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (79, 'Non iure ipsam odit nulla.', 'admin', 'Wilburn', 'Kulas', 71562384);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (80, 'Natus consectetur amet qui.', ' klientas', 'Dee', 'Mante', 78442252);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (81, 'Quaerat optio dolor tempore.', 'admin', 'Amina', 'VonRueden', 17799171);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (82, 'Qui aut qui voluptas et.', 'admin', 'Iva', 'Dare', 34034842);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (83, 'Sed error ab illum quo.', 'admin', 'Maggie', 'Stracke', 40769066);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (84, 'Ad perspiciatis cumque qui.', 'admin', 'Abelardo', 'Stoltenberg', 39233431);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (85, 'A enim aut nihil et ipsam.', ' klientas', 'Lafayette', 'McKenzie', 98410514);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (86, 'Cumque ut iste expedita.', ' klientas', 'Andy', 'Robel', 86057400);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (87, 'Nulla sit est sit non quae.', 'admin', 'Demetrius', 'Sanford', 16470293);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (88, 'Ut consequatur sunt ullam.', ' klientas', 'Zora', 'Keebler', 86006262);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (89, 'Quisquam neque sunt et magni.', 'treneris', 'Abner', 'Russel', 54497054);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (90, 'Tenetur deserunt numquam est.', 'admin', 'Nathen', 'Kautzer', 10615461);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (91, 'Earum id nemo hic.', 'treneris', 'Ewald', 'Ward', 87674316);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (92, 'Rerum aspernatur quo fugit.', 'treneris', 'Frederique', 'Conroy', 7043550);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (93, 'Sit sed fugit suscipit.', 'admin', 'Daisy', 'Hodkiewicz', 33674056);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (94, 'Et at quis quos maiores.', 'treneris', 'Torey', 'Gibson', 47513631);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (95, 'Qui accusamus sed ad et.', 'treneris', 'Nannie', 'Conner', 71498973);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (96, 'Deleniti sit rem magnam est.', 'treneris', 'Cary', 'Conn', 92261808);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (97, 'Ut numquam modi itaque.', 'admin', 'Bridget', 'Wolff', 70564136);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (98, 'Quasi voluptatem ratione sit.', 'treneris', 'Troy', 'Terry', 68623692);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (99, 'Dolorum nam quo officia ipsa.', 'treneris', 'Maria', 'Connelly', 5662333);
INSERT INTO `Naudotojas` (`naudotojoID`, `slaptazodis`, `role`, `vardas`, `pavarde`, `asmensKodas`) VALUES (100, 'Nam corrupti odio illum.', ' klientas', 'Effie', 'Hane', 70704884);


INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (1, 48, 40);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (2, 23, 24);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (3, 9, 18);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (4, 10, 17);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (5, 46, 35);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (6, 9, 42);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (7, 17, 35);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (8, 11, 40);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (9, 7, 21);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (10, 18, 30);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (11, 5, 7);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (12, 26, 27);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (13, 46, 34);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (14, 30, 50);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (15, 33, 38);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (16, 19, 6);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (17, 38, 35);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (18, 45, 2);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (19, 40, 14);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (20, 33, 12);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (21, 37, 37);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (22, 6, 16);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (23, 11, 13);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (24, 5, 49);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (25, 27, 44);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (26, 19, 27);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (27, 31, 41);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (28, 11, 20);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (29, 18, 36);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (30, 38, 39);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (31, 40, 30);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (32, 24, 11);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (33, 39, 5);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (34, 19, 36);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (35, 15, 27);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (36, 37, 28);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (37, 4, 38);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (38, 44, 32);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (39, 3, 35);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (40, 47, 43);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (41, 40, 21);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (42, 42, 31);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (43, 19, 2);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (44, 13, 43);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (45, 40, 29);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (46, 47, 31);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (47, 19, 49);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (48, 13, 1);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (49, 5, 25);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (50, 10, 23);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (51, 12, 41);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (52, 31, 9);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (53, 2, 45);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (54, 43, 28);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (55, 20, 21);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (56, 1, 5);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (57, 23, 11);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (58, 43, 36);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (59, 19, 33);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (60, 16, 41);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (61, 38, 5);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (62, 35, 40);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (63, 14, 27);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (64, 36, 24);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (65, 13, 25);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (66, 9, 4);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (67, 16, 19);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (68, 44, 22);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (69, 44, 41);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (70, 43, 31);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (71, 16, 26);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (72, 12, 16);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (73, 30, 44);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (74, 19, 12);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (75, 29, 48);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (76, 20, 34);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (77, 26, 42);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (78, 44, 15);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (79, 2, 39);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (80, 33, 12);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (81, 15, 24);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (82, 47, 31);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (83, 22, 17);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (84, 13, 23);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (85, 13, 15);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (86, 50, 45);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (87, 40, 48);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (88, 27, 24);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (89, 42, 25);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (90, 41, 14);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (91, 12, 37);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (92, 10, 14);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (93, 30, 28);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (94, 26, 7);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (95, 48, 14);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (96, 46, 29);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (97, 17, 40);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (98, 17, 3);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (99, 49, 9);
INSERT INTO `Pratimas` (`pratimasID`, `pratimoInfoID`, `pratimoSpecifikacijaID`) VALUES (100, 28, 50);


INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (1, 'reiciendis', 'Veniam veritatis commodi velit.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (2, 'aliquid', 'Recusandae provident nulla aut in deleniti iusto ut.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (3, 'odit', 'Est placeat consequatur rerum esse illum voluptas.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (4, 'rerum', 'Voluptatibus et quae ea suscipit temporibus et.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (5, 'et', 'Dolor libero et earum temporibus.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (6, 'beatae', 'Sed aperiam ut numquam.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (7, 'officiis', 'Est nobis nam voluptatem sint ut.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (8, 'maxime', 'Eveniet ipsam et alias culpa rem alias.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (9, 'voluptatem', 'Placeat qui iure consequatur repellendus et dignissimos impedit.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (10, 'veniam', 'Autem qui a omnis.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (11, 'accusamus', 'Dolor assumenda quis velit.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (12, 'sit', 'Ipsa odio omnis in aut sed.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (13, 'voluptas', 'Incidunt vitae maiores optio consequuntur eum laudantium minus expedita.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (14, 'necessitatibus', 'Voluptatem aut voluptates sed rerum nisi quam.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (15, 'id', 'Cumque nemo perferendis et delectus voluptas.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (16, 'nam', 'Sed quam alias enim sit.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (17, 'consequatur', 'Amet quae ut nihil eligendi.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (18, 'ratione', 'Accusantium sequi provident aut sequi.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (19, 'officia', 'Maxime et rem numquam in qui ea suscipit.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (20, 'vero', 'Dolor accusantium aut nihil eos doloremque.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (21, 'inventore', 'Ab qui in ab accusamus autem adipisci.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (22, 'vitae', 'Qui reiciendis quia esse quis corrupti distinctio quis.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (23, 'vel', 'Ut aperiam debitis nostrum quas non saepe.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (24, 'error', 'Natus non impedit perferendis corporis voluptatem natus officia incidunt.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (25, 'impedit', 'Et explicabo qui ducimus iste ut.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (26, 'quam', 'Assumenda accusamus omnis aut aut.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (27, 'dolorum', 'Et iure voluptatibus non quasi.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (28, 'eveniet', 'In assumenda consectetur consectetur deleniti est.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (29, 'distinctio', 'Error ea laudantium illum optio atque.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (30, 'quis', 'Dolores asperiores qui illo aut eum.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (31, 'sequi', 'Temporibus non reprehenderit ad adipisci.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (32, 'laudantium', 'Laboriosam eos corporis qui consequatur molestiae et at.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (33, 'accusantium', 'Consequatur dolor ut molestiae excepturi ipsum et molestiae architecto.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (34, 'quam', 'Vero architecto minima et id beatae voluptatem eos.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (35, 'placeat', 'Inventore eum quo assumenda est.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (36, 'id', 'Omnis nostrum eaque voluptatibus fugiat consequatur ipsum quia.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (37, 'quia', 'Omnis consequatur repudiandae enim illo rerum rem ducimus.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (38, 'qui', 'Aut quod ut sunt quo aut officiis.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (39, 'minus', 'Dicta quas aliquam nihil dolor ut.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (40, 'similique', 'Quisquam fugit debitis quia aut in quis culpa.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (41, 'voluptates', 'Sint asperiores quas quis non voluptatem ea.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (42, 'vero', 'Odit repudiandae quis corporis dolorem.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (43, 'autem', 'Modi voluptas quia consectetur aperiam veniam et.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (44, 'mollitia', 'Voluptas sit alias nostrum sit voluptatem ea sed quia.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (45, 'ut', 'Assumenda eum animi vel molestiae at maiores.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (46, 'veritatis', 'Qui sit itaque reprehenderit deserunt voluptatem quos.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (47, 'labore', 'Nostrum dolores autem ea et.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (48, 'ipsum', 'Dolorum voluptatem adipisci et non.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (49, 'quae', 'Quam quia velit eum nesciunt molestiae veritatis.');
INSERT INTO `PratimoInformacija` (`pratimoInfoID`, `pavadinimas`, `instrukcija`) VALUES (50, 'harum', 'Odit quo quidem aut harum.');


INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (1, 15, 8, 3);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (2, 13, 9, 2);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (3, 13, 8, 1);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (4, 13, 9, 2);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (5, 5, 5, 1);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (6, 14, 9, 2);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (7, 10, 10, 2);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (8, 19, 4, 3);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (9, 12, 7, 2);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (10, 20, 7, 3);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (11, 14, 2, 3);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (12, 13, 5, 2);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (13, 14, 10, 1);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (14, 15, 2, 3);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (15, 20, 3, 3);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (16, 19, 6, 2);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (17, 19, 5, 3);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (18, 5, 6, 2);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (19, 10, 2, 2);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (20, 8, 5, 1);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (21, 11, 6, 2);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (22, 8, 5, 2);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (23, 8, 8, 1);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (24, 9, 5, 2);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (25, 18, 6, 3);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (26, 8, 9, 1);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (27, 16, 7, 3);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (28, 8, 4, 3);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (29, 18, 9, 1);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (30, 19, 10, 2);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (31, 9, 9, 2);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (32, 12, 8, 3);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (33, 19, 2, 1);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (34, 5, 4, 2);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (35, 13, 4, 3);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (36, 14, 7, 1);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (37, 8, 4, 1);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (38, 14, 7, 2);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (39, 7, 8, 2);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (40, 11, 4, 3);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (41, 9, 5, 2);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (42, 16, 4, 3);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (43, 12, 7, 1);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (44, 11, 9, 2);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (45, 4, 3, 3);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (46, 18, 2, 1);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (47, 8, 9, 3);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (48, 9, 2, 1);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (49, 7, 7, 1);
INSERT INTO `PratimoSpecifikacija` (`pratimoSpecifikacijaID`, `pakartojimai`, `serijos`, `poilsisTarpSeriju`) VALUES (50, 19, 2, 3);


INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (28, 2);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (10, 10);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (43, 27);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (39, 48);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (38, 35);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (34, 28);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (41, 41);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (48, 17);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (2, 40);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (30, 41);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (24, 45);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (18, 41);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (44, 19);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (13, 43);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (36, 16);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (12, 46);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (37, 32);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (41, 30);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (1, 33);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (42, 23);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (17, 43);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (22, 15);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (24, 38);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (16, 13);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (7, 43);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (47, 31);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (38, 41);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (49, 16);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (11, 15);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (15, 3);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (39, 24);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (16, 36);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (13, 40);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (8, 3);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (23, 8);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (44, 49);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (26, 49);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (27, 31);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (47, 37);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (9, 38);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (8, 9);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (16, 12);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (36, 4);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (43, 32);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (36, 27);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (46, 44);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (19, 21);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (5, 43);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (44, 29);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (47, 25);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (32, 19);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (11, 20);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (20, 23);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (38, 12);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (23, 22);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (6, 33);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (42, 38);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (19, 21);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (21, 49);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (34, 16);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (39, 50);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (19, 33);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (14, 11);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (7, 19);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (16, 26);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (4, 30);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (34, 44);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (14, 35);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (48, 21);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (42, 5);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (11, 16);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (48, 29);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (29, 43);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (3, 30);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (28, 9);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (2, 49);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (33, 40);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (26, 34);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (42, 33);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (20, 18);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (9, 21);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (10, 45);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (9, 26);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (2, 5);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (28, 18);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (42, 9);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (18, 36);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (44, 24);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (50, 49);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (1, 27);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (23, 43);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (16, 29);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (38, 4);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (16, 47);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (5, 25);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (26, 15);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (45, 18);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (48, 35);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (27, 32);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (32, 27);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (26, 33);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (16, 30);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (17, 45);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (29, 22);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (41, 30);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (13, 25);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (7, 29);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (1, 46);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (36, 28);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (13, 18);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (14, 44);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (21, 6);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (47, 6);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (45, 34);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (45, 11);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (39, 5);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (30, 4);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (14, 28);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (18, 40);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (18, 38);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (28, 36);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (27, 48);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (14, 38);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (39, 13);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (46, 35);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (36, 49);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (3, 12);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (37, 22);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (19, 16);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (43, 1);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (17, 20);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (16, 30);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (39, 9);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (30, 29);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (20, 13);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (20, 10);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (8, 35);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (45, 35);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (50, 42);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (27, 36);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (12, 4);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (14, 11);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (44, 47);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (8, 39);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (41, 8);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (9, 49);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (21, 19);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (44, 31);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (26, 14);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (17, 35);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (42, 28);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (12, 44);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (2, 47);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (45, 28);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (11, 7);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (38, 41);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (25, 20);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (26, 42);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (43, 28);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (3, 40);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (3, 31);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (39, 4);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (50, 10);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (45, 20);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (13, 19);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (25, 7);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (17, 28);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (35, 48);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (42, 13);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (24, 46);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (13, 22);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (36, 39);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (18, 1);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (15, 50);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (40, 7);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (9, 20);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (13, 3);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (43, 16);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (2, 35);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (26, 14);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (28, 48);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (39, 50);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (42, 40);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (50, 2);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (45, 50);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (37, 41);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (1, 3);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (7, 35);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (16, 1);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (39, 43);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (1, 17);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (3, 7);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (13, 5);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (26, 18);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (4, 41);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (26, 40);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (19, 27);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (12, 39);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (45, 13);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (19, 27);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (4, 33);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (1, 1);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (28, 26);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (2, 23);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (8, 39);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (13, 26);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (14, 45);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (2, 36);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (17, 13);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (32, 36);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (48, 2);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (12, 8);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (44, 28);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (42, 2);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (25, 34);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (3, 24);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (44, 25);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (29, 16);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (1, 23);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (46, 26);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (3, 24);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (19, 31);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (7, 20);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (36, 29);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (31, 29);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (38, 23);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (35, 38);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (28, 1);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (41, 5);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (20, 14);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (23, 8);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (38, 36);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (42, 22);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (17, 41);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (26, 13);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (41, 36);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (44, 44);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (28, 11);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (10, 50);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (34, 18);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (32, 40);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (47, 20);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (29, 40);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (44, 4);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (30, 20);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (7, 18);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (2, 6);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (27, 21);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (47, 11);
INSERT INTO `PratimuSarasas` (`treniruotesPlanoID`, `pratimasID`) VALUES (19, 35);


INSERT INTO `SportoKlubas` (`sportoKlubasID`, `pavadinimas`, `adresas`, `plotas`, `kontaktai`) VALUES (1, 'explicabo', '18229 Kelton Coves\nKohlerbury,', '885.00', ' +37065320000');
INSERT INTO `SportoKlubas` (`sportoKlubasID`, `pavadinimas`, `adresas`, `plotas`, `kontaktai`) VALUES (2, 'dolor', '6039 Conner Hill Suite 657\nH', '689.00', ' +37065320000');
INSERT INTO `SportoKlubas` (`sportoKlubasID`, `pavadinimas`, `adresas`, `plotas`, `kontaktai`) VALUES (3, 'ullam', '765 Schroeder Circles\nLoristad', '369.00', ' +37065320000');
INSERT INTO `SportoKlubas` (`sportoKlubasID`, `pavadinimas`, `adresas`, `plotas`, `kontaktai`) VALUES (4, 'neque', '1308 Heller Mews Apt. 133\nNew ', '897.00', ' +37065320000');
INSERT INTO `SportoKlubas` (`sportoKlubasID`, `pavadinimas`, `adresas`, `plotas`, `kontaktai`) VALUES (5, 'quia', '58066 Jerad Via Apt. 513\nJacob', '537.00', '+370654670000');


INSERT INTO `SportoKlubuSarasas` (`abonementoPlanasID`, `sportoKlubasID`) VALUES (3, 4);
INSERT INTO `SportoKlubuSarasas` (`abonementoPlanasID`, `sportoKlubasID`) VALUES (4, 2);
INSERT INTO `SportoKlubuSarasas` (`abonementoPlanasID`, `sportoKlubasID`) VALUES (4, 4);
INSERT INTO `SportoKlubuSarasas` (`abonementoPlanasID`, `sportoKlubasID`) VALUES (5, 5);
INSERT INTO `SportoKlubuSarasas` (`abonementoPlanasID`, `sportoKlubasID`) VALUES (2, 1);
INSERT INTO `SportoKlubuSarasas` (`abonementoPlanasID`, `sportoKlubasID`) VALUES (3, 3);
INSERT INTO `SportoKlubuSarasas` (`abonementoPlanasID`, `sportoKlubasID`) VALUES (6, 4);
INSERT INTO `SportoKlubuSarasas` (`abonementoPlanasID`, `sportoKlubasID`) VALUES (6, 2);
INSERT INTO `SportoKlubuSarasas` (`abonementoPlanasID`, `sportoKlubasID`) VALUES (4, 5);
INSERT INTO `SportoKlubuSarasas` (`abonementoPlanasID`, `sportoKlubasID`) VALUES (5, 2);
INSERT INTO `SportoKlubuSarasas` (`abonementoPlanasID`, `sportoKlubasID`) VALUES (2, 3);
INSERT INTO `SportoKlubuSarasas` (`abonementoPlanasID`, `sportoKlubasID`) VALUES (1, 4);
INSERT INTO `SportoKlubuSarasas` (`abonementoPlanasID`, `sportoKlubasID`) VALUES (1, 3);
INSERT INTO `SportoKlubuSarasas` (`abonementoPlanasID`, `sportoKlubasID`) VALUES (2, 3);
INSERT INTO `SportoKlubuSarasas` (`abonementoPlanasID`, `sportoKlubasID`) VALUES (6, 1);
INSERT INTO `SportoKlubuSarasas` (`abonementoPlanasID`, `sportoKlubasID`) VALUES (1, 4);
INSERT INTO `SportoKlubuSarasas` (`abonementoPlanasID`, `sportoKlubasID`) VALUES (6, 4);
INSERT INTO `SportoKlubuSarasas` (`abonementoPlanasID`, `sportoKlubasID`) VALUES (2, 2);
INSERT INTO `SportoKlubuSarasas` (`abonementoPlanasID`, `sportoKlubasID`) VALUES (4, 4);
INSERT INTO `SportoKlubuSarasas` (`abonementoPlanasID`, `sportoKlubasID`) VALUES (3, 4);


INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (1, 1, '0000-00-00', 'Maiores ut eveniet eos magnam reprehenderit illum iure. Sequi qui perspiciatis quia similique. Adipisci voluptates dolore ab nam quis.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (2, 2, '0000-00-00', 'Est ipsum minus numquam qui sint quasi voluptatum. Temporibus et nihil dolorum vel. Nisi quo repellat enim.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (3, 3, '0000-00-00', 'Soluta ut eos eveniet rerum saepe. Fuga blanditiis expedita dolor minus impedit et aut.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (4, 4, '0000-00-00', 'Nemo nihil voluptatem quo ut enim non aut. Voluptas dolores quia esse quas et dolores. Atque eius enim eum fugit porro.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (5, 5, '0000-00-00', 'Fugiat ut repellendus id ut. Nobis voluptatem quam consequatur sed placeat et.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (6, 6, '0000-00-00', 'Ut amet eos possimus. Quae voluptatum eligendi est quaerat sit impedit.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (7, 7, '0000-00-00', 'Et consequatur nam deserunt ipsum enim quo deleniti magnam. Eos pariatur ea et dolorem labore.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (8, 8, '0000-00-00', 'Dolorem dolorum perspiciatis et id. Nobis impedit qui quibusdam et eum molestias itaque. Laudantium ipsam doloremque ut dolores.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (9, 9, '0000-00-00', 'Pariatur quibusdam ducimus minus sed aut blanditiis quia voluptas. Et et ut modi accusantium omnis similique quibusdam.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (10, 10, '0000-00-00', 'Accusamus illo sed non sint aut error harum. Qui libero maiores non quis.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (11, 1, '0000-00-00', 'Tenetur magni necessitatibus ut sunt quisquam voluptatem ipsam. Atque recusandae quia ut illo expedita vero. Quis cupiditate tenetur incidunt voluptates.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (12, 2, '0000-00-00', 'Velit est debitis quia est molestiae aut. Cumque qui magni inventore. Sint excepturi est neque et expedita dicta.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (13, 3, '0000-00-00', 'Est mollitia dolorem est ratione quo ab inventore. Sed velit a totam dolorum perferendis. Soluta quo eveniet facere officia rem sint sint.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (14, 4, '0000-00-00', 'Voluptate qui optio quisquam consectetur minima placeat voluptatem enim. Velit recusandae occaecati earum adipisci dolor. Et nihil ex quisquam voluptate consequatur veritatis.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (15, 5, '0000-00-00', 'Voluptate omnis totam accusamus cum. Eos ut est maiores accusamus.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (16, 6, '0000-00-00', 'Voluptas dolorem ducimus nesciunt qui. Maxime labore repudiandae molestiae distinctio doloribus atque. Alias voluptate qui ipsa excepturi et.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (17, 7, '0000-00-00', 'Autem alias qui accusamus nisi sunt. Illo velit soluta eaque libero assumenda. Libero doloribus molestiae et.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (18, 8, '0000-00-00', 'Asperiores earum est in. Et rem magnam aliquid excepturi. Eius voluptatem doloribus dignissimos placeat.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (19, 9, '0000-00-00', 'Et dolor et et veniam qui nihil voluptatem. Est voluptatem sapiente aliquam ut atque animi. Ratione rerum eum nemo est.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (20, 10, '0000-00-00', 'Et enim eaque nihil nihil quisquam rerum cumque. In aperiam qui ipsum et.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (21, 1, '0000-00-00', 'Provident distinctio dolorum non culpa. Est quae vero cum voluptas non tempore.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (22, 2, '0000-00-00', 'Consequuntur est est debitis veritatis corrupti quae rem. Quasi quo quae fuga error et dolorum libero.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (23, 3, '0000-00-00', 'Eum mollitia est corporis aut. Nam eligendi facilis pariatur repellat aliquid ut. Quia alias qui quia necessitatibus quod amet incidunt.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (24, 4, '0000-00-00', 'Doloremque quod soluta velit. Aut dolorum quia iste sunt ad quos nesciunt.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (25, 5, '0000-00-00', 'Voluptatem ut quas optio voluptates aut rerum minima. Soluta nam quis autem fuga. Qui dolorem nemo deserunt optio nam.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (26, 6, '0000-00-00', 'Iste rerum accusamus quasi similique. Maxime suscipit doloremque et. Ea explicabo velit pariatur voluptate voluptatem et.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (27, 7, '0000-00-00', 'Voluptatem provident voluptates cupiditate corporis. Dolor corrupti qui vel in quos cum autem. Ut perspiciatis ullam maxime quia voluptatem.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (28, 8, '0000-00-00', 'Facilis mollitia et sed neque. Mollitia autem consequuntur beatae saepe optio.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (29, 9, '0000-00-00', 'Ut et est dolorem corrupti nihil voluptatem nobis. Neque consequuntur error est qui quos.');
INSERT INTO `SportoPlanas` (`sportoPlanasID`, `sudaresTrenerisID`, `laikotarpis`, `instrukcija`) VALUES (30, 10, '0000-00-00', 'Voluptatem sint laboriosam asperiores deleniti. Eligendi sunt sint consequuntur neque sunt perspiciatis est. Odit quia quis quibusdam quae id illum vero eligendi.');


INSERT INTO `SportoZona` (`sportoZonaID`, `sportoKlubasID`, `plotas`) VALUES (1, 1, '156.00');
INSERT INTO `SportoZona` (`sportoZonaID`, `sportoKlubasID`, `plotas`) VALUES (2, 2, '284.00');
INSERT INTO `SportoZona` (`sportoZonaID`, `sportoKlubasID`, `plotas`) VALUES (3, 3, '232.00');
INSERT INTO `SportoZona` (`sportoZonaID`, `sportoKlubasID`, `plotas`) VALUES (4, 4, '120.00');
INSERT INTO `SportoZona` (`sportoZonaID`, `sportoKlubasID`, `plotas`) VALUES (5, 5, '295.00');
INSERT INTO `SportoZona` (`sportoZonaID`, `sportoKlubasID`, `plotas`) VALUES (6, 1, '281.00');
INSERT INTO `SportoZona` (`sportoZonaID`, `sportoKlubasID`, `plotas`) VALUES (7, 2, '209.00');
INSERT INTO `SportoZona` (`sportoZonaID`, `sportoKlubasID`, `plotas`) VALUES (8, 3, '236.00');
INSERT INTO `SportoZona` (`sportoZonaID`, `sportoKlubasID`, `plotas`) VALUES (9, 4, '262.00');
INSERT INTO `SportoZona` (`sportoZonaID`, `sportoKlubasID`, `plotas`) VALUES (10, 5, '112.00');
INSERT INTO `SportoZona` (`sportoZonaID`, `sportoKlubasID`, `plotas`) VALUES (11, 1, '298.00');
INSERT INTO `SportoZona` (`sportoZonaID`, `sportoKlubasID`, `plotas`) VALUES (12, 2, '273.00');
INSERT INTO `SportoZona` (`sportoZonaID`, `sportoKlubasID`, `plotas`) VALUES (13, 3, '110.00');
INSERT INTO `SportoZona` (`sportoZonaID`, `sportoKlubasID`, `plotas`) VALUES (14, 4, '290.00');
INSERT INTO `SportoZona` (`sportoZonaID`, `sportoKlubasID`, `plotas`) VALUES (15, 5, '128.00');


INSERT INTO `Treneris` (`trenerioID`, `naudotojoID`, `issilavinimas`, `darboStazas`) VALUES (1, 1, ' universitetinis', 3);
INSERT INTO `Treneris` (`trenerioID`, `naudotojoID`, `issilavinimas`, `darboStazas`) VALUES (2, 2, 'profesinis', 9);
INSERT INTO `Treneris` (`trenerioID`, `naudotojoID`, `issilavinimas`, `darboStazas`) VALUES (3, 7, 'profesinis', 15);
INSERT INTO `Treneris` (`trenerioID`, `naudotojoID`, `issilavinimas`, `darboStazas`) VALUES (4, 9, ' kolegijinis', 9);
INSERT INTO `Treneris` (`trenerioID`, `naudotojoID`, `issilavinimas`, `darboStazas`) VALUES (5, 10, 'profesinis', 11);
INSERT INTO `Treneris` (`trenerioID`, `naudotojoID`, `issilavinimas`, `darboStazas`) VALUES (6, 14, ' universitetinis', 5);
INSERT INTO `Treneris` (`trenerioID`, `naudotojoID`, `issilavinimas`, `darboStazas`) VALUES (7, 20, 'profesinis', 5);
INSERT INTO `Treneris` (`trenerioID`, `naudotojoID`, `issilavinimas`, `darboStazas`) VALUES (8, 22, ' universitetinis', 5);
INSERT INTO `Treneris` (`trenerioID`, `naudotojoID`, `issilavinimas`, `darboStazas`) VALUES (9, 23, ' universitetinis', 10);
INSERT INTO `Treneris` (`trenerioID`, `naudotojoID`, `issilavinimas`, `darboStazas`) VALUES (10, 25, ' kolegijinis', 15);


INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (15, 42);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (18, 41);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (13, 43);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (21, 13);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (5, 10);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (7, 1);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (1, 40);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (28, 31);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (12, 2);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (28, 19);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (8, 23);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (24, 25);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (10, 12);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (27, 29);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (9, 4);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (29, 8);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (21, 23);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (10, 11);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (24, 6);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (16, 24);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (22, 35);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (27, 47);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (30, 21);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (29, 8);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (20, 29);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (25, 43);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (1, 4);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (6, 50);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (18, 48);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (21, 35);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (15, 45);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (17, 44);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (21, 8);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (30, 14);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (10, 36);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (7, 29);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (30, 18);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (25, 43);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (23, 18);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (1, 49);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (9, 49);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (9, 49);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (12, 49);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (3, 49);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (5, 14);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (6, 17);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (7, 27);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (25, 2);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (7, 31);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (19, 5);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (29, 8);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (24, 4);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (8, 4);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (28, 31);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (15, 19);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (13, 40);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (20, 17);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (27, 11);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (29, 43);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (17, 4);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (10, 3);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (1, 2);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (24, 43);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (7, 10);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (8, 27);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (25, 49);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (19, 11);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (22, 29);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (1, 44);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (8, 16);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (26, 12);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (30, 29);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (8, 13);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (14, 27);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (1, 8);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (19, 47);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (12, 14);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (30, 35);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (5, 20);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (24, 9);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (19, 9);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (15, 16);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (9, 44);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (23, 26);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (25, 7);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (15, 1);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (25, 26);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (24, 19);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (18, 43);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (1, 18);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (24, 46);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (1, 19);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (3, 25);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (17, 26);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (13, 9);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (17, 42);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (19, 46);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (30, 37);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (26, 6);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (7, 48);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (18, 18);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (9, 41);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (24, 33);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (8, 19);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (14, 28);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (3, 38);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (12, 11);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (9, 34);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (10, 13);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (16, 25);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (11, 33);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (30, 22);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (11, 9);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (10, 48);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (9, 1);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (12, 7);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (26, 20);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (3, 46);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (17, 7);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (15, 13);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (3, 40);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (18, 2);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (27, 1);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (28, 15);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (4, 2);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (8, 25);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (24, 4);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (16, 43);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (23, 13);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (18, 10);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (2, 50);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (6, 31);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (7, 24);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (26, 26);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (20, 1);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (17, 43);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (12, 10);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (30, 35);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (8, 3);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (27, 40);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (1, 27);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (24, 47);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (4, 27);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (22, 33);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (8, 31);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (14, 19);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (12, 44);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (16, 50);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (14, 29);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (18, 13);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (18, 17);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (15, 4);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (16, 37);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (26, 18);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (18, 28);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (1, 2);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (12, 17);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (16, 12);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (24, 49);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (25, 41);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (6, 2);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (5, 17);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (20, 21);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (25, 42);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (4, 25);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (24, 16);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (1, 44);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (9, 12);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (2, 31);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (6, 15);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (18, 19);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (8, 5);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (10, 2);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (27, 49);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (12, 26);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (22, 34);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (21, 39);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (16, 23);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (12, 28);
INSERT INTO `TreniruociuSarasas` (`sportoPlanasID`, `treniruotesPlanoID`) VALUES (5, 32);


INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (1, 2, ' lankstumo', 5, 'Soluta in corporis a omnis temporibus quis et ipsam sequi commodi ut voluptatum in.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (2, 7, ' jegos', 7, 'Molestiae dolores sapiente itaque ut quis atque corrupti amet praesentium ipsum assumenda temporibus.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (3, 10, 'istvermes', 5, 'Dolores sed autem dignissimos praesentium optio sint ullam in corrupti blanditiis aspernatur quisquam.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (4, 15, ' lankstumo', 6, 'Ut repellendus voluptatem qui mollitia deserunt labore aut aut reprehenderit sint eos minima.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (5, 10, ' pusiausvyros', 6, 'Omnis optio optio possimus magnam consequatur omnis totam dicta mollitia ratione nemo.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (6, 3, ' lankstumo', 2, 'Pariatur est id debitis et dolorem similique quia quo maiores non perferendis quod esse.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (7, 8, ' jegos', 1, 'Provident vero ut quos ipsum itaque recusandae ut quaerat praesentium provident nihil in.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (8, 12, 'istvermes', 4, 'Est ut quod vel et qui nostrum saepe culpa omnis eius error.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (9, 10, ' jegos', 6, 'Modi eaque aut nesciunt dignissimos repellendus ut blanditiis necessitatibus omnis nihil exercitationem atque cumque.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (10, 12, ' jegos', 5, 'Ratione voluptas accusamus tempora et libero aut unde consequuntur tempore eos cum dolorem.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (11, 1, ' pusiausvyros', 5, 'Occaecati nihil et quidem consequatur iure aperiam explicabo unde laborum rerum illum.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (12, 12, 'istvermes', 1, 'Sit dignissimos voluptates aut sapiente illum esse occaecati illum est.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (13, 1, 'istvermes', 3, 'Nesciunt quibusdam distinctio sed quo ut amet nostrum vero rem aut magnam iste.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (14, 1, ' pusiausvyros', 6, 'Qui ipsam qui minima nostrum et facere est molestiae cumque incidunt consequatur.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (15, 13, 'istvermes', 6, 'Voluptates eos aliquam officia quia aspernatur qui cumque quia.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (16, 15, 'istvermes', 7, 'At unde in optio quis voluptas molestiae et incidunt possimus inventore eum et.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (17, 5, 'istvermes', 7, 'Et delectus nostrum iusto velit quidem voluptatem.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (18, 8, 'istvermes', 3, 'Autem qui nihil iure incidunt voluptatum quia expedita sed quos cupiditate magni excepturi.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (19, 1, ' lankstumo', 2, 'Eum expedita voluptates unde error fuga optio quos.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (20, 7, ' pusiausvyros', 1, 'Cum aut et quas quo exercitationem consequuntur enim dolores cumque voluptatem.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (21, 5, ' lankstumo', 4, 'Illum sit ea voluptas quod minima totam voluptatem hic soluta veritatis consequatur et.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (22, 5, ' pusiausvyros', 2, 'Explicabo nihil ratione vel qui quam cupiditate omnis.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (23, 8, 'istvermes', 2, 'Sit pariatur expedita numquam distinctio reprehenderit laboriosam.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (24, 4, ' pusiausvyros', 4, 'Enim placeat eligendi non architecto deserunt aut.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (25, 12, 'istvermes', 4, 'Qui dolorem necessitatibus debitis et saepe occaecati esse officiis neque accusantium et reiciendis.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (26, 15, ' lankstumo', 1, 'Est accusamus nemo laborum est atque vel qui iure laboriosam soluta pariatur dolores.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (27, 14, ' lankstumo', 2, 'Amet qui corrupti id vitae earum omnis voluptates nihil.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (28, 12, ' lankstumo', 4, 'Aut consequatur labore ut explicabo et amet.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (29, 14, ' jegos', 1, 'Rerum eaque dolor ducimus facere aspernatur quia impedit est.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (30, 3, ' jegos', 2, 'Eaque eveniet minima voluptatem aut ut sunt molestiae autem consequatur.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (31, 10, ' pusiausvyros', 2, 'Cum hic tempore molestias est rem animi aut placeat quos.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (32, 11, 'istvermes', 4, 'Dignissimos expedita ea tempore labore est aut error iure suscipit ut adipisci ea quia.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (33, 5, ' lankstumo', 4, 'Neque voluptatem suscipit sequi maxime est ipsum aut possimus et quod nisi sit qui.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (34, 11, ' jegos', 1, 'Ab sunt quibusdam fugit quis aut alias.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (35, 7, 'istvermes', 4, 'In corrupti qui facilis eos minima soluta.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (36, 3, 'istvermes', 5, 'Reprehenderit quas sed a ab quia aut aut.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (37, 9, ' lankstumo', 7, 'Similique odit eos quis vero soluta at nisi voluptas.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (38, 12, 'istvermes', 6, 'Et minus omnis molestiae molestiae enim perferendis doloribus et dolor quia.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (39, 11, ' lankstumo', 1, 'Voluptas et quaerat debitis minus veritatis consequatur architecto.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (40, 12, ' lankstumo', 7, 'Unde ratione quia odio reprehenderit perspiciatis magnam.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (41, 5, ' pusiausvyros', 1, 'Sunt exercitationem illum consequuntur molestiae praesentium voluptatem beatae nulla placeat odio.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (42, 1, 'istvermes', 1, 'Sit ipsum minima accusantium similique placeat inventore architecto ipsum id qui id odio sed.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (43, 13, 'istvermes', 4, 'Occaecati eius adipisci ipsam ea cupiditate quasi sit consequatur culpa quia consequatur itaque similique.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (44, 9, ' jegos', 7, 'Adipisci dolor dolore numquam in voluptatem soluta vel amet odio commodi.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (45, 7, 'istvermes', 3, 'Sit itaque maxime alias ut omnis illum non et saepe.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (46, 10, ' pusiausvyros', 7, 'A et magnam vel eum blanditiis in eaque possimus mollitia dolore fuga vitae.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (47, 15, 'istvermes', 2, 'In quia cumque laudantium velit rerum in laborum neque et qui dolorum.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (48, 8, ' jegos', 2, 'Ea neque ab aliquid ut quos eligendi fugit corporis iste qui pariatur nemo aut.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (49, 6, 'istvermes', 1, 'Facilis hic iste rem modi neque velit illo molestiae libero dolor nemo.');
INSERT INTO `TreniruotesPlanas` (`treniruotesPlanoID`, `sportoZonaID`, `treniruotesTipas`, `dienosNumeris`, `aprasas`) VALUES (50, 3, ' lankstumo', 4, 'Velit aut accusantium aliquam voluptatum dolores non reprehenderit porro corrupti.');