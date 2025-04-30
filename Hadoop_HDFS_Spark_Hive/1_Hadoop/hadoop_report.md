# Компоненты и архитектурные особенности кластера Hadoop

Hadoop лучше всего подходит:

Для хранения и обработки неструктурированных данных объемом от одного терабайта — такие массивы сложно и дорого хранить в локальном хранилище.
Для компонуемых вычислений — когда нужно собрать множество схожих разрозненных данных в одно целое. Также подходит для выделения полезной информации из массива лишней.
Для пакетной обработки, обогащения данных и ETL — извлечения информации из внешних источников, ее переработки и очистки под потребности компании, последующей загрузки в базу данных.
## Упражнение - Введение в Hadoop (локально на вашем ПК)

1. Установите Hadoop через Docker Compose.
2. Ознакомьтесь с компонентами Hadoop, запустив примеры задач MapReduce.

Это упражнение поможет вам настроить кластер Hadoop с помощью Docker Compose и запустить примеры задач MapReduce.

### Решение

1. Папка для примера и переменные окружения:<br>
Создайте папку hdp и перейдите в нее (cmd)

 - `mkdir hdp`
 - `cd hdp`

![](./images/1.png)<br>
Создайте файл переменного окружения [hadoop.env](./files/hadoop.env) <br>
2. Создайте файл [docker-compose.yml](./files/docker-compose.yml )<br>
![](./images/2.png)<br>
Запускаю Docker desktop<br>

3. Запуск кластера Hadoop:
в директории с файлом docker-compose.yml и выполните команду:

`docker-compose up -d`<br>
Эта команда запустит кластер Hadoop в фоновом режиме.
![](./images/3.png)<br>
4. Проверка работоспособности:
Проверьте, что все контейнеры запущены и работают:

`docker-compose ps`<br>
Вы должны увидеть запущенныe контейнера.
![](./images/4.png)<br>
5. Запуск примера задачи MapReduce:<br>
5.1. Подключитесь к контейнеру namenode:<br>
`docker-compose exec namenode bash`<br>
`cd /opt/hadoop-2.7.1`<br>
`hdfs dfs -mkdir /user`<br>
`hdfs dfs -mkdir /user/root`<br>
`hdfs dfs -ls /`<br>
5.2. Создайте директории в HDFS:<br>
`hdfs dfs -mkdir input`<br>
5.3. Скопируйте пример данных в HDFS:<br>
`hdfs dfs -put etc/hadoop/*.xml input`<br>
`hdfs dfs -ls input`<br>
![](./images/5.png)<br>
5.4. Запустите пример задачи:<br>
`hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar grep input output 'dfs[a-z.]+'`<br>
![](./images/6.png)<br>
5.5. Просмотрите результаты:<br>
`hdfs dfs -ls output`<br>
`hdfs dfs -cat output/*`<br>
![](./images/7.png)<br>

(можно также удалить файлы и папки)
`hdfs dfs -rm input/* `<br>
`hdfs dfs -rmdir input/`<br>
`hdfs dfs -rm output/*`<br>
`hdfs dfs -rmdir output/`<br>
![](./images/8.png)<br>
6. Остановка кластера Hadoop:<br>
`exit`<br>
`docker-compose down`<br>
![](./images/9.png)<br>
данные останутся в volumes (Docker) и будут видны при создании нового кластера