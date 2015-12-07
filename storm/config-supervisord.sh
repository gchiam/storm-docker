echo [program:storm-$1] | tee -a /etc/supervisor/conf.d/storm-$1.ini
echo command=storm $1 | tee -a /etc/supervisor/conf.d/storm-$1.ini
echo directory=/home/storm | tee -a /etc/supervisor/conf.d/storm-$1.ini
echo autorestart=true | tee -a /etc/supervisor/conf.d/storm-$1.ini
echo user=root | tee -a /etc/supervisor/conf.d/storm-$1.ini
