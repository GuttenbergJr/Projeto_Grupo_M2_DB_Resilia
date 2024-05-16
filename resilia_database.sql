CREATE DATABASE db_resilia;
USE db_resilia;

CREATE TABLE Facilitador (
	facilitador_id INT PRIMARY KEY,
    nome VARCHAR(255),
    cpf VARCHAR(11),
    cep VARCHAR(8),
    numero VARCHAR(5),
    logradouro VARCHAR(50),
    bairro VARCHAR(50),
    municipio VARCHAR(50),
    uf VARCHAR(2),
    email VARCHAR(50),
    telefone VARCHAR(10),
    celular VARCHAR(11)
);

CREATE TABLE Turma(
	turma_id INTEGER PRIMARY KEY,
	sala INTEGER,
	qtd_alunos INTEGER,
	turno VARCHAR(10),
	facilitador_id INTEGER,
	CONSTRAINT fk_facilitadorTurma FOREIGN KEY (facilitador_id) REFERENCES Facilitador (facilitador_id)
);

CREATE TABLE Curso (
	curso_id INTEGER PRIMARY KEY,
    nome VARCHAR(50),
    descricao VARCHAR(255),
    qtd_turmas INTEGER,
    qtd_matriculas INTEGER,
    qtd_modulos INTEGER,
    carga_horaria INTEGER,
    facilitador_id INTEGER,
    CONSTRAINT fk_facilitadorCurso FOREIGN KEY (facilitador_id) REFERENCES Facilitador (facilitador_id)
);

CREATE TABLE Matricula (
	matricula_id INTEGER PRIMARY KEY,
    data_matricula DATE,
	matricula_ativa BOOLEAN,
    frequencia FLOAT(3,2),
    media FLOAT(3,2),
    curso_id INTEGER,
    CONSTRAINT fk_cursoMatricula FOREIGN KEY (curso_id) REFERENCES Curso (curso_id)
);
    
CREATE TABLE Aluno (
	matricula_id INT PRIMARY KEY,
    turma_id INT,
    nome VARCHAR(255),
	cpf VARCHAR(11) UNIQUE,
    cep VARCHAR(8),
    numero VARCHAR(5),
    logradouro VARCHAR(50),
    bairro VARCHAR(50),
    municipio VARCHAR(50),
    uf VARCHAR(2),
    email VARCHAR(50),
    telefone VARCHAR(10),
    celular VARCHAR(11),
	CONSTRAINT fk_matriculaAluno FOREIGN KEY (matricula_id) REFERENCES Matricula (matricula_id),
    CONSTRAINT fk_turmaAluno FOREIGN KEY (turma_id) REFERENCES Turma (turma_id)
);

CREATE TABLE Modulo (
	modulo_id INTEGER PRIMARY KEY,
    titulo VARCHAR(50),
    descricao VARCHAR(255),
    qtd_aulas INTEGER,
    facilitador_id INTEGER,
    CONSTRAINT fk_facilitadorModulo FOREIGN KEY (facilitador_id) REFERENCES Facilitador (facilitador_id)
);

CREATE TABLE Modulos_integrados (
	curso_id INTEGER,
    modulo_id INTEGER,
    PRIMARY KEY (curso_id, modulo_id),
	CONSTRAINT fk_integraCurso FOREIGN KEY (curso_id) REFERENCES Curso (curso_id),
    CONSTRAINT fk_integraModulo FOREIGN KEY (modulo_id) REFERENCES Modulo (modulo_id)
);
    
CREATE TABLE Conteudo_aplicado (
	modulo_id INTEGER,
    turma_id INTEGER,
    qtd_aulas INTEGER,
    CONSTRAINT fk_conteudoModulo FOREIGN KEY (modulo_id) REFERENCES Modulo (modulo_id),
    CONSTRAINT fk_conteudoTurma FOREIGN KEY (turma_id) REFERENCES Turma (turma_id)
);

CREATE TABLE matricula_log (
	matricula_id INT PRIMARY KEY,  
	status_antigo BOOLEAN,	
	status_novo BOOLEAN
    );

INSERT INTO Facilitador (facilitador_id, nome, cpf, cep, numero, logradouro, bairro, municipio, uf, email, telefone, celular) VALUES 
(1, 'José Bezerra', '12345678901', '12345678', '123', 'Rua A', 'Centro', 'Cidade A', 'UF', 'fulano@example.com', '1234567890', '98765432101'),
(2, 'Ciclano Silva', '98765432101', '87654321', '456', 'Rua B', 'Bairro X', 'Cidade B', 'UF', 'ciclano@example.com', '0987654321', '98765432102'),
(3, 'Beltrano Oliveira', '65432198701', '76543210', '789', 'Rua C', 'Bairro Y', 'Cidade C', 'UF', 'beltrano@example.com', '4567890123', '98765432103');

