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
RUN nix-env -f "<nixpkgs>" -iA haskellPackages.refined 
RUN nix-env -f "<nixpkgs>" -iA haskellPackages.aeson 
RUN nix-env -f "<nixpkgs>" -iA haskellPackages.servant-server 
RUN nix-env -f "<nixpkgs>" -iA haskellPackages.wai 
RUN nix-env -f "<nixpkgs>" -iA haskellPackages.wai-extra 
RUN nix-env -f "<nixpkgs>" -iA haskellPackages.either 
RUN nix-env -f "<nixpkgs>" -iA haskellPackages.warp 
RUN nix-env -f "<nixpkgs>" -iA haskellPackages.hspec 
RUN nix-env -f "<nixpkgs>" -iA haskellPackages.hspec-wai 
RUN nix-env -f "<nixpkgs>" -iA haskellPackages.async
RUN nix-env -f "<nixpkgs>" -iA haskellPackages.QuickCheck
# To build your haskell app you would run something like this
#COPY . /home/app/yourapp
#USER root
#RUN chown -R app /home/app/yourapp
#USER app
#WORKDIR /home/app/yourapp
#RUN nix-build release.nix 
#CMD ["/home/app/servant-play/result/bin/yourapp-exe"]