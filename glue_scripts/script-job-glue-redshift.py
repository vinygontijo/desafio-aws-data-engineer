import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

# Inicialização
args = getResolvedOptions(sys.argv, ["JOB_NAME"])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args["JOB_NAME"], args)

# Leitura dos dados de origem
AmazonS3_node1702936753845 = glueContext.create_dynamic_frame.from_catalog(
    database="dw_acs",
    table_name="tb_raw",
    transformation_ctx="AmazonS3_node1702936753845",
)

# Mapeamento de campos (ajustar os nomes e tipos conforme necessário)
ChangeSchema_node1702935636492 = ApplyMapping.apply(
    frame=AmazonS3_node1702936753845,
    mappings=[
        ("renda_media_familias", "string", "VL_RENDA_MEDIA_FAMILIAS", "decimal(10,2)"),
        ("renda_per_capita", "string", "VL_RENDA_PER_CAPITA", "decimal(10,2)"),
    ],
    transformation_ctx="ChangeSchema_node1702935636492",
)

# Inserção dos dados na tabela do Redshift
# Atenção: Removido o 'preactions' para evitar a recriação da tabela
AmazonRedshift_node1702935677460 = glueContext.write_dynamic_frame.from_options(
    frame=ChangeSchema_node1702935636492,
    connection_type="redshift",
    connection_options={
        "redshiftTmpDir": "s3://aws-glue-assets-763589538001-us-east-1/temporary/",
        "useConnectionProperties": "true",
        "dbtable": "public.tb_economia",
        "connectionName": "Redshift connection"
    },
    transformation_ctx="AmazonRedshift_node1702935677460",
)

job.commit()
