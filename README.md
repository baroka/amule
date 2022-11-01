```shell
Docker image for Amule

PREREQUISITES
 - Docker installed

INSTALLATION
 - Docker compose example: 

# Amule
  amule:
    container_name: amule
    image: baroka/amule:latest
    restart: unless-stopped
    depends_on:
      - openvpn
    network_mode: "service:openvpn"
    security_opt:
      - no-new-privileges:true
   #ports:
     #- 4711:4711
     #- 4662:4662
     #- 4672:4672/udp
    volumes:
      - $DOCKERDIR/amule/conf:/home/amule/.aMule
      - $DOCKERDIR/amule/incoming:/incoming
      - $DOCKERDIR/amule/tmp:/temp
    healthcheck:
      test: ["CMD", "curl", "-LSs", "https://api.ipify.org"]
      interval: 60s
      timeout: 15s
      retries: 4
      start_period: 90s
    environment:
      - TZ=$TZ
      - PGID=$PGID
      - PUID=$PUID
      - AMULE_WEBUI_PWD=xxx

 - $DOCKERDIR points to your local path for amule config files
 - AMULE_WEBUI_PWD is mandatory. It's webui password
```
