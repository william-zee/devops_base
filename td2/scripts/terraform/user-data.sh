#!/usr/bin/env bash
# On attend 10 secondes que le système soit prêt
sleep 10
# On lance l'application et on enregistre les logs
nohup node /home/ec2-user/app.js > /home/ec2-user/app.log 2>&1 &
