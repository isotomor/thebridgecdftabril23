FROM python:3.7-alpine
RUN pip install Flask wtforms==2.3.3 flask_wtf==0.14.3 redis
COPY app /app
WORKDIR /app

CMD ["python","app.py"]

# docker run --name redis -p 6379:6379 redis:3.2.0
# docker build -t isotomor/dapp3:1.0 .
# sudo docker run --name docker_app_python -p 5000:5000 --link redis isotomor/dapp3:1.0