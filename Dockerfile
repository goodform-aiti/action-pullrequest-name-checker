FROM php:8.1-cli


LABEL version="1.1"
LABEL maintainer="Amir Alian <amir@ateli.cz>"

COPY "entrypoint.sh" "/entrypoint.sh"

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git curl jq

RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
