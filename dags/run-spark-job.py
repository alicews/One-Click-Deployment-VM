import airflow
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta
import os

## Define the DAG object
default_args = {
    'owner': 'alice',
    'depends_on_past': False,
    'start_date': airflow.utils.dates.days_ago(0),
    'retries': 5,
    'retry_delay': timedelta(minutes=5),
}
dag = DAG(dag_id='run-pyspark-dag', default_args=default_args, schedule_interval="@daily")

# task to submit Spark job
key = "MY_KEY.pem"
host =  'user@host.us-west-2.compute.amazonaws.com'
task1 = BashOperator(
    task_id='submit-spark',
    bash_command='ssh -i ' + key + ' ' + host +  'sh  "spark-submit mypyspark.py"',
    dag=dag)
