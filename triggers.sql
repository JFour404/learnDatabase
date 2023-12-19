CREATE OR REPLACE TRIGGER patikrint_naudotojo_role
BEFORE INSERT OR UPDATE ON Naudotojas
FOR EACH ROW
BEGIN
    IF :NEW.role NOT IN ('Admin', 'Treneris', 'Klientas') THEN
        RAISE_APPLICATION_ERROR(-20001, 'Netinkama naudotojo role.');
    END IF;
END;
/

--Tikrint asmens koda, ilgi, kad butu 11 simboliu ir kad butu tik skaiciai
CREATE OR REPLACE TRIGGER patikrint_asmens_koda
BEFORE INSERT OR UPDATE ON Naudotojas
FOR EACH ROW
BEGIN
    IF LENGTH(:NEW.asmensKodas) != 11 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Netinkamas asmens kodas.');
    END IF;
    IF :NEW.asmensKodas NOT LIKE '___________' THEN
        RAISE_APPLICATION_ERROR(-20003, 'Netinkamas asmens kodas.');
    END IF;
END;

--Tikrint ar sporto klubo plotas yra teigiamas
CREATE OR REPLACE TRIGGER patikrint_sporto_klubo_plota
BEFORE INSERT OR UPDATE ON SportoKlubas
FOR EACH ROW
BEGIN
    IF :NEW.plotas < 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Sporto klubo plotas negali buti neigiamas.');
    END IF;
END;

--Tikrint ar sporto zonos plotas yra teigiamas
CREATE OR REPLACE TRIGGER patikrint_sporto_zonos_plota
BEFORE INSERT OR UPDATE ON SportoZona
FOR EACH ROW
BEGIN
    IF :NEW.plotas < 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'Sporto zonos plotas negali buti neigiamas.');
    END IF;
END;

--Tikrint ar trenerio darbo stazas yra teigiamas
CREATE OR REPLACE TRIGGER patikrint_trenerio_darbo_staza
BEFORE INSERT OR UPDATE ON Treneris
FOR EACH ROW
BEGIN
    IF :NEW.darboStazas < 0 THEN
        RAISE_APPLICATION_ERROR(-20006, 'Trenerio darbo stazas negali buti neigiamas.');
    END IF;
END;

--Tikrint ar abonemento planas yra terminuotas
CREATE OR REPLACE TRIGGER patikrint_abonemento_plano_termina
BEFORE INSERT OR UPDATE ON AbonementoPlanas
FOR EACH ROW
BEGIN
    IF :NEW.arTerminuota NOT IN (0, 1) THEN
        RAISE_APPLICATION_ERROR(-20007, 'Abonemento planas turi buti terminuotas arba neterminuotas.');
    END IF;
END;


CREATE OR REPLACE TRIGGER cascade_istrinamas_sporto_planas
BEFORE DELETE ON SportoPlanas
FOR EACH ROW
BEGIN
    DELETE FROM TreniruociuSarasas WHERE sportoPlanID = :OLD.sportoPlanasID;
    DELETE FROM IndTren WHERE sportoPlanID = :OLD.sportoPlanasID;
END;
/


CREATE OR REPLACE TRIGGER patvirtinti_mitybos_plana
BEFORE INSERT ON MitybosPlanas
FOR EACH ROW
BEGIN
    IF :NEW.kalorijosPerDiena < 1000 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Caloric intake must be at least 1000 kcal per day.');
    END IF;
END;
/


CREATE OR REPLACE TRIGGER cascade_istrint_klienta
BEFORE DELETE ON Klientas
FOR EACH ROW
BEGIN
    DELETE FROM IndTren WHERE klientoID = :OLD.klientoID;
    DELETE FROM Abonementas WHERE abonementasID = :OLD.abonementasID;
END;
/


CREATE OR REPLACE TRIGGER atnaujint_sporto_klubo_plota
AFTER INSERT OR UPDATE ON SportoZona
FOR EACH ROW
BEGIN
    UPDATE SportoKlubas
    SET plotas = plotas + :NEW.plotas - NVL(:OLD.plotas, 0)
    WHERE sportoKlubasID = :NEW.sportoKlubasID;
END;
/

