import boto3
import os

# Configurações do Redshift
region = os.getenv('AWS_REGION')
cluster_identifier = os.getenv('REDSHIFT_CLUSTER_IDENTIFIER')
database = os.getenv('DATABASE_NAME')
user = os.getenv('MASTER_USERNAME')
password = os.getenv('MASTER_PASSWORD')

# Lista de comandos SQL para criar tabelas
sql_commands = [
    """
    CREATE TABLE TB_ECONOMIA (
        ID_ECONOMIA INT IDENTITY(1,1) PRIMARY KEY,
        VL_RENDA_MEDIA_FAMILIAS DECIMAL(10, 2),
        VL_RENDA_PER_CAPITA DECIMAL(10, 2)
    );
    """,
    """
    CREATE TABLE TB_AREA_GEOGRAFICA (
        ID_AREA_GEOGRAFICA INT IDENTITY(1,1) PRIMARY KEY,
        NM_AREA VARCHAR(255),
        COD_CONDADO INT,
        COD_ESTADO INT,
        COD_TRACTO INT,
        UNIQUE (COD_CONDADO, COD_ESTADO, COD_TRACTO)
    );
    """,
    """
    CREATE TABLE TB_DEMOGRAFIA (
        ID_DEMOGRAFIA INT IDENTITY(1,1) PRIMARY KEY,
        VL_MEDIA_IDADE DECIMAL(5, 2),
        QTD_POPULACAO_TOTAL INT,
        QTD_POPULACAO_BRANCA INT,
        QTD_POPULACAO_HISPANICA_LATINA INT,
        QTD_POPULACAO_NEGRA_AFRO_AMERICANA INT,
        COD_NIVEL_EDUCACAO INT
    );
    """,
    """
    CREATE TABLE TB_HABITACAO (
        ID_HABITACAO INT IDENTITY(1,1) PRIMARY KEY,
        VL_MEDIANO_IMOVEIS DECIMAL(15, 2),
        VL_ALUGUEL_MEDIO DECIMAL(10, 2),
        VL_ALUGUEL_CONTRATUAL_MEDIO DECIMAL(10, 2),
        VL_PERCENTUAL_RENDA_ALUGUEL DECIMAL(5, 2),
        QTD_TOTAL_UNIDADES_HABITACIONAIS INT,
        QTD_MORADIAS_OCUPADAS_PROPRIETARIOS INT,
        NR_IDADE_MEDIA_MORADIAS DECIMAL(5, 2)
    );
    """,
    """
    CREATE TABLE TB_DADOS_ACS (
        ID_DADOS_ACS INT IDENTITY(1,1) PRIMARY KEY,
        ID_AREA_GEOGRAFICA INT,
        ID_DEMOGRAFIA INT,
        ID_ECONOMIA INT,
        ID_HABITACAO INT,
        QTD_TOTAL_RESIDENTES INT,
        NR_TAMANHO_FORCA_TRABALHO INT,
        QTD_DESEMPREGADOS INT,
        QTD_TOTAL_DOMICILIOS INT,
        FOREIGN KEY (ID_AREA_GEOGRAFICA) REFERENCES TB_AREA_GEOGRAFICA(ID_AREA_GEOGRAFICA),
        FOREIGN KEY (ID_DEMOGRAFIA) REFERENCES TB_DEMOGRAFIA(ID_DEMOGRAFIA),
        FOREIGN KEY (ID_ECONOMIA) REFERENCES TB_ECONOMIA(ID_ECONOMIA),
        FOREIGN KEY (ID_HABITACAO) REFERENCES TB_HABITACAO(ID_HABITACAO)
    );
    """
]

# Cliente da AWS Data API para Redshift
client = boto3.client('redshift-data', region_name=region)

# Executar cada comando SQL
for sql_command in sql_commands:
    response = client.execute_statement(
        Database=database,
        DbUser=user,
        Sql=sql_command,
        ClusterIdentifier=cluster_identifier,
        WithEvent=True
    )
    print("Resposta da execução:", response)
