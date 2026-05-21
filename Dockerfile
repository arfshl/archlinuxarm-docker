FROM scratch
ARG TARGETARCH
ARG BUILDDATE
ADD archlinux-${BUILDDATE}-${TARGETARCH}.tar.xz /
CMD ["/bin/bash"]
LABEL org.opencontainers.image.title="archlinuxarm"
LABEL org.opencontainers.image.description="Unofficial docker image for Arch Linux ARM"
LABEL org.opencontainers.image.source="https://github.com/arfshl/archlinuxarm-docker"
LABEL org.opencontainers.image.url="https://github.com/arfshl/archlinuxarm-docker"
LABEL org.opencontainers.image.documentation="https://github.com/arfshl/archlinuxarm-docker/blob/main/README.md"
LABEL org.opencontainers.image.licenses="GPL-3.0-or-later"