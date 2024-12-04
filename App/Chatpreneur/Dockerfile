FROM python:3.9

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir --upgrade -r requirements.txt

CMD ["fastapi", "run", "src/routes.py", "--port", "80"]