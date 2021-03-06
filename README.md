# NGINX TOR PROXY

<p  align="center">
<img src="https://github.com/anthonybudd/nginx-tor-proxy/raw/master/docs/img/header.png" width="300" alt="Header">
</p>

NGINX Tor Proxy is a simple container that exposes your containers with a custom Tor v3 Onion address.

Tor vanity URLs generated using [cathugger/mkp224o](https://github.com/cathugger/mkp224o)

### Getting Started
Run the command below to create a new onion address and run an example application. The `docker-compose.yml` used in this project will just expose a container that will echo any HTTP requests as JSON.
```
docker-compose build 

docker run -ti --entrypoint="mkp224o" -v $(pwd):/tor nginx-tor-proxy_nginx-tor-proxy -n 1 -S 10 -d /tor [FILTER] 

mv *.onion web

chmod 700 web

sed -ie 's#xxxxx.onion#'"$(cat web/hostname)"'#g' nginx/tor.conf

cat web/hostname

docker-compose up
```
