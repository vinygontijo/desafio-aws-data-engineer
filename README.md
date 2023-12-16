## Documentação do Projeto "Análise de Dados ACS 2019"

### Visão Geral do Projeto
O projeto "Análise de Dados ACS 2019" foi desenvolvido para processar e analisar dados socioeconômicos e demográficos coletados pela American Community Survey (ACS) do ano de 2019. Utilizando o poder do AWS Glue e a eficiência do Terraform, o projeto visa extrair insights valiosos para tomada de decisões em diversos setores.

### Fonte de Dados: American Community Survey (ACS) 2019
Os dados são obtidos da [American Community Survey (ACS) 2019](https://api.census.gov/data/2019/acs/acs5), uma pesquisa anual conduzida pelo U.S. Census Bureau. A ACS coleta informações detalhadas sobre a população dos Estados Unidos, abordando aspectos como educação, emprego, renda e características habitacionais. Esses dados são fundamentais para análises aprofundadas sobre as condições de vida e tendências socioeconômicas nos EUA.


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

  
### Análise de Negócios e Novos Insights
Este projeto, ao processar dados do ACS 2019, oferece insights cruciais para diversas esferas de decisão:   

#### Planejamento Urbano
Dados sobre a idade das moradias e unidades habitacionais são vitais para identificar necessidades de renovação urbana ou desenvolvimento de novas habitações, auxiliando prefeituras e empresas de construção civil.

#### Desenvolvimento Econômico
A análise da renda média familiar e da força de trabalho ajuda a identificar mercados emergentes e áreas com potencial de crescimento, orientando estratégias de investimento empresarial.

#### Políticas Públicas
Informações sobre composição étnica e distribuição etária fundamentam a formulação de políticas sociais inclusivas, como programas de capacitação profissional baseados em dados de educação e desemprego.

#### Estratégias de Mercado
A análise demográfica detalhada permite que empresas de marketing e varejo personalizem suas abordagens para atender às necessidades de diferentes grupos populacionais.

#### Saúde Pública
Dados sobre distribuição etária e densidade populacional são essenciais no planejamento de serviços de saúde, como a localização de novos hospitais ou clínicas.

Este projeto transforma dados brutos em informações estratégicas para melhorar a qualidade de vida, estimular o crescimento econômico e promover a inclusão social.

### Execução do Job
Para executar o job:
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

### Infraestrutura e Configurações
Este projeto utiliza Terraform para estruturar de forma eficiente a infraestrutura necessária na AWS, incluindo a criação de buckets S3 e a configuração do AWS Glue, facilitando a gestão e escalabilidade.


### Contribuições
Desenvolvido por: Vinícius Lucas Morais Gontijo.

