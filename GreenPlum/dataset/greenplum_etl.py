from datetime import datetime, timedelta
from airflow import DAG
from airflow.providers.postgres.operators.postgres import PostgresOperator
from airflow.operators.python import PythonOperator
from sqlalchemy import create_engine
import pandas as pd

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2023, 1, 1),
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

def process_data():
    # Подключение к Greenplum через SQLAlchemy
    engine = create_engine('postgresql://username:password@host:5432/dbname')
    
    # Чтение данных из Greenplum
    df = pd.read_sql('SELECT * FROM analytics_data', con=engine)
    
    # Пример преобразования данных
    df['new_value'] = df['value'] * 2
    
    # Сохранение обратно в Greenplum
    df.to_sql('processed_data', con=engine, if_exists='replace', index=False)

with DAG(
    'greenplum_etl',
    default_args=default_args,
    schedule_interval='@daily',
    catchup=False,
) as dag:

    extract_data = PostgresOperator(
        task_id='extract_data',
        postgres_conn_id='greenplum_conn',
        sql="""
        CREATE TABLE IF NOT EXISTS temp_analytics AS
        SELECT * FROM analytics_data
        WHERE date = '{{ ds }}';
        """
    )

    transform_data = PythonOperator(
        task_id='transform_data',
        python_callable=process_data
    )

    load_data = PostgresOperator(
        task_id='load_data',
        postgres_conn_id='greenplum_conn',
        sql="""
        INSERT INTO processed_data_final
        SELECT * FROM processed_data
        WHERE date = '{{ ds }}';
        """
    )

    extract_data >> transform_data >> load_data