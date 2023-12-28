# Usar uma imagem base do Python
FROM python:3.9

# Instalar o Boto3
RUN pip install boto3

# Copiar o script Python para o container
COPY create_redshift_table.py /create_redshift_table.py

# Definir o comando padrão
CMD ["python", "/create_redshift_table.py"]