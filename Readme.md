[![aarch64 base](https://github.com/hasael/aarch64-haskell-base/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/hasael/aarch64-haskell-base/actions/workflows/docker-publish.yml)
[![aarch64 cached](https://github.com/hasael/aarch64-haskell-base/actions/workflows/docker-publish-cached.yml/badge.svg)](https://github.com/hasael/aarch64-haskell-base/actions/workflows/docker-publish-cached.yml)
## Haskell on aarch64 image

Docker image using aarch64/alpine to build and run haskell applications.
This image uses [Nix](https://nixos.org/) package manager which contains prebuilt hackage libraries for aarch64. The reasoning is that `cabal install` on its own is very slow to build libraries on arm (at least in my experience).
The haskell project must contain a .nix build file, which can be generated from your cabal file following this [guide](https://mmhaskell.com/blog/2020/2/10/converting-cabal-to-nix)
