
INSERT INTO AbonementoPlanas (abonementoPlanasID, kaina, arTerminuota, privalumai) VALUES (1, '20.00', 0, 'Sit fugit dolorem id magnam.');
INSERT INTO AbonementoPlanas (abonementoPlanasID, kaina, arTerminuota, privalumai) VALUES (2, '0.00', 1, 'Eum beatae modi odit cumque blanditiis ut.');
INSERT INTO AbonementoPlanas (abonementoPlanasID, kaina, arTerminuota, privalumai) VALUES (3, '8.00', 1, 'Asperiores fuga consequatur sit totam totam et.');


INSERT INTO Abonementas (abonementasID, abonementoPlanasID, galiojimoPradzia, galiojimoPabaiga) VALUES (1, 1, TO_DATE('2001-08-02', 'YYYY-MM-DD'), TO_DATE('1982-10-22', 'YYYY-MM-DD'));
INSERT INTO Abonementas (abonementasID, abonementoPlanasID, galiojimoPradzia, galiojimoPabaiga) VALUES (2, 2, TO_DATE('1981-04-26', 'YYYY-MM-DD'), TO_DATE('2018-11-11', 'YYYY-MM-DD'));
INSERT INTO Abonementas (abonementasID, abonementoPlanasID, galiojimoPradzia, galiojimoPabaiga) VALUES (3, 3, TO_DATE('1976-12-07', 'YYYY-MM-DD'), TO_DATE('1989-04-16', 'YYYY-MM-DD'));

INSERT INTO Iranga (irangaID, tipas, gamintojas, verte, aprasas) VALUES (1, 'Cardio', 'Alfreda', 1761, 'Reprehenderit ea quia molestiae et qui.');
INSERT INTO Iranga (irangaID, tipas, gamintojas, verte, aprasas) VALUES (2, ' Svoriai', 'Rae', 4742, 'Similique et quisquam in nobis.');
INSERT INTO Iranga (irangaID, tipas, gamintojas, verte, aprasas) VALUES (3, ' Svoriai', 'Millie', 9939, 'Ut dicta possimus quos eveniet enim rerum.');

INSERT INTO Naudotojas (naudotojoID, slaptazodis, role, vardas, pavarde, asmensKodas) VALUES (1, '6170438', 'admin', 'Nat', 'Daugherty', 1708697818);
INSERT INTO Naudotojas (naudotojoID, slaptazodis, role, vardas, pavarde, asmensKodas) VALUES (2, '6108377', 'admin', 'Mariane', 'Shanahan', 2147483647);
INSERT INTO Naudotojas (naudotojoID, slaptazodis, role, vardas, pavarde, asmensKodas) VALUES (3, '7786207', 'admin', 'Richie', 'Maggio', 936939506);
INSERT INTO Naudotojas (naudotojoID, slaptazodis, role, vardas, pavarde, asmensKodas) VALUES (4, '439769', 'admin', 'Carmine', 'Hartmann', 2147483647);
INSERT INTO Naudotojas (naudotojoID, slaptazodis, role, vardas, pavarde, asmensKodas) VALUES (5, '9225746', 'admin', 'Helene', 'Upton', 2147483647);
INSERT INTO Naudotojas (naudotojoID, slaptazodis, role, vardas, pavarde, asmensKodas) VALUES (6, '5825533', 'admin', 'Retha', 'Schaefer', 1535827162);
INSERT INTO Naudotojas (naudotojoID, slaptazodis, role, vardas, pavarde, asmensKodas) VALUES (7, '3860553', ' treneris', 'Harold', 'Nolan', 2147483647);
INSERT INTO Naudotojas (naudotojoID, slaptazodis, role, vardas, pavarde, asmensKodas) VALUES (8, '5549778', ' klientas', 'Emilia', 'Stehr', 2147483647);
INSERT INTO Naudotojas (naudotojoID, slaptazodis, role, vardas, pavarde, asmensKodas) VALUES (9, '5798627', ' treneris', 'Nettie', 'Herzog', 2147483647);
INSERT INTO Naudotojas (naudotojoID, slaptazodis, role, vardas, pavarde, asmensKodas) VALUES (10, '3777834', ' treneris', 'Hattie', 'McDermott', 1849498832);