INSERT INTO Turma (turma_id, sala, qtd_alunos, turno, facilitador_id) VALUES 
(1, 101, 8, 'Manhã', 1),
(2, 102, 12, 'Noite', 3),
(3, 103, 8, 'Manhã', 3),
(4, 104, 6, 'Tarde', 1),
(5, 105, 12, 'Tarde', 2);

INSERT INTO Curso (curso_id, nome, descricao, qtd_turmas, qtd_matriculas, qtd_modulos, carga_horaria, facilitador_id) VALUES 
(1, 'Curso de Programação Web', 'Curso introdutório sobre desenvolvimento web', 1, 6, 2, 60, 2),
(2, 'Curso de Marketing Digital', 'Curso abrangente sobre estratégias de marketing digital', 1, 8, 1, 50, 1),
(3, 'Curso de Finanças Pessoais', 'Curso prático sobre gestão financeira pessoal', 2, 24, 1, 40, 3),
(4, 'Curso de Fotografia', 'Curso abrangente sobre técnicas de fotografia', 1, 8, 2, 70, 1);

INSERT INTO Matricula (matricula_id, data_matricula, matricula_ativa, frequencia, media, curso_id) VALUES 
(1423,'2024-01-15', true, 0.85, 7.5, 1),
(2126, '2024-02-20', true, 0.90, 8.2, 1),
(4523, '2024-03-25', true, 0.80, 7.8, 1),
(4123, '2024-04-10', false, 0.75, 6.9, 1),
(5444, '2024-05-05', true, 0.95, 8.9, 1),
(6125, '2024-06-12', false, 0.70, 6.5, 1),

(7111, '2024-08-15', true, 0.92, 8.5, 2),
(8532, '2024-09-20', true, 0.85, 7.9, 2),
(9412, '2024-10-25', false, 0.78, 6.8, 2),
(1052, '2024-11-10', true, 0.93, 8.7, 2),
(1151, '2024-12-05', true, 0.90, 8.3, 2),
(1212, '2024-01-12', false, 0.70, 6.2, 2),
(1334, '2024-02-20', true, 0.96, 9.0, 2),
(1455, '2024-03-20', true, 0.88, 7.6, 2),

(1233, '2024-01-20', true, 0.88, 7.7, 3),
(1424, '2024-02-05', true, 0.92, 8.4, 3),
(1555, '2024-03-10', false, 0.70, 6.2, 3),
(1126, '2024-04-15', true, 0.94, 8.8, 3),
(1217, '2024-05-20', true, 0.90, 8.0, 3),
(1558, '2024-06-25', false, 0.75, 6.7, 3),
(1119, '2024-07-05', true, 0.96, 9.1, 3),
(2230, '2024-08-10', true, 0.89, 8.1, 3),
(2241, '2024-09-15', true, 0.93, 8.6, 3),
(2552, '2024-10-20', true, 0.85, 7.8, 3),
(2123, '2024-11-25', false, 0.72, 6.3, 3),
(2244, '2024-12-05', true, 0.97, 9.3, 3),
(2115, '2024-01-02', true, 0.91, 8.3, 3),
(2216, '2024-02-05', true, 0.88, 7.9, 3),
(2457, '2024-03-10', true, 0.95, 9.0, 3),
(2128, '2024-04-15', false, 0.68, 6.0, 3),
(229, '2024-05-20', true, 0.92, 8.5, 3),
(3330, '2024-06-25', true, 0.89, 8.2, 3),
(3411, '2024-07-05', true, 0.94, 8.9, 3),
(3212, '2024-08-10', false, 0.73, 6.4, 3),
(3453, '2024-09-15', true, 0.96, 9.2, 3),
(3114, '2024-10-20', true, 0.90, 8.1, 3),
(3355, '2024-11-25', true, 0.87, 7.9, 3),
(3116, '2024-12-05', true, 0.93, 8.7, 3),
(3127, '2024-01-10', true, 0.85, 7.6, 4),
(3348, '2024-02-15', true, 0.91, 8.3, 4),
(3559, '2024-03-20', false, 0.72, 6.1, 4),
(1240, '2024-04-25', true, 0.93, 8.7, 4),
(4351, '2024-05-05', true, 0.89, 8.0, 4),
(4322, '2024-06-10', true, 0.95, 9.0, 4),
(4112, '2024-07-15', false, 0.70, 6.5, 4),
(4433, '2024-08-20', true, 0.92, 8.6, 4);

