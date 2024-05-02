# build:
#  docker build -t baroka/amule .

FROM ubuntu:latest

# Define TCP/IP ports
EXPOSE 4711/tcp
EXPOSE 4672/udp
EXPOSE 4665/tcp
EXPOSE 4662/tcp

WORKDIR /work

# Copy entrypoint script
COPY entrypoint.sh .
RUN chmod a+x entrypoint.sh

# Install packages
RUN apt-get update && apt-get install -y amule-daemon curl && \
    apt-get clean

# Timezone (no prompt)
ARG TZ "Europe/Madrid"
ENV tz=$TZ
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN echo "$tz" > /etc/timezone
RUN rm -f /etc/localtime
#RUN dpkg-reconfigure -f noninteractive tzdata

# Run the command on container startup
ENTRYPOINT ["/work/entrypoint.sh"]