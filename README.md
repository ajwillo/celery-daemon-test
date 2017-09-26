# celery-daemon-test
To create use the following commands:

docker build -t itapp-celery:latest .
cd  rabbitmq
docker build -t rabbit-celery:latest .
cd ../
docker-compose up

once up exec into itapp-celery shell and run

celery -A itapp  worker -l info

this works, however running the below, returns, not running no PID files found

/etc/init.d/celeryd status
/etc/init.d/celerybeat status


