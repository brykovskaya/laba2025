from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from airflow.providers.postgres.operators.postgres import PostgresOperator
from airflow.utils.dates import days_ago
def process_data():
    # Ваша логика обработки данных
    pass
default_args = {
    'owner': 'airflow',
    'start_date': days_ago(1),
}
dag = DAG('mixed_operators_dag', default_args=default_args, schedule_interval='@daily')
download_data = BashOperator(
    task_id='download_data',
    bash_command='hdfs dfs -get hdfs://namenode:9000/path/to/input.csv /path/to/local/input.csv',
    dag=dag,
)
process_data_task = PythonOperator(
    task_id='process_data',
    python_callable=process_data,
    dag=dag,
)
save_to_postgres = PostgresOperator(
    task_id='save_to_postgres',
    postgres_conn_id='postgres_default',  # Убедитесь, что соединение настроено
    sql='INSERT INTO your_table (col1, col2) VALUES (value1, value2);',
    dag=dag,
)
download_data >> process_data_task >> save_to_postgres