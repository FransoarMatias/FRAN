--## Criar Usuario Nominal
set feedback on
set serveroutput on
DECLARE
    v_user_name VARCHAR2(30) := 'F0033947';
BEGIN
    ADMIN.PC_CREATE_USER_NOMINAL(v_user_name);
END;
/