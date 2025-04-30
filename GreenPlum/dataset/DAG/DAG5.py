from airflow import DAG
from airflow.operators.dummy import DummyOperator
from airflow.operators.email import EmailOperator
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago
def failing_task():
    raise Exception("This task is intended to fail.")
default_args = {
    'owner': 'airflow',
    'start_date': days_ago(1),
    'email_on_failure': True,
    'email': ['your_email@example.com'],  # Укажите свой адрес электронной почты
}
dag = DAG('notification_dag', default_args=default_args, schedule_interval='@daily')
start = DummyOperator(task_id='start', dag=dag)
failing_task = PythonOperator(
    task_id='failing_task',
    python_callable=failing_task,
    dag=dag,
)
send_email = EmailOperator(
    task_id='send_email',
    to='your_email@example.com',
    subject='Airflow Task Failed',
    html_content='The task has failed!',
    dag=dag,
)
start >> failing_task >> send_email