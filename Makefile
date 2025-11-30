# ================== SETTINGS ==================
VENV := venv
PYTHON := $(VENV)/bin/python
PIP := $(VENV)/bin/pip
MANAGE := $(PYTHON) manage.py

# ================== HELP ==================
.PHONY: help
help: ## Показать список команд
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## ' Makefile | sed 's/:.*## / — /'

# ================== PHONY TARGETS ==================
.PHONY: venv install activate dev sh reinit run migrate makemigrations superuser shell test lint fmt fmt-check freeze clean

# ================== CREATE VENV ==================
venv: ## Создать виртуальное окружение
	python3 -m venv $(VENV)

# ================== ACTIVATE VENV ==================
activate: ## Показать команду активации виртуального окружения
	@echo "source $(VENV)/bin/activate"

# ================== DEV MODE ==================
dev: ## Активировать venv и запустить Django сервер
	@bash --rcfile <(echo "source $(VENV)/bin/activate; $(MANAGE) runserver")

# ================== INTERACTIVE SHELL INSIDE VENV ==================
sh: ## Открыть интерактивный shell внутри виртуального окружения
	@bash --rcfile <(echo "source $(VENV)/bin/activate")

# ================== REINIT VENV ==================
reinit: ## Пересоздать окружение и установить зависимости
	rm -rf $(VENV)
	python3 -m venv $(VENV)
	$(PIP) install --upgrade pip
	if [ -f requirements.txt ]; then $(PIP) install -r requirements.txt; fi

# ================== INSTALL DEPENDENCIES ==================
install: venv ## Установить зависимости
	$(PIP) install --upgrade pip
	if [ -f requirements.txt ]; then $(PIP) install -r requirements.txt; fi

# ================== RUN ==================
run: ## Запустить Django сервер
	$(MANAGE) runserver

# ================== MIGRATIONS ==================
migrate: ## Применить миграции
	$(MANAGE) migrate

makemigrations: ## Создать миграции
	$(MANAGE) makemigrations

# ================== SUPERUSER ==================
superuser: ## Создать суперпользователя
	$(MANAGE) createsuperuser

# ================== DJANGO SHELL ==================
shell: ## Открыть Django shell
	$(MANAGE) shell

# ================== TESTS ==================
test: ## Запустить тесты Django
	$(MANAGE) test

# ================== LINT ==================
lint: ## Проверить стиль через ruff
	$(PYTHON) -m ruff . || true

# ================== FORMAT ==================
fmt: ## Форматировать код с помощью black
	$(PYTHON) -m black .

fmt-check: ## Проверить форматирование black (без изменений)
	$(PYTHON) -m black . --check

# ================== FREEZE DEPENDENCIES ==================
freeze: ## Сохранить зависимости в requirements.txt
	$(PIP) freeze > requirements.txt

# ================== CLEAN ==================
clean: ## Очистить проект
	rm -rf __pycache__ */__pycache__ .pytest_cache $(VENV)