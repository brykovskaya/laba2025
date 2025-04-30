from flask import Flask
import random

app = Flask(__name__)

# Список случайных ответов
roshambo = [
    "Камень",
    "Ножницы",
    "Бумага"
]

@app.route("/")
def roshambo_game():
    # Возвращаем случайный ответ
    roshambo_choice = 'Камень… Ножницы… Бумага… Раз… Два… Три... Цу!Е!Фа! - ' + random.choice(roshambo)
    return roshambo_choice

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)