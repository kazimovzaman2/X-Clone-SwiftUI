FROM python:3.10.15-bullseye

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get install --no-install-recommends -y \
  build-essential \
  libpq-dev \
  gettext \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && rm -rf /var/lib/apt/lists/*

ARG APP_HOME=/code/x-clone
ARG GROUPNAME=x-clone
ARG USERNAME=x-clone

WORKDIR ${APP_HOME}

RUN addgroup --system ${GROUPNAME} && \
    adduser --system --ingroup ${GROUPNAME} ${USERNAME} &&

COPY ./requirements .

RUN python -m pip install --upgrade pip \
    && pip install -r production.txt

COPY --chown=${GROUPNAME}:${USERNAME} ./docker/start.sh /start.sh
RUN sed -i 's/\r$//g' /start.sh
RUN chmod +x /start.sh

COPY --chown=${GROUPNAME}:${USERNAME} . ${APP_HOME}

RUN chown ${GROUPNAME}:${USERNAME} ${APP_HOME}

USER ${USERNAME}

CMD ["/start.sh"]
