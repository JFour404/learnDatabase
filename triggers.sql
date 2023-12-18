CREATE OR REPLACE TRIGGER patikrint_naudotojo_role
BEFORE INSERT OR UPDATE ON Naudotojas
FOR EACH ROW
BEGIN
    IF :NEW.role NOT IN ('Admin', 'Treneris', 'Klientas') THEN
        RAISE_APPLICATION_ERROR(-20001, 'Netinkama naudotojo role.');
    END IF;
END;
/

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

