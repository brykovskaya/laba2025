from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago
def calculate_and_write():
    a = 10
    b = 5
    sum_result = a + b
    diff_result = a - b
    
    with open('/path/to/results.txt', 'w') as f:
        f.write(f'Sum: {sum_result}\n')
        f.write(f'Difference: {diff_result}\n')
default_args = {
    'owner': 'airflow',
    'start_date': days_ago(1),
}
dag = DAG('python_operator_dag', default_args=default_args, schedule_interval='@daily')
calculate_task = PythonOperator(
    task_id='calculate_and_write',
    python_callable=calculate_and_write,
    dag=dag,
)