INSERT INTO Aluno (matricula_id, turma_id, nome, cpf, cep, numero, logradouro, bairro, municipio, uf, email, telefone, celular) VALUES 
(1423, 1, 'Ana Silva', '12345678911', '12345678', '123', 'Rua A', 'Centro', 'Cidade A', 'UF', 'ana@example.com', '1234567890', '98765432101'),
(2126, 1, 'Pedro Souza', '23456789013', '23456789', '234', 'Rua B', 'Bairro X', 'Cidade B', 'UF', 'pedro@example.com', '2345678901', '87654321012'),
(4523, 1, 'Maria Oliveira', '34567890124', '34567890', '345', 'Rua C', 'Bairro Y', 'Cidade C', 'UF', 'maria@example.com', '3456789012', '76543210123'),
(4123, 1, 'João Santos', '45678901235', '45678901', '456', 'Rua D', 'Bairro Z', 'Cidade D', 'UF', 'joao@example.com', '4567890123', '65432101234'),
(5444, 1, 'Carla Lima', '56789012346', '56789012', '567', 'Rua E', 'Bairro W', 'Cidade E', 'UF', 'carla@example.com', '5678901234', '54321012345'),
(6125, 1, 'Ricardo Pereira', '67890123457', '67890123', '678', 'Rua F', 'Bairro V', 'Cidade F', 'UF', 'ricardo@example.com', '6789012345', '43210123456'),

(7111, 2, 'Mariana Vieira', '78901234568', '78901234', '789', 'Rua G', 'Bairro U', 'Cidade G', 'UF', 'mariana@example.com', '7890123456', '32101234567'),
(8532, 2, 'Fernando Lima', '89012345679', '89012345', '890', 'Rua H', 'Bairro T', 'Cidade H', 'UF', 'fernando@example.com', '8901234567', '21012345678'),
(9412, 2, 'Luciana Pereira', '90123456780', '90123456', '901', 'Rua I', 'Bairro S', 'Cidade I', 'UF', 'luciana@example.com', '9012345678', '10123456789'),
(1052, 2, 'Luiz Vieira', '01234567891', '01234567', '012', 'Rua J', 'Bairro R', 'Cidade J', 'UF', 'luiz@example.com', '0123456789', '01234567890'),
(1151, 2, 'Tatiane Lima', '98765432102', '98765432', '987', 'Rua K', 'Bairro Q', 'Cidade K', 'UF', 'tatiane@example.com', '9876543210', '87654321098'),
(1212, 2, 'Gustavo Oliveira', '87654321011', '87654321', '876', 'Rua L', 'Bairro P', 'Cidade L', 'UF', 'gustavo@example.com', '8765432109', '76543210987'),
(1334, 2, 'Patrícia Santos', '76543210934', '76543210', '765', 'Rua M', 'Bairro O', 'Cidade M', 'UF', 'patricia@example.com', '7654321098', '65432109876'),
(1455, 2, 'Roberto Souza', '65432109845', '65432109', '654', 'Rua N', 'Bairro N', 'Cidade N', 'UF', 'roberto@example.com', '6543210987', '54321098765'),

