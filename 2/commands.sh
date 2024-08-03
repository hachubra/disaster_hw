cd ~/disaster/disaster/2/http1
python3 -m http.server 8888 --bind 0.0.0.0

cd ~/disaster/disaster/2/http2
python3 -m http.server 9999 --bind 0.0.0.0

sudo apt update
sudo apt-get install haproxy

