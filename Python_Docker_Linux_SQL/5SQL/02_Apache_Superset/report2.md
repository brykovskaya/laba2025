## Упр. - Знакомство с интерфейсом
Запущен Superset в контейнере Docker по инструкции.

логин/пароль `admin/admin`

результат

![](../images/02_01.png)

## Упр. - подключение к PostgreSQL 
Соберите информацию о подключении:
-Host: адрес сервера базы данных
-Port: порт (по умолчанию 5432)
-Database: имя базы данных
-Username: имя пользователя
-Password: пароль

В Superset перейдите в раздел "Data" -> "Databases" и нажмите "+ Database".
 - Выберите "PostgreSQL" из списка.
 - Введите информацию о подключении:
 - Database Connection URI: используйте формат:

`postgresql://username:password@host:port/database`

`SQLAlchemy URI: альтернативный способ указания параметров (подробности в документации SQLAlchemy https://docs.sqlalchemy.org/en/20/)`

Настройте дополнительные параметры (опционально): таймауты, кодировки и др.

Нажмите "Test Connection", чтобы проверить подключение.


Дополнительные советы:

 - Используйте SSH туннелирование для безопасного подключения к базам данных, расположенным за firewall.
 - Настройте пулы соединений для оптимизации производительности при частых запросах к базе данных.
 - Регулярно проверяйте состояние подключений к источникам данных.

**решение**

Для подключения к суперсету:
```
`cd /home/viki/superset`
`docker compose -f docker-compose-non-dev.yml up -d`
```
На Убунту была установлена база данных `PostgreSQL: apt install postgresql postgresql-contrib`
База данных была запущена:` sudo -u postgres psql`
Основной роли присвоили пароль: `ALTER USER postgres WITH PASSWORD 'passWord';`
После чего перешли на сайт` http://localhost:8088/ и ввели пароль admin admin`
Добавили базу данных PostgreSQL со следующей информацией о подключении:
```
-Host: host.docker.internal
-Port: 5432
-Database: postgres
-Username: postgres
-Password: passWord
```

`Для SQLAlchemy URI: postgresql://postgres:passWord@host.docker.internal:5432/postgres`

![](../images/02_03.png)<br>
![](../images/02_04.png)<br>
### Упр. - Пример запроса в SQL Lab  
Давайте рассмотрим пример запроса в SQL Lab на основе демонстрационной базы данных Superset. 

Superset поставляется с тестовой базой данных examples. В ней есть таблица birth_names, содержащая информацию о количестве рождений по годам, штатам США и полу.  

Задача:
 - Вывести топ-5 самых популярных имен девочек, родившихся в штате Калифорния (CA) в 1980 году.  
```
--SQL-запрос:
SELECT
  name,
  SUM(num) AS total_births
FROM birth_names
WHERE state = 'CA'
  AND gender = 'girl'
  AND date_part('year', ds) = 1980
GROUP BY name
ORDER BY total_births
DESC LIMIT 5;
```

![](../images/02_02.png)