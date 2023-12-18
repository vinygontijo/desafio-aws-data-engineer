## Documentação do Projeto "Análise de Dados ACS 2019"

### Sumário
- [Visão Geral do Projeto](#visao-geral-do-projeto)
- [O que foi feito](#o-que-foi-feito)
- [Execução do Job](#execução-do-job)
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

5. **Criação de Banco de Dados e Tabelas**:
   - Banco de Dados: dw_acs
   - Tabelas: tb_raw

6. **Criação de Permissões de Usuários usando Lake Formation**:


<a id="execução-do-job"></a>
### Execução do Projeto
Para executar o projeto:
1. **Configuração Inicial com Terraform**:
   - Inicialize o Terraform no seu ambiente de desenvolvimento.
   - Configure os arquivos do Terraform para definir a infraestrutura AWS necessária, incluindo especificações para buckets S3 e o job AWS Glue.

2. **Aplicação da Infraestrutura**:
   - Execute `terraform apply` para provisionar os recursos na AWS.
   - O Terraform cria os buckets S3 e configura o job AWS Glue conforme definido.

3. **Execução Automática do Job AWS Glue**:
   - Após a criação, o Terraform dispara automaticamente o job AWS Glue.
   - O job Glue processa os dados da ACS, conforme definido no script PySpark.

4. **Armazenamento dos Dados Processados**:
   - Os dados processados são automaticamente armazenados nos buckets S3 em formato Parquet.

5. **Monitoramento e Manutenção**:
   - Monitore a execução e o desempenho do job através do console AWS Glue.
   - Realize ajustes conforme necessário, atualizando as configurações no Terraform e re-aplicando-as.


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


<a id="análise-de-negócios-e-novos-insights"></a>
### Análise de Negócios e Novos Insights
Este projeto, ao processar dados do ACS 2019, oferece insights cruciais para diversas esferas de decisão:   

<a id="planejamento-urbano"></a>
#### Planejamento Urbano
Dados sobre a idade das moradias e unidades habitacionais são vitais para identificar necessidades de renovação urbana ou desenvolvimento de novas habitações, auxiliando prefeituras e empresas de construção civil.


<a id="desenvolvimento-econômico"></a>
#### Desenvolvimento Econômico
A análise da renda média familiar e da força de trabalho ajuda a identificar mercados emergentes e áreas com potencial de crescimento, orientando estratégias de investimento empresarial.

<a id="políticas-públicas"></a>
#### Políticas Públicas
Informações sobre composição étnica e distribuição etária fundamentam a formulação de políticas sociais inclusivas, como programas de capacitação profissional baseados em dados de educação e desemprego.

<a id="estratégias-de-mercado"></a>
#### Estratégias de Mercado
A análise demográfica detalhada permite que empresas de marketing e varejo personalizem suas abordagens para atender às necessidades de diferentes grupos populacionais.

<a id="saúde-pública"></a>
#### Saúde Pública
Dados sobre distribuição etária e densidade populacional são essenciais no planejamento de serviços de saúde, como a localização de novos hospitais ou clínicas.

Este projeto transforma dados brutos em informações estratégicas para melhorar a qualidade de vida, estimular o crescimento econômico e promover a inclusão social.


<a id="estrutura-do-projeto"></a>
### Estrutura do Projeto
Este projeto utiliza Terraform para estruturar de forma eficiente a infraestrutura necessária na AWS, incluindo a criação de buckets S3 e a configuração do AWS Glue, facilitando a gestão e escalabilidade. Segue abaixo a estrutura de pastas do projeto.

<a id="contribuições"></a>
### Contribuições
Desenvolvido por: Vinícius Lucas Morais Gontijo.

