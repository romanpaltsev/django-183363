# Имя файла: Makefile

# Переменные
PYTHON = python3
MANAGE = $(PYTHON) manage.py

# Основные команды
run:
	$(MANAGE) runserver

migrate:
	$(MANAGE) migrate

makemigrations:
	$(MANAGE) makemigrations

createsuperuser:
	$(MANAGE) createsuperuser

shell:
	$(MANAGE) shell

collectstatic:
	$(MANAGE) collectstatic --noinput

test:
	$(MANAGE) test

# Удаление лишнего
clean:
	find . -name '*.pyc' -delete
	find . -name '__pycache__' -delete
	rm -rf staticfiles
