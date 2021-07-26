# NGINX TOR PROXY

_This is still in development_.

### To generate a v3 onion address
```
docker run -ti --entrypoint="mkp224o" -v $(pwd)/found-addresses:/found-addresses nginx-tor-proxy_nginx-tor-proxy -S 10 -d /found-addresses [FILTER]
```

Move an address from `/found-addresses\XXX.onion` to `/web`

Set hostname in `nginx/tor.conf` to match onion address.

`chmod 700 web`

Run `docker-compose up`