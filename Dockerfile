FROM base/devel

# Bazel and git
RUN pacman --noconfirm -Syu \
  bazel git

# OPAM for Obliv-C based projects
RUN pacman --noconfirm -Syu \
  ocaml ocaml-findlib opam
RUN opam init --disable-sandboxing -y --compiler 4.06.0; \
  eval `opam config env`; \
  opam install -y camlp4 ocamlfind ocamlbuild batteries;
RUN opam config env >> /etc/opam.env
ENV BASH_ENV=/etc/opam.env

# CMake
RUN pacman --noconfirm -Syu \
  cmake

# Register remote cache in .bazelrc
RUN echo "build --remote_http_cache=http://141.20.33.195:9090" >> ~/.bazelrc

# Use Bash as entrpoint so opam.env gets read
ENTRYPOINT ["/bin/bash", "-c"]
