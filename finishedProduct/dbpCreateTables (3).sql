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
    naudotojoID NUMBER PRIMARY KEY,
    slaptazodis VARCHAR2(30) NOT NULL,
    role VARCHAR2(30) NOT NULL,
    vardas VARCHAR2(30) NOT NULL,
    pavarde VARCHAR2(30) NOT NULL,
    asmensKodas NUMBER(11) NOT NULL
);

CREATE TABLE SportoKlubas (
    sportoKlubasID NUMBER PRIMARY KEY,
    pavadinimas VARCHAR2(30) NOT NULL,
    adresas VARCHAR2(30) NOT NULL,
    plotas NUMBER(6,2) NOT NULL,
    kontaktai CLOB NOT NULL
);

CREATE TABLE SportoPlanas (
    sportoPlanasID NUMBER PRIMARY KEY,
    sudaresTrenerisID NUMBER NOT NULL,
    laikotarpis VARCHAR2(100) NOT NULL,
    instrukcija CLOB NOT NULL
);

CREATE TABLE SportoZona (
    sportoZonaID NUMBER PRIMARY KEY,
    sportoKlubasID NUMBER NOT NULL,
    plotas NUMBER(6,2) NOT NULL
);

CREATE TABLE Treneris (
    trenerioID NUMBER PRIMARY KEY,
    naudotojoID NUMBER NOT NULL,
    issilavinimas VARCHAR2(30) NOT NULL,
    darboStazas NUMBER(3) NOT NULL
);

CREATE TABLE Abonementas (
    abonementasID NUMBER PRIMARY KEY,
    abonementoPlanasID NUMBER NOT NULL,
    galiojimoPradzia DATE NOT NULL,
    galiojimoPabaiga DATE NOT NULL
);

CREATE TABLE TreniruotesPlanas (
    treniruotesPlanoID NUMBER PRIMARY KEY,
    sportoZonaID NUMBER NOT NULL,
    treniruotesTipas VARCHAR2(30) NOT NULL,
    dienosNumeris NUMBER(2) NOT NULL,
    aprasas CLOB NOT NULL
);

CREATE TABLE MitybosPlanas (
    mitybosPlanasID NUMBER PRIMARY KEY,
    sudaresTrenerisID NUMBER NOT NULL,
    laikotarpis DATE NOT NULL,
    kalorijosPerDiena NUMBER(5) NOT NULL,
    dienosAngliavandeniai NUMBER(5) NOT NULL,
    dienosRiebalai NUMBER(5) NOT NULL,
    dienosBaltymai NUMBER(5) NOT NULL,
    dienosVandensKiekis FLOAT(2) NOT NULL,
    instrukcija CLOB NOT NULL
);

CREATE TABLE Iranga (
    irangaID NUMBER PRIMARY KEY,
    tipas VARCHAR2(30) NOT NULL,
    gamintojas VARCHAR2(30) NOT NULL,
    verte NUMBER(10) NOT NULL,
    aprasas CLOB NOT NULL
);

CREATE TABLE PratimoInformacija (
    pratimoInfoID NUMBER PRIMARY KEY,
    pavadinimas VARCHAR2(30) NOT NULL,
    instrukcija VARCHAR2(100) NOT NULL
);

CREATE TABLE PratimoSpecifikacija (
    pratimoSpecifikacijaID NUMBER PRIMARY KEY,
    pakartojimai NUMBER(5) NOT NULL,
    serijos NUMBER(5) NOT NULL,
    poilsisTarpSeriju NUMBER(5) NOT NULL
);

CREATE TABLE Pratimas (
    pratimasID NUMBER PRIMARY KEY,
    pratimoInfoID NUMBER NOT NULL,
    pratimoSpecifikacijaID NUMBER NOT NULL
);

CREATE TABLE TreniruociuSarasas (
    sportoPlanasID NUMBER NOT NULL,
    treniruotesPlanoID NUMBER NOT NULL
);

CREATE TABLE PratimuSarasas (
    treniruotesPlanoID NUMBER NOT NULL,
    pratimasID NUMBER NOT NULL
);

CREATE TABLE AbonementoPlanas (
    abonementoPlanasID NUMBER PRIMARY KEY,
    kaina NUMBER(10,2) NOT NULL,
    arTerminuota NUMBER(1) NOT NULL,
    privalumai CLOB NOT NULL
);

CREATE TABLE SportoKlubuSarasas (
    abonementoPlanasID NUMBER NOT NULL,
    sportoKlubasID NUMBER NOT NULL
);

CREATE TABLE Klientas (
    klientoID NUMBER PRIMARY KEY,
    naudotojoID NUMBER NOT NULL,
    sportoPlanasID NUMBER NOT NULL,
    mitybosPlanasID NUMBER NOT NULL,
    abonementasID NUMBER NOT NULL,
    ugis VARCHAR2(5) NOT NULL,
    svoris VARCHAR2(5) NOT NULL
);

CREATE TABLE IndividualiTreniruote (
    klientoID NUMBER NOT NULL,
    trenerioID NUMBER NOT NULL,
    treniruotesPlanoID NUMBER NOT NULL
);

CREATE TABLE Inventorius (
    irangaID NUMBER NOT NULL,
    sportoZonaID NUMBER NOT NULL
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

