FROM scratch
ARG TARGETARCH
ARG BUILDDATE
ADD archlinux-${BUILDDATE}-${TARGETARCH}.tar.xz /
CMD ["/bin/bash"]