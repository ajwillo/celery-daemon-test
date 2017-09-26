FROM rabbitmq:latest

ADD init.sh /init.sh

# Set correct executable permissions
RUN chmod +x /init.sh

# Define default command
CMD ["/init.sh"]

RUN service rabbitmq-server start