cd ~/disaster/disaster/2/http1
python3 -m http.server 8888 --bind 0.0.0.0

cd ~/disaster/disaster/2/http2
python3 -m http.server 9999 --bind 0.0.0.0

sudo apt update
sudo apt-get install haproxy

sudo nano /etc/haproxy/haproxy.cfg 

sudo systemctl reload haproxy

curl https://127.0.0.1:8088

cd ~/disaster/disaster/2/http2
python3 -m http.server 9999 --bind 0.0.0.0


curl -H 'Host:example.local' http://127.0.0.1:8088