_default:
    @just -l

# Build and publish
deploy:
    rm -rf build/public
    hugo -F
    rsync -avze 'ssh -p 5555' --delete build/public/ main-deployer@necauq.ua:.

    # ughh the weird permission issue is weird,
    # I should fix my nginx config or something
    ssh necauq.ua systemd-tmpfiles --create

# Run the website locally with hotreloading and draft posts visible
dev:
    hugo server -DF
