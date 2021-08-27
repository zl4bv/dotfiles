#!/bin/sh

shellcheck(){
    docker run -it --rm \
	-v "$(pwd):/usr/src:ro" \
	-w /usr/src \
	r.j3ss.co/shellcheck shellcheck "$@"
}

terraform(){
    docker run -it --rm \
        -v "$(pwd):/tf" \
        -w /tf \
        -e AWS_SESSION_TOKEN \
        -e AWS_SECRET_ACCESS_KEY \
        -e AWS_ACCESS_KEY_ID \
        -e CLOUDFLARE_API_TOKEN \
        -e TF_LOG \
        r.j3ss.co/terraform "$@"
}
