if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "You are not inside a Git repository."
    exit 1
fi