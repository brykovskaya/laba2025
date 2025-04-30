from flask import Flask
import random

app = Flask(__name__)

# Список случайных ответов
roshambo = [
    "Камень",
    "Бумага",
    "Ножницы"
  ]

@app.route("/")
def roshambo_game():
    # Возвращаем случайный ответ
    roshambo_choice = 'Камень… Ножницы… Бумага… Раз… Два… Три... Су-ли-фа! - ' + random.choice(roshambo)
    return roshambo_choice

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001)