import sys
import requests
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.dynamicframe import DynamicFrame

## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

# Inicialização do Contexto Spark e Glue
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
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
# Construir a string de variáveis para a URL
variables_str = ",".join(variables.keys())

# Especificar um estado para a consulta (exemplo: California, código de estado 06)
state_code = "06"

# URL da API para dados a nível de trato do censo em um estado específico
url = f"https://api.census.gov/data/2019/acs/acs5?get={variables_str}&for=tract:*&in=state:{state_code}"

# Fazer a requisição para a API e obter os dados
response = requests.get(url)

# Verificar se a resposta da API foi bem-sucedida
if response.status_code == 200:
    data = response.json()
    headers = data[0]
    rows = data[1:]

    # Cria um RDD de dicionários, onde cada dicionário representa uma linha de dados
    rdd = sc.parallelize([dict(zip(headers, row)) for row in rows])
	
	# Converte o RDD para um DataFrame
    df = spark.createDataFrame(rdd)

    # Renomear as colunas
    for original_name, new_name in variables.items():
        df = df.withColumnRenamed(original_name, new_name)
    
    # Converte o RDD para um DynamicFrame
    dynamic_frame = DynamicFrame.fromDF(df, glueContext, "dynamic_frame")    
    
    # Definir o caminho do S3 para salvar os dados
    output_dir = "s3://letrus-educacao-pdde-teste/raw/"

    # Gravar os dados no S3 em formato Parquet
    glueContext.write_dynamic_frame.from_options(
        frame = dynamic_frame,
        connection_type = "s3",
        connection_options = {"path": output_dir},
        format = "parquet"
    )

    # Finalizar o job
    job.commit()
else:
    print(f'Erro ao fazer a solicitação: {response.status_code}')
    print(response.text)

# Encerrar o contexto Spark
sc.stop()