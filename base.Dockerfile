# Образ на основе которого будет создан контейнер
FROM --platform=linux/amd64 ubuntu-base:18.04

LABEL maintainer="Vladislav Nagaev <vladislav.nagaew@gmail.com>"

# Изменение рабочего пользователя
USER root

# Выбор рабочей директории
WORKDIR /

ENV \ 
    # --------------------------------------------------------------------------
    # Задание версий сервисов
    # --------------------------------------------------------------------------
    PYTHON_VERSION=3.8
    # --------------------------------------------------------------------------

ENV \
    # --------------------------------------------------------------------------
    # Полные наименования сервисов
    # --------------------------------------------------------------------------
    PYTHON_NAME=python${PYTHON_VERSION} \
    # --------------------------------------------------------------------------
    # --------------------------------------------------------------------------
    # Переменные окружения для Python 
    # --------------------------------------------------------------------------
    # - не создавать файлы кэша .pyc, 
    PYTHONDONTWRITEBYTECODE=1 \
    # - не помещать в буфер потоки stdout и stderr
    PYTHONUNBUFFERED=1 \
    # - установить фиксированное начальное число для генерации hash() типов, охватываемых рандомизацией хэша
    PYTHONHASHSEED=1 \
    # - отключить проверку версии pip
    PIP_DISABLE_PIP_VERSION_CHECK=1 
    # --------------------------------------------------------------------------

# Копирование файлов проекта
COPY ./requirements.txt /tmp/requirements.txt

RUN \
    # --------------------------------------------------------------------------
    # Установка Python3.8
    # https://linuxize.com/post/how-to-install-python-3-8-on-ubuntu-18-04/
    # --------------------------------------------------------------------------
    # add the repository
    add-apt-repository 'ppa:deadsnakes/ppa' && \
    # Обновление путей
    apt --yes update && \
    # Установка
    apt install --yes ${PYTHON_NAME} && \
    # Установка пакетов для Python
    # GSSAPI Python module (krb5-config, libkrb5-dev)
    apt install --no-install-recommends --yes krb5-config && \
    apt install --no-install-recommends --yes libkrb5-dev && \
    # C-compiler (GCC)
    apt install --no-install-recommends --yes build-essential && \
    apt install --no-install-recommends --yes python3-pip && \
    apt install --no-install-recommends --yes python3-setuptools && \
    apt install --no-install-recommends --yes ${PYTHON_NAME}-dev && \
    apt install --no-install-recommends --yes ${PYTHON_NAME}-distutils && \
    # Smoke test
    ${PYTHON_NAME} --version && \
    # Обновление pip
    ${PYTHON_NAME} -m pip install --upgrade pip && \
    # Установка пакетов python
    ${PYTHON_NAME} -m pip install --no-cache-dir --use-pep517 jupyterlab==3.5.2 && \
    ${PYTHON_NAME} -m pip install --no-cache-dir --use-pep517 --requirement /tmp/requirements.txt && \
    # --------------------------------------------------------------------------
    # --------------------------------------------------------------------------
    # Очистка кэша
    # --------------------------------------------------------------------------
    apt --yes autoremove && \
    rm -rf /var/lib/apt/lists/*
    # --------------------------------------------------------------------------

# Копирование файлов проекта
COPY ./entrypoint/* /entrypoint/

# Выбор рабочей директории
WORKDIR ${WORK_DIRECTORY}

# Точка входа
ENTRYPOINT ["/bin/bash", "/entrypoint/jupyterlab-entrypoint.sh"]
CMD []
