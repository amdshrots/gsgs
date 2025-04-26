#!/bin/bash
echo ..........................................................
echo IP:
ssh -p 443 -R0:localhost:5900 -o StrictHostKeyChecking=no gtcxZbEfnfR+tcp@us.free.pinggy.io < /dev/null &
echo Username: runneradmin
echo Password: kaiden
