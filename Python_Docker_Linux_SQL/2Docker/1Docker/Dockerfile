FROM python:3.9

WORKDIR /app
RUN pip install pandas matplotlib

COPY analyze.py /app/
COPY data_month.csv /app/

CMD ["python", "analyze.py"]
