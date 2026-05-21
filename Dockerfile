FROM scratch
ARG TARGETARCH
ADD archlinux-${TARGETARCH}.tar.xz /
CMD ["/bin/bash"]