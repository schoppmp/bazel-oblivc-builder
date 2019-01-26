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

# CMake
RUN pacman --noconfirm -Syu \
  cmake

# Python
RUN pacman --noconfirm -Syu \
  python python2

# Set up env wrapper and use as entrypoint
COPY env_wrapper /bin/env_wrapper
ENTRYPOINT ["/bin/env_wrapper", "-c"]
CMD ["bash"]
