_default:
    @just -l

# Build and publish
deploy:
    rm -rf build/public
    hugo -F
    rsync -avze 'ssh -p 5555' --delete build/public/ main-deployer@necauq.ua:.

# Run the website locally with hotreloading and draft posts visible
dev:
    xdg-open http://localhost:1313/
    hugo server -DF
