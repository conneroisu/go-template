#!/bin/bash

URL=$(gum input --placeholder "Enter Repo URL (without .git)")

if [ -z "$URL" ]; then
    echo "No URL provided"
    exit 1
fi

echo "Creating Golang Project $URL"

go mod init "$URL"

go work init

cat > go.work <<- EOM
go 1.23.0

toolchain go1.23.0

use (
	.
	./tools
)
EOM

cd tools && go mod init "$URL/tools" && cd ..

rm start.sh
