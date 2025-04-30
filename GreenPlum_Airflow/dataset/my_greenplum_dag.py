from airflow import DAG
from airflow.operators.postgres_operator import PostgresOperator
from airflow.utils.dates import days_ago
# Определение аргументов по умолчанию
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': days_ago(1),
    'retries': 1,
}
# Создание DAG
dag = DAG('greenplum_data_pipeline', default_args=default_args, schedule_interval='@daily')
# Задача для создания таблицы в Greenplum
create_table = PostgresOperator(
    task_id='create_table',
    postgres_conn_id='greenplum_conn',  # ID соединения для Greenplum, его нужно настроить
    sql="""
    CREATE TABLE IF NOT EXISTS analytics_data (
        id SERIAL PRIMARY KEY,
        category VARCHAR(50),
        value FLOAT
    );
    """,
    dag=dag,
)
# Задача для вставки данных в таблицу
insert_data = PostgresOperator(
    task_id='insert_data',
    postgres_conn_id='greenplum_conn',
    sql="""
    INSERT INTO analytics_data (category, value) VALUES
    ('category1', 100),
    ('category2', 200),
    ('category3', 300);
    """,
    dag=dag,
)
# Определение порядка выполнения задач
create_table >> insert_data