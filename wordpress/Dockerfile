FROM wordpress:latest

ENV WOOCOMMERCE_VERSION 2.6.4
ENV WOOCOMMERCE_UPSTREAM_VERSION 2.6.4
ENV WOOCOMMERCE_GERMANIZED_VERSION 1.7.1
ENV MAX_MEGA_MENU_VERSION 2.2.3.1
ENV ALL_IN_ONE_WP_MIGRATION_VERSION 5.51

RUN apt-get update
RUN apt-get install -y --no-install-recommends unzip wget

RUN mkdir /temp
RUN wget https://downloads.wordpress.org/plugin/woocommerce.${WOOCOMMERCE_VERSION}.zip -O /temp/temp.zip \
    && cd /usr/src/wordpress/wp-content/plugins \
    && unzip /temp/temp.zip \
    && rm /temp/temp.zip

RUN wget https://downloads.wordpress.org/plugin/woocommerce-germanized.${WOOCOMMERCE_GERMANIZED_VERSION}.zip -O /temp/temp.zip \
    && cd /usr/src/wordpress/wp-content/plugins \
    && unzip /temp/temp.zip \
    && rm /temp/temp.zip

RUN wget https://downloads.wordpress.org/plugin/megamenu.${MAX_MEGA_MENU_VERSION}.zip -O /temp/temp.zip \
    && cd /usr/src/wordpress/wp-content/plugins \
    && unzip /temp/temp.zip \
    && rm /temp/temp.zip

# This plugin needs to be installed using the webinterface
#RUN wget https://downloads.wordpress.org/plugin/all-in-one-wp-migration.${ALL_IN_ONE_WP_MIGRATION_VERSION}.zip -O /temp/temp.zip \
#    && cd /usr/src/wordpress/wp-content/plugins \
#    && unzip /temp/temp.zip \
#    && rm /temp/temp.zip

# To use the kallyas theme provided by a zip-file 
#ADD ./kallyas.zip /usr/src/wordpress/wp-content/themes/
#RUN cd /usr/src/wordpress/wp-content/themes/ \
#    && unzip kallyas.zip \
#    && rm kallyas.zip

# To activate the theme
#ADD ./functions.addition /usr/src/wordpress/wp-content/themes/kallyas/
#RUN cd /usr/src/wordpress/wp-content/themes/kallyas/ \
#    && cat functions.addition >> functions.php