INSERT INTO PratimoInformacija (pratimoInfoID, pavadinimas, instrukcija) VALUES (1, 'sit', 'Itaque aut saepe ipsa.');
INSERT INTO PratimoInformacija (pratimoInfoID, pavadinimas, instrukcija) VALUES (2, 'neque', 'Consectetur facere error fugiat ducimus.');
INSERT INTO PratimoInformacija (pratimoInfoID, pavadinimas, instrukcija) VALUES (3, 'perferendis', 'Nobis hic quo saepe dolor inventore quis.');

INSERT INTO PratimoSpecifikacija (pratimoSpecifikacijaID, pakartojimai, serijos, poilsisTarpSeriju) VALUES (1, 9, 1, 59);
INSERT INTO PratimoSpecifikacija (pratimoSpecifikacijaID, pakartojimai, serijos, poilsisTarpSeriju) VALUES (2, 2, 1, 74);
INSERT INTO PratimoSpecifikacija (pratimoSpecifikacijaID, pakartojimai, serijos, poilsisTarpSeriju) VALUES (3, 10, 2, 56);

INSERT INTO Pratimas (pratimasID, pratimoInfoID, pratimoSpecifikacijaID) VALUES (1, 1, 1);
INSERT INTO Pratimas (pratimasID, pratimoInfoID, pratimoSpecifikacijaID) VALUES (2, 2, 2);
INSERT INTO Pratimas (pratimasID, pratimoInfoID, pratimoSpecifikacijaID) VALUES (3, 3, 3);

INSERT INTO SportoKlubas (sportoKlubasID, pavadinimas, adresas, plotas, kontaktai) VALUES (1, 'voluptate', 'Suite 224', '53.00', '55-967-324');
INSERT INTO SportoKlubas (sportoKlubasID, pavadinimas, adresas, plotas, kontaktai) VALUES (2, 'sunt', 'Apt. 995', '256.00', '09-893700');
INSERT INTO SportoKlubas (sportoKlubasID, pavadinimas, adresas, plotas, kontaktai) VALUES (3, 'id', 'Suite 076', '26.00', '15-301-174');

INSERT INTO SportoKlubuSarasas (abonementoPlanasID, sportoKlubasID) VALUES (1, 1);
INSERT INTO SportoKlubuSarasas (abonementoPlanasID, sportoKlubasID) VALUES (2, 2);
INSERT INTO SportoKlubuSarasas (abonementoPlanasID, sportoKlubasID) VALUES (3, 3);

INSERT INTO SportoZona (sportoZonaID, sportoKlubasID, plotas) VALUES (1, 1, '210.00');
INSERT INTO SportoZona (sportoZonaID, sportoKlubasID, plotas) VALUES (2, 2, '781.00');

INSERT INTO Treneris (trenerioID, naudotojoID, issilavinimas, darboStazas) VALUES (1, 1, 'Aukstasis', 13);
INSERT INTO Treneris (trenerioID, naudotojoID, issilavinimas, darboStazas) VALUES (2, 2, ' Magistras', 4);
INSERT INTO Treneris (trenerioID, naudotojoID, issilavinimas, darboStazas) VALUES (3, 3, ' Magistras', 1);
INSERT INTO Treneris (trenerioID, naudotojoID, issilavinimas, darboStazas) VALUES (4, 4, ' Magistras', 12);
INSERT INTO Treneris (trenerioID, naudotojoID, issilavinimas, darboStazas) VALUES (5, 5, 'Aukstasis', 8);

INSERT INTO SportoPlanas (sportoPlanasID, sudaresTrenerisID, laikotarpis, instrukcija) VALUES (1, 1, ' 2 sav.', 'Et culpa aut doloribus cupiditate enim laborum.');
INSERT INTO SportoPlanas (sportoPlanasID, sudaresTrenerisID, laikotarpis, instrukcija) VALUES (2, 2, ' 8 sav.', 'Delectus reprehenderit eum nobis natus.');
INSERT INTO SportoPlanas (sportoPlanasID, sudaresTrenerisID, laikotarpis, instrukcija) VALUES (3, 3, '6 sav.', 'Ea qui nesciunt dicta.');

INSERT INTO TreniruotesPlanas (treniruotesPlanoID, sportoZonaID, treniruotesTipas, dienosNumeris, aprasas) VALUES (4, 1, 'Svoriai', 50, 'Mollitia quod eos error vel eveniet velit.');
INSERT INTO TreniruotesPlanas (treniruotesPlanoID, sportoZonaID, treniruotesTipas, dienosNumeris, aprasas) VALUES (5, 2, 'multifunkcine', 51, 'Quibusdam officiis porro quo ut.');

