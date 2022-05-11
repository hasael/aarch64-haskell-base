#FROM arm64v8/alpine:latest
FROM arm64v8/nixos/nix
# Create non root user to install nix

RUN nix-channel --update

RUN nix-env -f "<nixpkgs>" -iA haskellPackages.ghc haskellPackages.cabal-install \ 
     haskellPackages.refined \
     haskellPackages.aeson \
     haskellPackages.servant-server \
     haskellPackages.wai \
     haskellPackages.wai-extra \
     haskellPackages.either \
     haskellPackages.warp \
     haskellPackages.hspec \
     haskellPackages.hspec-wai \
     haskellPackages.async\
     haskellPackages.QuickCheck\
# To build your haskell app you would run something like this
#COPY . /home/app/yourapp
#USER root
#RUN chown -R app /home/app/yourapp
#USER app
#WORKDIR /home/app/yourapp
#RUN nix-build release.nix 
#CMD ["/home/app/servant-play/result/bin/yourapp-exe"]