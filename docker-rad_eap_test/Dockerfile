FROM alpine AS build
ENV UPSTREAM_REPO https://github.com/CESNET/rad_eap_test.git
RUN apk add --no-cache git
WORKDIR /tmp
RUN git clone ${UPSTREAM_REPO}

FROM alpine
LABEL maintainer="matthew.slowe@jisc.ac.uk"
LABEL Description="Alpine Linux based container with rad_eap_test available"

RUN apk add wpa_supplicant bind-tools bash grep \
    && ln -s /sbin/eapol_test /bin
COPY --from=build /tmp/rad_eap_test/rad_eap_test /usr/local/bin
RUN chmod +x /usr/local/bin/rad_eap_test

ENTRYPOINT ["/usr/local/bin/rad_eap_test"]
