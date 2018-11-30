FROM base/devel

# Bazel and git 
RUN pacman --noconfirm -Syu \
  bazel git
# OPAM for Obliv-C based projects
RUN pacman --noconfirm -Syu \
  ocaml ocaml-findlib opam
RUN opam init --disable-sandboxing -y; \
  opam switch create -y 4.06.0; \
  eval `opam config env`; \
  opam install -y camlp4 ocamlfind ocamlbuild batteries;

