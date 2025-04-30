import random
from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago
def generate_random_number(**kwargs):
    random_number = random.randint(1, 100)
    kwargs['ti'].xcom_push(key='random_number', value=random_number)
def multiply_random_number(**kwargs):
    ti = kwargs['ti']
    random_number = ti.xcom_pull(key='random_number', task_ids='generate_random_number')
    result = random_number * 2
    print(f'Multiplied value: {result}')
default_args = {
    'owner': 'airflow',
    'start_date': days_ago(1),
}
dag = DAG('xcom_dag', default_args=default_args, schedule_interval='@daily')
generate_task = PythonOperator(
    task_id='generate_random_number',
    python_callable=generate_random_number,
    provide_context=True,
    dag=dag,
)
multiply_task = PythonOperator(
    task_id='multiply_random_number',
    python_callable=multiply_random_number,provide_context=True,
    dag=dag,
)
generate_task >> multiply_task