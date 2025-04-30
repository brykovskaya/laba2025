import pandas as pd
import matplotlib.pyplot as plt

data = pd.read_csv("data_month.csv")
print('Информация о датафрейме:\n\
===========================================')
print(data.info())
print('\nданные:\n===========================================')
print(data)
plt.rcParams['figure.figsize'] = [12, 4]
plt.plot(data['month_id'],
         data['amount'], 
         color='red',
         alpha=0.7,
         marker='o', 
         linestyle='-',
         linewidth = 3)
plt.grid(alpha = 0.3, color = 'grey')
plt.xlabel('Месяц')
plt.ylabel('Продажи')
plt.title('Продажи по месяцам')

plt.savefig("graph.png")

print('The end')