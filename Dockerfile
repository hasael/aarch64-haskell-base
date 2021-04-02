FROM arm64v8/alpine:latest
# Create non root user to install nix
RUN apk --update add curl wget xz git bash shadow sudo 
RUN  adduser -D app   \
        && echo "app ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/app \
        && chmod 0440 /etc/sudoers.d/app

RUN mkdir -m 0755 /nix && chown app /nix

USER app
WORKDIR /home/app
RUN wget https://nixos.org/nix/install 
RUN /bin/bash ./install

#Add path variables
RUN source /home/app/.nix-profile/etc/profile.d/nix.sh 
ENV PATH=/home/app/.nix-profile/bin/:$PATH
ENV NIX_PATH=/home/app/.nix-defexpr/channels

RUN nix-env -f "<nixpkgs>" -iA haskellPackages.ghc haskellPackages.cabal-install
RUN nix-env -f "<nixpkgs>" -iA haskellPackages.refined \
   && nix-env -f "<nixpkgs>" -iA haskellPackages.mtl \
   && nix-env -f "<nixpkgs>" -iA haskellPackages.aeson \
   && nix-env -f "<nixpkgs>" -iA haskellPackages.servant-server \
   && nix-env -f "<nixpkgs>" -iA haskellPackages-wai \
   && nix-env -f "<nixpkgs>" -iA haskellPackages.wai-extra \
   && nix-env -f "<nixpkgs>" -iA haskellPackages.base \
   && nix-env -f "<nixpkgs>" -iA haskellPackages.container \
   && nix-env -f "<nixpkgs>" -iA haskellPackages.either \
   && nix-env -f "<nixpkgs>" -iA haskellPackages.generic-random \
   && nix-env -f "<nixpkgs>" -iA haskellPackages.warp \
   && nix-env -f "<nixpkgs>" -iA haskellPackages.transformers \
   && nix-env -f "<nixpkgs>" -iA haskellPackages.stm \
   && nix-env -f "<nixpkgs>" -iA haskellPackages.hspec \
   && nix-env -f "<nixpkgs>" -iA haskellPackages.hspec-wai \
   && nix-env -f "<nixpkgs>" -iA haskellPackages.bytestring \
   && nix-env -f "<nixpkgs>" -iA haskellPackages.async 
# To build your haskell app you would run something like this
#COPY . /home/app/yourapp
#USER root
#RUN chown -R app /home/app/yourapp
#USER app
#WORKDIR /home/app/yourapp
#RUN nix-build release.nix 
#CMD ["/home/app/servant-play/result/bin/yourapp-exe"]