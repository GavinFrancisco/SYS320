ip addr | awk '/inet/' | grep 10 | cut -c 10-19