(1233, 3, 'Camila Oliveira', '54321098756', '54321098', '543', 'Rua O', 'Bairro M', 'Cidade O', 'UF', 'camila@example.com', '5432109876', '43210987654'),
(1424, 3, 'Diego Silva', '43210987667', '43210987', '432', 'Rua P', 'Bairro L', 'Cidade P', 'UF', 'diego@example.com', '4321098765', '32109876543'),
(1555, 3, 'Sandra Souza', '32109876578', '32109876', '321', 'Rua Q', 'Bairro K', 'Cidade Q', 'UF', 'sandra@example.com', '3210987654', '21098765432'),
(1126, 3, 'Jorge Pereira', '21098765489', '21098765', '210', 'Rua R', 'Bairro J', 'Cidade R', 'UF', 'jorge@example.com', '2109876543', '10987654321'),
(1217, 3, 'Vanessa Santos', '10987654390', '10987654', '109', 'Rua S', 'Bairro I', 'Cidade S', 'UF', 'vanessa@example.com', '1098765432', '98765432110'),
(1558, 3, 'Felipe Lima', '09876543201', '09876543', '098', 'Rua T', 'Bairro H', 'Cidade T', 'UF', 'felipe@example.com', '0987654321', '87654321098'),
(1119, 3, 'Juliana Oliveira', '98765432112', '98765432', '987', 'Rua U', 'Bairro G', 'Cidade U', 'UF', 'juliana@example.com', '9876543210', '76543210987'),
(2230, 3, 'Lucas Vieira', '87654321057', '87654321', '876', 'Rua V', 'Bairro F', 'Cidade V', 'UF', 'lucas@example.com', '8765432109', '65432109876'),
(2241, 3, 'Aline Santos', '76543210911', '76543210', '765', 'Rua W', 'Bairro E', 'Cidade W', 'UF', 'aline@example.com', '7654321098', '54321098765'),
(2552, 3, 'Rafael Oliveira', '65432109800', '65432109', '654', 'Rua X', 'Bairro D', 'Cidade X', 'UF', 'rafael@example.com', '6543210987', '43210987654'),
(2123, 3, 'Fernanda Souza', '54321098757', '54321098', '543', 'Rua Y', 'Bairro C', 'Cidade Y', 'UF', 'fernanda@example.com', '5432109876', '32109876543'),
(2244, 3, 'Robson Silva', '4321098762', '43210987', '432', 'Rua Z', 'Bairro B', 'Cidade Z', 'UF', 'robson@example.com', '4321098765', '21098765432'),
(2115, 3, 'Bruna Oliveira', '32109876512', '32109876', '321', 'Rua A1', 'Bairro A', 'Cidade A1', 'UF', 'bruna@example.com', '3210987654', '10987654321'),
(2216, 3, 'André Santos', '21098765400', '21098765', '210', 'Rua B1', 'Bairro B1', 'Cidade B1', 'UF', 'andre@example.com', '2109876543', '09876543210'),
(2457, 3, 'Carolina Souza', '10987654300', '10987654', '109', 'Rua C1', 'Bairro C1', 'Cidade C1', 'UF', 'carolina@example.com', '1098765432', '98765432452'),
(2128, 3, 'Guilherme Silva', '09876543204', '09876543', '098', 'Rua D1', 'Bairro D1', 'Cidade D1', 'UF', 'guilherme@example.com', '0987654321', '87654321098'),
(229, 3, 'Gabriela Oliveira', '98765432156', '98765432', '987', 'Rua E1', 'Bairro E1', 'Cidade E1', 'UF', 'gabriela@example.com', '9876543210', '76543210987'),
(3330, 3, 'Luciano Santos', '87654321000', '87654321', '876', 'Rua F1', 'Bairro F1', 'Cidade F1', 'UF', 'luciano@example.com', '8765432109', '65432109876'),
(3411, 3, 'Amanda Vieira', '76543210990', '76543210', '765', 'Rua G1', 'Bairro G1', 'Cidade G1', 'UF', 'amanda@example.com', '7654321098', '54321098765'),
(3212, 3, 'Felipe Oliveira', '65432109869', '65432109', '654', 'Rua H1', 'Bairro H1', 'Cidade H1', 'UF', 'felipe@example.com', '6543210987', '43210987654'),
(3453, 3, 'Larissa Silva', '54321098751', '54321098', '543', 'Rua I1', 'Bairro I1', 'Cidade I1', 'UF', 'larissa@example.com', '5432109876', '32109876543'),
(3114, 3, 'Marcelo Santos', '43210987600', '43210987', '432', 'Rua J1', 'Bairro J1', 'Cidade J1', 'UF', 'marcelo@example.com', '4321098765', '21098765432'),
(3355, 3, 'Jéssica Vieira', '32109876589', '32109876', '321', 'Rua K1', 'Bairro K1', 'Cidade K1', 'UF', 'jessica@example.com', '3210987654', '10987654321'),
(3116, 3, 'Rafaela Oliveira', '21098765416', '21098765', '210', 'Rua L1', 'Bairro L1', 'Cidade L1', 'UF', 'rafaela@example.com', '2109876543', '09876543210'),

