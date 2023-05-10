FROM stlouisn/ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

COPY rootfs /

RUN \

    # Create docker-g group
    groupadd \
        --system \
        --gid 9999 \
        docker-g && \

    # Create docker-u user
    useradd \
        --system \
        --no-create-home \
        --shell /sbin/nologin \
        --comment 'docker user' \
        --gid 9999 \
        --uid 9999 \
        docker-u && \

    # Update apt-cache
    apt-get update && \

    # Install nfs-kernel-server
    apt-get install -y --no-install-recommends -o "Dpkg::Options::=--force-confold" \
        nfs-kernel-server && \

    # Clean apt-cache
    apt-get autoremove -y --purge && \
    apt-get autoclean -y && \

    # Cleanup temporary folders
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /usr/local/man \
        /usr/local/share/man \
        /usr/share/doc \
        /usr/share/doc-base \
        /usr/share/man \
        /var/cache \
        /var/lib/apt \
        /var/log/*

VOLUME /config

EXPOSE 2049

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
