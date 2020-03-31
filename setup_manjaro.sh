function add_swap() {
    SWAP_SIZE=8G
    printf "Adding swap of size ${SWAP_SIZE}..."
    sudo fallocate -l ${SWAP_SIZE} /swapfile > /dev/null
    # Format file as swap
    sudo mkswap /swapfile > /dev/null

    # Only readable and
    sudo chmod 600 /swapfile > /dev/null
    # Enable swap
    sudo swapon /swapfile > /dev/null

    sudo bash -c "echo /swapfile none swap defaults 0 0 >> /etc/fstab"
    printf "COMPLETED\n"
}
