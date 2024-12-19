FROM ubuntu:20.04

# set required environment variables
ENV DEBIAN_FRONTEND=noninteractive

# install required packages
RUN apt-get update && \
    apt-get install -y octave liboctave-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# set working directory
WORKDIR /usr/src/app

# copy script and data to the container
COPY convert.m ./
COPY data ./data

# set output directory as mount point
VOLUME ["/usr/src/app/data/output"]

# command to excute the script
CMD ["octave", "--no-gui", "convert.m"]
