FROM python:3.7.9-alpine
RUN pip install flask==1.1.2 wtforms==2.3.3 flask_wtf==0.14.3
WORKDIR /app
COPY app /app
CMD ["python","programa.py"]

# Luego: 
# sudo docker volume create mivolumen
# sudo docker build -t nahuic/miprograma:1.0 .
# sudo docker run --name formulario -v mivolumen:/app/data nahuic/miprograma:1.0

# sudo docker run -it 