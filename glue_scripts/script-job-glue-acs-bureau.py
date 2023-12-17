import sys
import requests
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.dynamicframe import DynamicFrame

# Obtenção dos argumentos do job
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

# Inicialização do Contexto Spark e Glue
sc = SparkContext()
glue_context = GlueContext(sc)
spark = glue_context.spark_session
job = Job(glue_context)
job.init(args['JOB_NAME'], args)

# Variáveis selecionadas da ACS 2019
variables = {
    "NAME": "area_geografica",
    "B01001_001E": "total_residentes",
    "B01002_001E": "media_idade",
    "B19013_001E": "renda_media_familias",
    "B19301_001E": "renda_per_capita",
    "B25077_001E": "valor_mediano_imoveis",
    "B25064_001E": "aluguel_medio",
    "B15003_002E": "nivel_educacao",
    "B23025_002E": "tamanho_forca_trabalho",
    "B23025_005E": "numero_desempregados",
    "B25035_001E": "idade_media_moradias",
    "B25058_001E": "aluguel_contratual_medio",
    "B25071_001E": "percentual_renda_aluguel",
    "B25001_001E": "total_unidades_habitacionais",
    "B25002_003E": "moradias_ocupadas_proprietarios",
    "B11001_001E": "total_domicilios",
    "B01003_001E": "populacao_total",
    "B02001_002E": "populacao_branca",
    "B03003_003E": "populacao_hispanica_latina",
    "B02001_003E": "populacao_negra_afro_americana"
}

# Construção da string de variáveis para a URL
variables_str = ",".join(variables.keys())

# Especificação de um estado para a consulta (exemplo: California, código de estado 06)
state_code = "06"

# URL da API para dados a nível de trato do censo em um estado específico
url = f"https://api.census.gov/data/2019/acs/acs5?get={variables_str}&for=tract:*&in=state:{state_code}"

# Realização da requisição para a API e obtenção dos dados
response = requests.get(url)

# Verificação da resposta da API
if response.status_code == 200:
    data = response.json()
    headers = data[0]
    rows = data[1:]

    # Criação de um RDD de dicionários, onde cada dicionário representa uma linha de dados
    rdd = sc.parallelize([dict(zip(headers, row)) for row in rows])

    # Conversão do RDD para um DataFrame
    df = spark.createDataFrame(rdd)

    # Renomeação das colunas
    for original_name, new_name in variables.items():
        df = df.withColumnRenamed(original_name, new_name)

    # Mapeamento de variáveis adicionais
    additional_variables = {
        "county": "codigo_condado",
        "state": "codigo_estado",
        "tract": "codigo_tracto"
    }

    # Renomeação das colunas adicionais
    for original_name, new_name in additional_variables.items():
        df = df.withColumnRenamed(original_name, new_name)

    # Conversão do DataFrame para um DynamicFrame
    dynamic_frame = DynamicFrame.fromDF(df, glue_context, "dynamic_frame")

    # Definição do caminho do S3 para salvar os dados
    output_dir = "s3://dados-acs-bureau/raw/"

    # Gravação dos dados no S3 em formato Parquet
    glue_context.write_dynamic_frame.from_options(
        frame=dynamic_frame,
        connection_type="s3",
        connection_options={"path": output_dir},
        format="parquet"
    )

    # Finalização do job
    job.commit()
else:
    print(f'Erro na solicitação: {response.status_code}')
    print(response.text)

# Encerramento do contexto Spark
sc.stop()
