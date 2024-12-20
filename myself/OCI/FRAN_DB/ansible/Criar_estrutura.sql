--## Procedure de Criação de Usuarios
CREATE OR REPLACE PROCEDURE ADMIN.PC_CREATE_USER_NOMINAL (
    p_user_name IN VARCHAR2
) AUTHID DEFINER AS
    v_password VARCHAR2(30);
    v_user_exists NUMBER;

    FUNCTION generate_simple_password RETURN VARCHAR2 IS
        v_random_password VARCHAR2(30);
        v_digit1 VARCHAR2(1);
        v_digit2 VARCHAR2(1);
        v_digit3 VARCHAR2(1);
        v_digit4 VARCHAR2(1);
    BEGIN
        -- Generate random digits between 1 and 9
        SELECT TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(1, 10))) INTO v_digit1 FROM dual;
        SELECT TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(1, 10))) INTO v_digit2 FROM dual;
        SELECT TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(1, 10))) INTO v_digit3 FROM dual;
        SELECT TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(1, 10))) INTO v_digit4 FROM dual;

        v_random_password := 'PassExpire#' || 
                             DBMS_RANDOM.STRING('A', 2) ||  -- 2 uppercase letters
                             v_digit1 || v_digit2 ||        -- 2 digits
                             DBMS_RANDOM.STRING('a', 2) ||  -- 2 lowercase letters
                             DBMS_RANDOM.STRING('X', 2) ||  -- 2 special characters
                             DBMS_RANDOM.STRING('A', 2) ||  -- 2 uppercase letters
                             DBMS_RANDOM.STRING('a', 2) ||  -- 2 lowercase letters
                             v_digit3 || v_digit4;          -- 2 digits
        RETURN v_random_password;
    END generate_simple_password;

BEGIN
    -- Generate a simple password
    v_password := generate_simple_password();
    -- Check if the user already exists
    SELECT COUNT(*)
    INTO v_user_exists
    FROM dba_users
    WHERE username = UPPER(p_user_name);

    IF v_user_exists = 0 THEN
        -- Log the action for user creation
        DBMS_OUTPUT.PUT_LINE('Creating user: ' || p_user_name);

        -- Create the user with the specified password and password expiry
        EXECUTE IMMEDIATE 'CREATE USER ' || p_user_name ||
                          ' IDENTIFIED BY "' || v_password ||
                          '" PASSWORD EXPIRE PROFILE PF_COLABORADOR';

        -- Grant role to the user
        EXECUTE IMMEDIATE 'GRANT RO_ANALISTA TO ' || p_user_name;

        -- Log success
        DBMS_OUTPUT.PUT_LINE('User ' || p_user_name || ' created successfully.');
        DBMS_OUTPUT.PUT_LINE('Password: ' || v_password);
        DBMS_OUTPUT.PUT_LINE('OBS: No primeiro login ira pedir para alterar a senha.');
    ELSE
        -- Log the action for user modification
        DBMS_OUTPUT.PUT_LINE('User already exists. Altering user: ' || p_user_name);

        -- Alter the user to reset the password and password expiry
        EXECUTE IMMEDIATE 'ALTER USER ' || p_user_name ||
                          ' IDENTIFIED BY "' || v_password ||
                          '" PASSWORD EXPIRE';

        -- Log success for alteration
        DBMS_OUTPUT.PUT_LINE('User ' || p_user_name || ' password reset successfully.');
        DBMS_OUTPUT.PUT_LINE('Password: ' || v_password);
        DBMS_OUTPUT.PUT_LINE('OBS: No primeiro login ira pedir para alterar a senha.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        -- Log errors
        DBMS_OUTPUT.PUT_LINE('Error processing user ' || p_user_name || ': ' || SQLERRM);
END PC_CREATE_USER_NOMINAL;
/