INSERT INTO TreniruociuSarasas (sportoPlanasID, treniruotesPlanoID) VALUES (1, 4);
INSERT INTO TreniruociuSarasas (sportoPlanasID, treniruotesPlanoID) VALUES (2, 5);
INSERT INTO TreniruociuSarasas (sportoPlanasID, treniruotesPlanoID) VALUES (3, 4);

INSERT INTO MitybosPlanas (mitybosPlanasID, sudaresTrenerisID, laikotarpis, kalorijosPerDiena, dienosAngliavandeniai, dienosRiebalai, dienosBaltymai, dienosVandensKiekis, instrukcija) VALUES (1, 1, TO_DATE('2003-08-27', 'YYYY-MM-DD'), 5047, 8532, 1614, 5980, '1', 'Unde fugiat excepturi rerum consequatur asperiores quam harum.');
INSERT INTO MitybosPlanas (mitybosPlanasID, sudaresTrenerisID, laikotarpis, kalorijosPerDiena, dienosAngliavandeniai, dienosRiebalai, dienosBaltymai, dienosVandensKiekis, instrukcija) VALUES (2, 2, TO_DATE('2022-06-30', 'YYYY-MM-DD'), 2302, 8670, 2324, 8153, '1', 'Unde pariatur repellat et praesentium.');
INSERT INTO MitybosPlanas (mitybosPlanasID, sudaresTrenerisID, laikotarpis, kalorijosPerDiena, dienosAngliavandeniai, dienosRiebalai, dienosBaltymai, dienosVandensKiekis, instrukcija) VALUES (3, 3, TO_DATE('1989-03-22', 'YYYY-MM-DD'), 8777, 3145, 4914, 4608, '1', 'Porro et ut molestias aliquid doloribus nihil.');
INSERT INTO MitybosPlanas (mitybosPlanasID, sudaresTrenerisID, laikotarpis, kalorijosPerDiena, dienosAngliavandeniai, dienosRiebalai, dienosBaltymai, dienosVandensKiekis, instrukcija) VALUES (4, 4, TO_DATE('1992-06-26', 'YYYY-MM-DD'), 5476, 6983, 200, 4004, '0', 'Distinctio at sunt deserunt suscipit aut tempora.');
INSERT INTO MitybosPlanas (mitybosPlanasID, sudaresTrenerisID, laikotarpis, kalorijosPerDiena, dienosAngliavandeniai, dienosRiebalai, dienosBaltymai, dienosVandensKiekis, instrukcija) VALUES (5, 5, TO_DATE('1992-06-27', 'YYYY-MM-DD'), 5981, 6076, 7232, 9037, '0', 'Omnis eos illo illo rem.');


INSERT INTO Klientas (klientoID, naudotojoID, sportoPlanasID, mitybosPlanasID, abonementasID, ugis, svoris) VALUES (1, 1, 1, 1, 1, '1.7', '1.13');
INSERT INTO Klientas (klientoID, naudotojoID, sportoPlanasID, mitybosPlanasID, abonementasID, ugis, svoris) VALUES (2, 2, 2, 2, 2, '1.11', '0.98');
INSERT INTO Klientas (klientoID, naudotojoID, sportoPlanasID, mitybosPlanasID, abonementasID, ugis, svoris) VALUES (3, 3, 3, 3, 3, '1.87', '0.65');

INSERT INTO IndividualiTreniruote (klientoID, trenerioID, treniruotesPlanoID) VALUES (1, 1, 4);
INSERT INTO IndividualiTreniruote (klientoID, trenerioID, treniruotesPlanoID) VALUES (2, 2, 5);
INSERT INTO IndividualiTreniruote (klientoID, trenerioID, treniruotesPlanoID) VALUES (3, 3, 4);

INSERT INTO Inventorius (irangaID, sportoZonaID) VALUES (1, 1);
INSERT INTO Inventorius (irangaID, sportoZonaID) VALUES (2, 2);
INSERT INTO Inventorius (irangaID, sportoZonaID) VALUES (3, 1);

INSERT INTO PratimuSarasas (treniruotesPlanoID, pratimasID) VALUES (4, 1);
INSERT INTO PratimuSarasas (treniruotesPlanoID, pratimasID) VALUES (5, 2);
INSERT INTO PratimuSarasas (treniruotesPlanoID, pratimasID) VALUES (4, 3);