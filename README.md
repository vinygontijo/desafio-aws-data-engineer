## Documentação do Projeto "Análise de Dados ACS 2019"

### Sumário
- [Visão Geral do Projeto](#visao-geral-do-projeto)
- [O que foi feito](#o-que-foi-feito)
- [Execução do Job](#execução-do-job)
- [Modelo de Dados](#modelo-de-dados)
- [Linhagem dos Dados](#linhagem-dos-dados)
- [Componentes Principais do Projeto](#componentes-principais-do-projeto)
  - [Terraform](#terraform)
  - [AWS (Amazon Web Services)](#aws-amazon-web-services)
  - [Amazon S3 (Simple Storage Service)](#amazon-s3-simple-storage-service)
  - [AWS Glue Jobs](#aws-glue-jobs)
  - [AWS Glue Crawlers](#aws-glue-crawlers)
  - [AWS Glue Data Catalog](#aws-glue-data-catalog)
  - [AWS Lake Formation](#aws-lake-formation)
- [Consultas de Dados com Amazon Athena](#consultas-de-dados-com-amazon-athena)
- [Sobre os dados](#sobre-os-dados)
  - [Fonte de Dados: American Community Survey (ACS) 2019](#fonte-de-dados-american-community-survey-acs-2019)
  - [Colunas de Dados e Descrições Detalhadas](#colunas-de-dados-e-descrições-detalhadas)
- [Análise de Negócios e Novos Insights](#análise-de-negócios-e-novos-insights)
  - [Planejamento Urbano](#planejamento-urbano)
  - [Desenvolvimento Econômico](#desenvolvimento-econômico)
  - [Políticas Públicas](#políticas-públicas)
  - [Estratégias de Mercado](#estratégias-de-mercado)
  - [Saúde Pública](#saúde-pública)

- [Estrutura do Projeto](#estrutura-do-projeto)
- [Contribuições](#contribuições)


<a id="visao-geral-do-projeto"></a>
### Visão Geral do Projeto

Este projeto visa estabelecer uma infraestrutura de processamento de dados na AWS, utilizando Terraform para orquestrar a coleta e análise de dados socioeconômicos e demográficos da American Community Survey (ACS) de 2019.

<a id="o-que-foi-feito"></a>
### O que foi feito?

1. **Criação de 3 usuários**:
   - user_junior
   - user_develop
   - user_analitics

2. **Criação de Bucket e Zonas no s3**:
   - Bucket: dados-acs-bureau
   - Zona 1: raw/
   - Zona 2: enriched/
   - Zona 3: curated/   

3. **Criação de Jobs Glue**:
   - 00-job-glue-acs-bureau

4. **Criação de Crawlers**:
   - acs-bureau-crawler

5. **Criação de Banco de Dados e Tabelas no Data Catalog**:
   - Banco de Dados: dw_acs
   - Tabelas: tb_raw

6. **Criação de Permissões de Usuários usando Lake Formation**:
   - user_analytics
   - user_develop
   - user_junior

7. **Criação de Banco de dados Redshift**:
   - redshift-cluster

8. **Criação de VPC**:
   - RedshiftVPC

9. **Criação de Endpoint**:
   - Usado para o Job Glue

10. **Criação de Security Groups**:
   - redshift-sg 

11. **Criação de Conexão Glue com Redshift**
   - redshift-connection

12. **Criação de Subnets**:
   - RedshiftSubnet1
   - RedshiftSubnet2

   
13. **Criação de função lambda**:
   - lambda_redshift_execute_sql (Objetivo criar tableas no Redshift)



<a id="execução-do-job"></a>
### Execução do Projeto
#### Pré-requisitos

- Terraform v0.12+ instalado ([como instalar](https://learn.hashicorp.com/tutorials/terraform/install-cli))
- Credenciais da AWS configuradas localmente ([guia de configuração](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html))
- Conhecimento básico de Terraform e AWS

#### Configuração de Credenciais AWS

Antes de executar este projeto, você deve configurar suas credenciais da AWS. Você pode fazer isso de duas maneiras:

1. Configurando um perfil no arquivo `~/.aws/credentials` no seu sistema:

      [default]
      aws_access_key_id = <SEU_ACCESS_KEY_ID>
      aws_secret_access_key = <SEU_SECRET_ACCESS_KEY>

2. Definindo variáveis de ambiente:

No Windows (PowerShell):

      $env:AWS_ACCESS_KEY_ID="<SEU_ACCESS_KEY_ID>"
      $env:AWS_SECRET_ACCESS_KEY="<SEU_SECRET_ACCESS_KEY>"

3. No Unix ou macOS (bash):

      export AWS_ACCESS_KEY_ID="<SEU_ACCESS_KEY_ID>"
      export AWS_SECRET_ACCESS_KEY="<SEU_SECRET_ACCESS_KEY>"

4. Permissão para execução do Docker pelo Terraform:

   sudo usermod -aG docker ${USER}

5. Inicializando o Terraform:

      terraform init

6. Planejando as Mudanças

Para criar um plano de execução e visualizar as alterações que serão aplicadas, execute:

      terraform plan

7. Aplicando as Mudanças

Para aplicar as alterações previstas pelo plano e criar recursos na AWS, execute:

      terraform apply

8. Destruindo os Recursos

      terraform destroy

9. Executar job glue:

Após criar os rescursos você pode executar o job glue criado abaixo:

      00-job-glue-acs-bureau

10. Conferir dados no Bucket:

Após executar o job glue você pode conferir os dados no bucket:
   
      dados-acs-bureau     

<a id="modelo-de-dados"></a>
### Modelo de Dados

Abaixo está o modelo de dados criado para ultilização do cliente final. Esses dados já estão processados e tratados.

![Modelagem do Banco de Dados](/imagens/modelagem.png)

<a id="linhagem-dos-dados"></a>
### Linhagem dos Dados

| Origem               | Enriched                          | Curated                                  |
|----------------------|-----------------------------------|------------------------------------------|
| NAME                 | area_geografica                   | TB_AREA_GEOGRAFICA                       |
| B01001_001E          | total_residentes                  | QTD_TOTAL_RESIDENTES                     |
| B01002_001E          | media_idade                       | VL_MEDIA_IDADE                           |
| B19013_001E          | renda_media_familias              | VL_RENDA_MEDIA_FAMILIAS                  |
| B19301_001E          | renda_per_capita                  | VL_RENDA_PER_CAPITA                      |
| B25077_001E          | valor_mediano_imoveis             | VL_MEDIANO_IMOVEIS                       |
| B25064_001E          | aluguel_medio                     | VL_ALUGUEL_MEDIO                         |
| B15003_002E          | nivel_educacao                    | COD_NIVEL_EDUCACAO                       |
| B23025_002E          | tamanho_forca_trabalho            | NR_TAMANHO_FORCA_TRABALHO                |
| B23025_005E          | numero_desempregados              | QTD_DESEMPREGADOS                        |
| B25035_001E          | idade_media_moradias              | NR_IDADE_MEDIA_MORADIAS                  |
| B25058_001E          | aluguel_contratual_medio          | VL_ALUGUEL_CONTRATUAL_MEDIO              |
| B25071_001E          | percentual_renda_aluguel          | VL_PERCENTUAL_RENDA_ALUGUEL              |
| B25001_001E          | total_unidades_habitacionais      | QTD_TOTAL_UNIDADES_HABITACIONAIS         |
| B25002_003E          | moradias_ocupadas_proprietarios   | QTD_MORADIAS_OCUPADAS_PROPRIETARIOS      |
| B11001_001E          | total_domicilios                  | QTD_TOTAL_DOMICILIOS                     |
| B01003_001E          | populacao_total                   | QTD_POPULACAO_TOTAL                      |
| B02001_002E          | populacao_branca                  | QTD_POPULACAO_BRANCA                     |
| B03003_003E          | populacao_hispanica_latina        | QTD_POPULACAO_HISPANICA_LATINA           |
| B02001_003E          | populacao_negra_afro_americana    | QTD_POPULACAO_NEGRA_AFRO_AMERICANA       |
| county               | codigo_condado                    | COD_CONDADO                              |
| state                | codigo_estado                     | COD_ESTADO                               |
| tract                | codigo_tracto                     | COD_TRACTO                               |


<a id="componentes-principais-do-projeto"></a>
### Componentes Principais do Projeto

<a id="terraform"></a>
#### Terraform
- **Descrição**: Ferramenta de infraestrutura como código (IaC) para provisionar e gerenciar recursos na AWS.
- **Utilização**: Definição declarativa da infraestrutura, facilitando o versionamento e a colaboração.

<a id="aws-amazon-web-services"></a>
#### AWS (Amazon Web Services)
- **Descrição**: Provedor de serviços em nuvem que hospeda a infraestrutura do projeto.
- **Serviços Utilizados**: Conjunto de serviços para construir um pipeline de dados ETL eficiente, seguro e escalável.

<a id="amazon-s3-simple-storage-service"></a>
#### Amazon S3 (Simple Storage Service)
- **Descrição**: Serviço de armazenamento em nuvem para hospedar dados extraídos e transformados.
- **Benefícios**: Durabilidade, disponibilidade e escalabilidade no armazenamento de dados.

<a id="aws-glue-jobs"></a>
#### AWS Glue Jobs
- **Descrição**: Serviço que executa tarefas de ETL escritas em PySpark.
- **Função**: Extração, transformação e carregamento dos dados da ACS para o S3.


<a id="aws-glue-crawlers"></a>
#### AWS Glue Crawlers
- **Descrição**: Ferramenta que realiza a descoberta automática e catalogação de dados.
- **Função**: Identificação de esquemas e população do Data Catalog com metadados.

<a id="aws-glue-data-catalog"></a>
#### AWS Glue Data Catalog
- **Descrição**: Repositório centralizado para metadados de ativos de dados.
- **Integração**: Facilita a descoberta e o acesso a dados pelo Amazon Athena e outros serviços analíticos.

<a id="aws-lake-formation"></a>
#### AWS Lake Formation
- **Descrição**: Serviço para gerenciar segurança e acesso ao Data Lake.
- **Capacidades**: Simplificação do controle de permissões e governança de dados.

<a id="consultas-de-dados-com-amazon-athena"></a>
### Consultas de Dados com Amazon Athena
Os dados organizados no Data Catalog podem ser consultados utilizando o Amazon Athena, que oferece a execução de consultas SQL diretamente sobre os conjuntos de dados no S3.

<a id="sobre-os-dados"></a>
### Sobre os dados

<a id="fonte-de-dados-american-community-survey-acs-2019"></a>
### Fonte de Dados: American Community Survey (ACS) 2019
Os dados são obtidos da [American Community Survey (ACS) 2019](https://api.census.gov/data/2019/acs/acs5), uma pesquisa anual conduzida pelo U.S. Census Bureau. A ACS coleta informações detalhadas sobre a população dos Estados Unidos, abordando aspectos como educação, emprego, renda e características habitacionais. Esses dados são fundamentais para análises aprofundadas sobre as condições de vida e tendências socioeconômicas nos EUA.

<a id="colunas-de-dados-e-descrições-detalhadas"></a>
### Colunas de Dados e Descrições Detalhadas
- **NAME**: Identifica a área geográfica, crucial para análises regionais específicas.
- **B01001_001E**: Contagem total de residentes, essencial para entender a densidade populacional e alocar recursos de forma eficiente.
- **B01002_001E**: Média de idade, indicador importante do perfil demográfico, afetando desde políticas públicas a mercados consumidores.
- **B19013_001E**: Renda média das famílias, indicativo do poder de compra e saúde econômica da região.
- **B19301_001E**: Renda per capita, útil para avaliar o padrão de vida individual.
- **B25077_001E**: Valor mediano de imóveis ocupados pelos proprietários, refletindo o mercado imobiliário local.
- **B25064_001E**: Aluguel médio, indicador do custo de vida na área, particularmente em relação à habitação.
- **B15003_002E**: Nível de educação, importante para entender as qualificações da força de trabalho local.
- **B23025_002E**: Tamanho da força de trabalho, refletindo o potencial produtivo e econômico da área.
- **B23025_005E**: Número de desempregados, essencial para avaliar a saúde do mercado de trabalho.
- **B25035_001E**: Idade média de moradias, indicando a necessidade de renovação ou manutenção do parque habitacional.
- **B25058_001E**: Aluguel contratual médio, informação valiosa para quem busca moradia na região.
- **B25071_001E**: Porcentagem da renda familiar gasta com aluguel, indicativo da acessibilidade habitacional.
- **B25001_001E**: Número total de unidades habitacionais, essencial para planejamento urbano e de infraestrutura.
- **B25002_003E**: Quantidade de moradias ocupadas pelos proprietários, refletindo a estabilidade e investimento em propriedades.
- **B11001_001E**: Total de domicílios, importante para análises de mercado e serviços públicos.
- **B01003_001E**: População total (repetida, considerar remoção para evitar redundância).
- **B02001_002E**: Quantidade de indivíduos brancos, importante para análises demográficas e de diversidade.
- **B03003_003E**: População hispânica ou latina, essencial para compreender a composição étnica e cultural.
- **B02001_003E**: População negra ou afro-americana, chave para análises de diversidade e inclusão social.
- **county**: Código do condado dentro do estado, fundamental para análises geográficas detalhadas e planejamento regional.
- **state**: Código do estado, crucial para identificar a localização geográfica e realizar comparações entre diferentes regiões.
- **tract**: Código do setor censitário, essencial para estudos e planejamentos urbanos detalhados ao nível de bairro ou comunidade.

