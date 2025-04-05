
_default:
    @just -l

deploy:
    rm -rf build/public
    # meh couldn't be bothered to set up a flake
    nix shell nixpkgs#hugo nixpkgs#go --command hugo -F
    rsync -avze 'ssh -p 5555' --delete build/public/ main-deployer@necauq.ua:.

dev:
    nix shell nixpkgs#hugo nixpkgs#go --command hugo server -DF
