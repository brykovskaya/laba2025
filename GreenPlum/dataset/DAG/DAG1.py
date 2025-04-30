from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.utils.dates import days_ago
default_args = {
    'owner': 'airflow',
    'start_date': days_ago(1),
    'retries': 1,
}
dag = DAG('complex_dag', default_args=default_args, schedule_interval='@daily')
# Загрузка данных
download_data = BashOperator(
    task_id='download_data',
    bash_command='hdfs dfs -get hdfs://namenode:9000/path/to/input.csv /path/to/local/input.csv',
    dag=dag,
)
# Обработка данных
process_data = BashOperator(
    task_id='process_data',
    bash_command='python /path/to/your_script.py',
    dag=dag,
)
# Сохранение данных
save_data = BashOperator(
    task_id='save_data',
    bash_command='hdfs dfs -put /path/to/local/output.csv hdfs://namenode:9000/path/to/output.csv',
    dag=dag,
)
download_data >> process_data >> save_data
