( sleep 10 ; \
# Create users
# rabbitmqctl add_user <username> <password>
rabbitmqctl add_user it-app Passw0rd ; \

# Set user rights
# rabbitmqctl set_user_tags <username> <tag>
rabbitmqctl set_user_tags it-app administrator ; \

# Create vhosts
# rabbitmqctl add_vhost <vhostname>
rabbitmqctl add_vhost it-app-vhost ; \

# Set vhost permissions
# rabbitmqctl set_permissions -p <vhostname> <username> ".*" ".*" ".*"
rabbitmqctl set_permissions -p it-app-vhost it-app ".*" ".*" ".*" ; \
) &    
rabbitmq-server