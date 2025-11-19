FROM python:3.11-slim

WORKDIR /app

COPY project/diagnostic-be/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY project/diagnostic-be/app.py ./app.py

ENV DB_HOST=mysql
ENV DB_USER=root
ENV DB_PASSWORD=
ENV FRONTEND_ORIGIN=http://localhost:5173

EXPOSE 5000

CMD ["python", "app.py"]

