-- Modelo lógico relacional: Clínica Veterinária (PostgreSQL)

CREATE TABLE tutor (
    id_tutor  SERIAL PRIMARY KEY,
    nome      VARCHAR(100) NOT NULL,
    cpf       CHAR(11)     NOT NULL UNIQUE,
    telefone  VARCHAR(20),
    email     VARCHAR(100)
);

CREATE TABLE animal (
    id_animal       SERIAL PRIMARY KEY,
    nome            VARCHAR(80) NOT NULL,
    especie         VARCHAR(40) NOT NULL,
    raca            VARCHAR(60),
    data_nascimento DATE,
    id_tutor        INT NOT NULL REFERENCES tutor (id_tutor)
);

CREATE TABLE veterinario (
    id_veterinario SERIAL PRIMARY KEY,
    nome           VARCHAR(100) NOT NULL,
    crmv           VARCHAR(20)  NOT NULL UNIQUE,
    especialidade  VARCHAR(60)
);

CREATE TABLE consulta (
    id_consulta    SERIAL PRIMARY KEY,
    data_hora      TIMESTAMP NOT NULL,
    motivo         VARCHAR(200),
    diagnostico    TEXT,
    valor          NUMERIC(10,2) CHECK (valor >= 0),
    id_animal      INT NOT NULL REFERENCES animal (id_animal),
    id_veterinario INT NOT NULL REFERENCES veterinario (id_veterinario),
    -- impede dois atendimentos do mesmo veterinário no mesmo horário
    CONSTRAINT uq_agenda_veterinario UNIQUE (id_veterinario, data_hora)
);
