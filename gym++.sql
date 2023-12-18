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
    naudotojoID NUMBER(8) NOT NULL PRIMARY KEY,
    slaptazodis VARCHAR2(30) NOT NULL,
    role VARCHAR2(30) NOT NULL,
    vardas VARCHAR2(30) NOT NULL,
    pavarde VARCHAR2(30) NOT NULL,
    asmensKodas NUMBER(10) NOT NULL
);

CREATE TABLE SportoKlubas (
    sportoKlubasID NUMBER(8) NOT NULL PRIMARY KEY,
    pavadinimas VARCHAR2(30) NOT NULL,
    adresas VARCHAR2(30) NOT NULL,
    plotas NUMBER(6,2) NOT NULL,
    kontaktai CLOB NOT NULL
);

CREATE TABLE SportoPlanas (
    sportoPlanasID NUMBER(8) NOT NULL PRIMARY KEY,
    sudaresTrenerisID NUMBER(8) NOT NULL,
    laikotarpis DATE NOT NULL,
    instrukcija CLOB NOT NULL
);

CREATE TABLE SportoZona (
    sportoZonaID NUMBER(8) NOT NULL PRIMARY KEY,
    sportoKlubasID NUMBER(8) NOT NULL,
    plotas NUMBER(6,2) NOT NULL
);

CREATE TABLE Treneris (
    trenerioID NUMBER(8) NOT NULL PRIMARY KEY,
    naudotojoID NUMBER(8) NOT NULL,
    issilavinimas VARCHAR2(30) NOT NULL,
    darboStazas NUMBER(3) NOT NULL
);

CREATE TABLE Abonementas (
    abonementasID NUMBER(8) PRIMARY KEY,
    abonementoPlanasID NUMBER(8) NOT NULL,
    galiojimoPradzia DATE NOT NULL,
    galiojimoPabaiga DATE NOT NULL
);

CREATE TABLE TreniruotesPlanas (
    treniruotesPlanoID NUMBER(8) PRIMARY KEY,
    sportoZonaID NUMBER(8) NOT NULL,
    treniruotesTipas VARCHAR2(30) NOT NULL,
    dienosNumeris NUMBER(2) NOT NULL,
    aprasas CLOB NOT NULL
);

CREATE TABLE MitybosPlanas (
    mitybosPlanasID NUMBER(8) NOT NULL PRIMARY KEY,
    sudaresTrenerisID NUMBER(8) NOT NULL,
    laikotarpis DATE NOT NULL,
    kalorijosPerDiena NUMBER(5) NOT NULL,
    dienosAngliavandeniai NUMBER(5) NOT NULL,
    dienosRiebalai NUMBER(5) NOT NULL,
    dienosBaltymai NUMBER(5) NOT NULL,
    dienosVandensKiekis FLOAT(2) NOT NULL,
    instrukcija CLOB NOT NULL
);

CREATE TABLE Iranga (
    irangaID NUMBER(8) NOT NULL PRIMARY KEY,
    tipas VARCHAR2(30) NOT NULL,
    gamintojas VARCHAR2(30) NOT NULL,
    verte NUMBER(10) NOT NULL,
    aprasas CLOB NOT NULL
);

CREATE TABLE PratimoInformacija (
    pratimoInfoID NUMBER(8) NOT NULL PRIMARY KEY,
    pavadinimas VARCHAR2(30) NOT NULL,
    instrukcija VARCHAR2(100) NOT NULL
);

CREATE TABLE PratimoSpecifikacija (
    pratimoSpecifikacijaID NUMBER(8) NOT NULL PRIMARY KEY,
    pakartojimai NUMBER(5) NOT NULL,
    serijos NUMBER(5) NOT NULL,
    poilsisTarpSeriju NUMBER(5) NOT NULL
);

CREATE TABLE Pratimas (
    pratimasID NUMBER(8) NOT NULL PRIMARY KEY,
    pratimoInfoID NUMBER(8) NOT NULL,
    pratimoSpecifikacijaID NUMBER(8) NOT NULL
);

CREATE TABLE TreniruociuSarasas (
    sportoPlanasID NUMBER(8) NOT NULL,
    treniruotesPlanoID NUMBER(8) NOT NULL
);

CREATE TABLE PratimuSarasas (
    treniruotesPlanoID NUMBER(8) NOT NULL,
    pratimasID NUMBER(8) NOT NULL
);

CREATE TABLE AbonementoPlanas (
    abonementoPlanasID NUMBER(8) PRIMARY KEY,
    kaina NUMBER(10,2) NOT NULL,
    arTerminuota NUMBER(1) NOT NULL,
    privalumai CLOB NOT NULL
);

CREATE TABLE SportoKlubuSarasas (
    abonementoPlanasID NUMBER(8) NOT NULL,
    sportoKlubasID NUMBER(8) NOT NULL
);

CREATE TABLE Klientas (
    klientoID NUMBER(8) NOT NULL PRIMARY KEY,
    naudotojoID NUMBER(8) NOT NULL,
    sportoPlanasID NUMBER(8) NOT NULL,
    mitybosPlanasID NUMBER(8) NOT NULL,
    abonementasID NUMBER(8) NOT NULL
);

CREATE TABLE IndividualiTreniruote (
    klientoID NUMBER(8) NOT NULL,
    trenerioID NUMBER(8) NOT NULL,
    treniruotesPlanoID NUMBER(8) NOT NULL
);

CREATE TABLE Inventorius (
    irangaID NUMBER(8) NOT NULL,
    sportoZonaID NUMBER(8) NOT NULL
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


