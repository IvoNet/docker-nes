#!/usr/bin/env bash
NAME=nes
PORT=8080
if [ ! -z $1 ]; then
   EP="--entrypoint bash"
fi

killpulse() {
    pulseaudio --kill 2>/dev/null
    killall pulseaudio 2>/dev/null
    rm -rf ~/.config/pulse 2>/dev/null
    mkdir -p ~/.config/pulse 2>/dev/null
}

[[ -z "$(brew ls --versions pulseaudio)" ]] && brew install pulseaudio
killpulse
pulseaudio --load=module-native-protocol-tcp --exit-idle-time=-1 --daemon 2>/dev/null

docker run                                   \
    -it                                      \
    --rm                                     \
    --name $NAME                             \
    -e WIDTH=1280                            \
    -e HEIGHT=720                            \
    -e PULSE_SERVER=docker.for.mac.localhost \
    -v ~/.config/pulse:/nobody/.config/pulse \
    -p ${PORT}:32000                         \
    $EP                                      \
    ivonet/$NAME

killpulse
