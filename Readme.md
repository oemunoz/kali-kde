# xrdp kali-kde docker

## Running

Flavours available are: `oems/kali-kde:latest`, using KDE plasma.

By default it will run a full session with startkde on DISPLAY=:1.

```bash
docker run -it --rm -p 3389:3389 oems/kali-kde
```

Then, for example you can use xfreerdp:

```bash
xfreerdp +clipboard /v:localhost /port:3389 /f  /u:root

```