(3127, 4, 'Mariano Silva', '10987654312', '10987654', '109', 'Rua M1', 'Bairro M1', 'Cidade M1', 'UF', 'mariano@example.com', '1098765432', '98765432115'),
(3348, 4, 'Vanessa Oliveira', '09876543405', '09876543', '098', 'Rua N1', 'Bairro N1', 'Cidade N1', 'UF', 'vanessa@example.com', '0987654321', '87654321098'),
(3559, 4, 'Leonardo Santos', '98765432001', '98765432', '987', 'Rua O1', 'Bairro O1', 'Cidade O1', 'UF', 'leonardo@example.com', '9876543210', '76543210987'),
(1240, 4, 'Fernanda Vieira', '87654321080', '87654321', '876', 'Rua P1', 'Bairro P1', 'Cidade P1', 'UF', 'fernanda@example.com', '8765432109', '65432109876'),
(4351, 4, 'Ricardo Oliveira', '76543210953', '76543210', '765', 'Rua Q1', 'Bairro Q1', 'Cidade Q1', 'UF', 'ricardo@example.com', '7654321098', '54321098765'),
(4322, 4, 'Carla Santos', '65432109811', '65432109', '654', 'Rua R1', 'Bairro R1', 'Cidade R1', 'UF', 'carla@example.com', '6543210987', '43210987654'),
(4112, 4, 'Isabela Oliveira', '54321098700', '54321098', '543', 'Rua U1', 'Bairro U1', 'Cidade U1', 'UF', 'isabela@example.com', '4321098765', '32109876543'),
(4433, 4, 'Thiago Santos', '43210987611', '43210987', '432', 'Rua V1', 'Bairro V1', 'Cidade V1', 'UF', 'thiago@example.com', '4321098765', '21098765432');

INSERT INTO Modulo (modulo_id, titulo, descricao, qtd_aulas, facilitador_id) VALUES 
(1, 'Introdução à Programação', 'Este módulo apresenta os conceitos básicos de programação.', 10, 2),
(2, 'Introdução ao CSS', 'Este módulo apresenta os conceitos básicos de estilização utilizando CSS.', 5, 2),
(3, 'Marketing Digital I', 'Este módulo apresenta os principais metodos para realizar vendas no seu e-commerce.',8,1),
(4, 'Finanças Pessoais I', 'Este módulo apresenta os principais conceitos como poupança, investimentos, seguros e crédito',6,3),
(5, 'Fotografia I', 'Este módulo apresenta os principais conceitos de fotografia',4,1),
(6, 'Fotografia II', 'Este módulo apresenta os principais conceitos avançados de fotografia',7,1);

INSERT INTO Modulos_integrados (curso_id, modulo_id) VALUES 
(1,1),(1,2),
(2,3),
(3,4),
(4,5),(4,6);

INSERT INTO Conteudo_aplicado (modulo_id, turma_id, qtd_aulas) VALUES
(1,5,10),
(2,2,5),
(3,1,2),
(4,3,6),
(5,3,2),
(6,3,1);

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
AFTER UPDATE ON matricula
FOR EACH ROW
BEGIN
    IF OLD.matricula_ativa != NEW.matricula_ativa THEN
        INSERT INTO matricula_log (matricula_id, status_antigo, status_novo)
        VALUES (matricula_id, OLD.matricula_ativa, NEW.matricula_ativa);
    END IF;
END$$
DELIMITER ;
-- Exemplo de update, onde a entidade 'matricula_ativa' do id 3212 é modificado para TRUE.
UPDATE matricula SET matricula_ativa = TRUE WHERE matricula_id = 3212;
-- SELECT pardão para verificar a tabela de logs.
SELECT * FROM matricula_log;

-- Pergunta (5) - Quantos alunos estão matriculados em cada turma e quem são os facilitadores dessas turmas?
SELECT 
    t.turma_id,
    COUNT(a.matricula_id) AS num_alunos,
    f.nome AS facilitador
FROM 
    Turma t
INNER JOIN 
    Facilitador f ON t.facilitador_id = f.facilitador_id
LEFT JOIN 
    Aluno a ON t.turma_id = a.turma_id
GROUP BY 
    t.turma_id, f.nome;

-- Pergunta (6) - Quais são os facilitadores que têm o maior número de alunos matriculados em suas turmas e em quais cursos esses alunos estão matriculados? 
-- COM ERRO
SELECT 
    f.nome AS facilitador,
    COUNT(a.matricula_id) AS num_alunos,
    c.nome AS curso
FROM 
    Facilitador f
INNER JOIN 
    Turma t ON f.facilitador_id = t.facilitador_id
INNER JOIN 
    Aluno a ON t.turma_id = a.turma_id
INNER JOIN 
    Matricula m ON a.matricula_id = m.matricula_id
INNER JOIN 
    Curso c ON m.curso_id = c.curso_id
WHERE 
    f.facilitador_id IN (
        SELECT 
            facilitador_id
        FROM 
            Turma
        GROUP BY 
            facilitador_id
        ORDER BY 
            COUNT(*) DESC
        LIMIT 1
    )
GROUP BY 
    f.nome, c.nome;
