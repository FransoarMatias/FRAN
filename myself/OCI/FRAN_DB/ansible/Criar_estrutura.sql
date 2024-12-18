--## Procedure de Criação de Usuarios
CREATE OR REPLACE PROCEDURE ADMIN.PC_CREATE_USER_NOMINAL(
    p_username IN VARCHAR2 -- Nome do usuário como parâmetro de entrada
)
AUTHID DEFINER -- Executa com permissões do Owner
IS
    v_user_exists NUMBER; -- Verifica se o usuário existe
    v_password    VARCHAR2(20); -- Armazena a senha gerada
    v_sql         VARCHAR2(4000); -- Armazena os comandos SQL dinâmicos

    -- Função para gerar senha aleatória
    FUNCTION gerar_senha RETURN VARCHAR2 IS
        v_chars CONSTANT VARCHAR2(200) := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789#*!';
        v_result VARCHAR2(200) := ''; -- Inicializa com vazio
    BEGIN
        FOR i IN 1..10 LOOP
            v_result := v_result || SUBSTR(v_chars, TRUNC(DBMS_RANDOM.VALUE(1, LENGTH(v_chars) + 1)), 1);
        END LOOP;
        RETURN v_result;
    END gerar_senha;

BEGIN
    -- Depuração inicial
    DBMS_OUTPUT.PUT_LINE('Iniciando a execução da procedure.');

    -- Verifica se o usuário já existe
    SELECT COUNT(*) INTO v_user_exists FROM dba_users WHERE username = UPPER(p_username);

    IF v_user_exists > 0 THEN
        -- Usuário já existe: Altera senha e permissões
        v_password := gerar_senha;
        DBMS_OUTPUT.PUT_LINE('Senha gerada para alteração: ' || v_password);

        v_sql := 'ALTER USER ' || UPPER(p_username) || ' IDENTIFIED BY "' || v_password || '" PASSWORD EXPIRE';
        DBMS_OUTPUT.PUT_LINE('Comando ALTER USER: ' || v_sql);
        EXECUTE IMMEDIATE v_sql;

        v_sql := 'GRANT RO_ANALISTA TO ' || UPPER(p_username);
        DBMS_OUTPUT.PUT_LINE('Comando GRANT: ' || v_sql);
        EXECUTE IMMEDIATE v_sql;

        DBMS_OUTPUT.PUT_LINE('==============');
        DBMS_OUTPUT.PUT_LINE('User: ' || UPPER(p_username));
        DBMS_OUTPUT.PUT_LINE('Pass: ' || v_password);
        DBMS_OUTPUT.PUT_LINE('OBS: No primeiro login irá pedir para alterar a senha.');

    ELSE
        -- Usuário não existe: Cria usuário e configura permissões
        v_password := gerar_senha;
        DBMS_OUTPUT.PUT_LINE('Senha gerada para criação: ' || v_password);

        v_sql := 'CREATE USER ' || UPPER(p_username) || ' IDENTIFIED BY "' || v_password || '" PASSWORD EXPIRE PROFILE PF_COLABORADOR';
        DBMS_OUTPUT.PUT_LINE('Comando CREATE USER: ' || v_sql);
        EXECUTE IMMEDIATE v_sql;

        v_sql := 'GRANT RO_ANALISTA TO ' || UPPER(p_username);
        DBMS_OUTPUT.PUT_LINE('Comando GRANT: ' || v_sql);
        EXECUTE IMMEDIATE v_sql;

        DBMS_OUTPUT.PUT_LINE('==============');
        DBMS_OUTPUT.PUT_LINE('User: ' || UPPER(p_username));
        DBMS_OUTPUT.PUT_LINE('Pass: ' || v_password);
        DBMS_OUTPUT.PUT_LINE('OBS: No primeiro login irá pedir para alterar a senha.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('Execução concluída com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        -- Captura qualquer erro e exibe
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
        RAISE;
END;
/