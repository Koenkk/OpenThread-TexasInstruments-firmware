# OpenThread-TexasInstruments-firmware

This repository contains OpenThread RCP firmwares for various Texas Instruments MCUs. The baudrate of the firmware is `460800`.

## Flashing

1. Download the firmware for your device from the [releases page](https://github.com/Koenkk/OpenThread-TexasInstruments-firmware/releases). Use the [adapters page](./docs/adapters.md) to figure out what firmware to use for your device.
1. Flash the firmware; use e.g. the [SMLIGHT firmware updater](https://smlight.tech/flasher/#other_cc) which allows for easy flashing via the webbrowser (can be used to flash any adapter). Other ways of flashing can be found on the [Zigee2MQTT docs](https://www.zigbee2mqtt.io/guide/adapters/zstack.html#firmware-flashing-cc2652-cc1352).

## Example usage: Home Assistant OpenThread Border Router add-on

After having flashed the firmware with the instructions above:

1. Install the add-on ([docs](https://github.com/home-assistant/addons/blob/master/openthread_border_router/DOCS.md#installation))
1. On the configuration page of the add-on, select the device and make sure the baudrate is set to `460800`.
1. Start the add-on.

## Compiling

The firmware can be compiled on any Linux x86_64 machine with Docker installed, instructions:


```bash
# Setup repository
git clone https://github.com/Koenkk/OpenThread-TexasInstruments-firmware.git
cd OpenThread-TexasInstruments-firmware
git submodule update --init --recursive

docker run -it --rm -v $(pwd):/data -w /data ubuntu:24.04 bash

# Bootstrap
bash scripts/bootstrap.sh

# Build
bash scripts/build.sh
```

The firmwares can now be found in the `./dist` directory.
