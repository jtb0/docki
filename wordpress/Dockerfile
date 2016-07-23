FROM wordpress:latest

ENV WOOCOMMERCE_VERSION 2.6.3
ENV WOOCOMMERCE_UPSTREAM_VERSION 2.6.3
ENV WOOCOMMERCE_GERMANIZED_VERSION 1.6.8


RUN apt-get update
RUN apt-get install -y --no-install-recommends unzip wget

RUN wget https://downloads.wordpress.org/plugin/woocommerce.${WOOCOMMERCE_VERSION}.zip -O /tmp/temp.zip \
    && cd /usr/src/wordpress/wp-content/plugins \
    && unzip /tmp/temp.zip \
    && rm /tmp/temp.zip

RUN wget https://downloads.wordpress.org/plugin/woocommerce-germanized.${WOOCOMMERCE_GERMANIZED_VERSION}.zip -O /tmp/temp.zip \
    && cd /usr/src/wordpress/wp-content/plugins \
    && unzip /tmp/temp.zip \
    && rm /tmp/temp.zip

ADD ./kallyas.zip /usr/src/wordpress/wp-content/themes/
RUN cd /usr/src/wordpress/wp-content/themes/ \
    && unzip kallyas.zip \
    && rm kallyas.zip
