FROM onion/omega2-source:lede-17.01

RUN apt-get update && \
    apt-get -f -y install && \
    apt-get -y install apt-utils time
RUN git checkout .config && \
    git pull && \
    git checkout openwrt-18.06
RUN ./scripts/feeds update -a && \
    ./scripts/feeds install -a
RUN git checkout .config

RUN echo "src-git plan44 https://github.com/plan44/plan44-feed.git;master" >> feeds.conf
RUN ./scripts/feeds update plan44
RUN ./scripts/feeds uninstall p44-ledchain
# RUN ./scripts/feeds uninstall kmod-p44-ledchain
RUN ./scripts/feeds install -p plan44 kmod-p44-ledchain

RUN make tools/install && make toolchain/install && make package/feeds/plan44/p44-ledchain/compile
