USE db_resilia;

-- Pergunta (1) -  Verificando a quantidade TOTAL dos alunos registrados no banco de dados;
SELECT COUNT(*) AS num_alunos FROM Aluno;

-- Pergunta (2) - Verificando quais são os facilitadores que dão aula em mais de uma turma;
SELECT facilitador_id FROM Turma GROUP BY facilitador_id HAVING COUNT(DISTINCT turma_id) > 1;

-- Pergunta (3) - Verificar porcentagem de evasão de alunos por turma.
CREATE VIEW Porcentagem_Evasao_Por_Turma AS
SELECT 
    t.turma_id,
    COUNT(a.matricula_id) AS total_alunos,
    SUM(CASE WHEN m.matricula_ativa = false THEN 1 ELSE 0 END) AS evadidos,
    (SUM(CASE WHEN m.matricula_ativa = false THEN 1 ELSE 0 END) / COUNT(a.matricula_id)) * 100 AS porcentagem_evasao
FROM 
    Turma t
LEFT JOIN 
    Aluno a ON t.turma_id = a.turma_id
LEFT JOIN 
    Matricula m ON a.matricula_id = m.matricula_id
GROUP BY 
    t.turma_id;
    
-- SELECT pardão para verificar a tabela de Porcentagem_Evasao_Por_Turma.
SELECT * FROM Porcentagem_Evasao_Por_Turma;

-- Pergunta (4) -  Criação do TRIGGER que é ativado quando nós modificamos o BOOLEAN da entidade Matricula.
DELIMITER $$
CREATE TRIGGER trig_matricula_status
AFTER UPDATE ON Matricula
FOR EACH ROW
BEGIN
    IF OLD.matricula_ativa != NEW.matricula_ativa THEN
        INSERT INTO matricula_log (matricula_id, status_antigo, status_novo)
        VALUES (NEW.matricula_id, OLD.matricula_ativa, NEW.matricula_ativa);
    END IF;
END$$
DELIMITER ;
-- Exemplo de update, onde a entidade 'matricula_ativa' do id 3212 é modificado para FALSE.
UPDATE matricula SET matricula_ativa = TRUE WHERE matricula_id = 3212;
UPDATE matricula SET matricula_ativa = TRUE WHERE matricula_id = 2457;
UPDATE matricula SET matricula_ativa = FALSE WHERE matricula_id = 1151;
UPDATE matricula SET matricula_ativa = FALSE WHERE matricula_id = 4123;

-- SELECT padrão para verificar a tabela de logs.
SELECT * FROM matricula_log;

-- Pergunta (5) - Quantos alunos estão matriculados em cada turma e quem são os facilitadores dessas turmas?
SELECT 
    t.turma_id,
    f.nome AS facilitador,
    t.qtd_alunos AS alunos_turma
FROM 
    Turma t
JOIN 
    Facilitador f ON t.facilitador_id = f.facilitador_id
JOIN 
    Aluno a ON t.turma_id = a.turma_id
GROUP BY 
    t.turma_id, f.nome;


-- Pergunta (6) - Quais são os facilitadores que têm o maior número de alunos matriculados em suas turmas e em quais cursos esses alunos estão matriculados? 

SELECT 
    Facilitador.nome AS nome_facilitador, 
    Curso.nome AS nome_curso, 
    qtd_matriculas AS alunos_totais
FROM 
    Facilitador
JOIN 
    Curso ON Facilitador.facilitador_id = Curso.facilitador_id
JOIN 
    Matricula ON Curso.curso_id = Matricula.curso_id
GROUP BY 
    Facilitador.facilitador_id, Curso.curso_id
ORDER BY 
    alunos_totais DESC;
