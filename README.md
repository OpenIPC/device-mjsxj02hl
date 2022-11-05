## Welcome
OpenIPC for Xiaomi MJSXJ02HL

### Installation

1. Download the latest version of the [Zadig](https://zadig.akeo.ie) program. Run it and turn on the full list of devices (`Settings -> List of all devices`).
2. Connect the camera to the USB port of the computer (the wire that comes with the kit will not work - there are no data contacts in it) with the Reset button pressed, select the `HiUSBBurn` device from the list as quickly as possible and install the `libusbK` driver for it. Most likely you will not succeed the first time (the device disappears after a few seconds, you need to do everything very quickly).
3. Download the [HiTool](http://www.hihope.org/en/download/download.aspx?mtt=36) program. After its launch, select the `Hi3518EV300` chip. Having opened the HiBurn tool, select the [partition table file](https://raw.githubusercontent.com/OpenIPC/device-mjsxj02hl/master/usb-burn.xml) and specify the path to the [fastboot](https://github.com/OpenIPC/firmware/releases/download/latest/u-boot-hi3518ev300-universal.bin), [kernel and rootfs](https://github.com/OpenIPC/firmware/releases/download/latest/openipc.hi3518ev300-lite-nor.tgz) files.
4. Press `Burn` button, agree that some sections will be erased and connect the camera to USB with the Reset button pressed. If everything was done correctly, then the flashing process will begin. This usually takes about a minute and ends with an informational success message.

### Configuration

1. Create two `VFAT` partitions on your SD card (disable the quick format option).
2. [Download](https://github.com/OpenIPC/device-mjsxj02hl/archive/refs/heads/master.zip) this repository and extract the contents of directory `flash` to the root of the first partition of your SD card.
3. Using [Notepad++](https://notepad-plus-plus.org), open file `autoconfig/etc/network/interfaces` and change the [SSID and password](https://github.com/OpenIPC/device-mjsxj02hl/blob/master/flash/autoconfig/etc/network/interfaces#L18) of the Wi-Fi access point to your own (by default, these are `myssid` and `mypassword`).
4. Turn off the camera's power, insert the SD card and turn it on again. Wait a while until the indicator starts flashing yellow. Reboot the camera by power supply (the SD card is still inside).
5. If you did everything correctly, after a while you will hear a shutter click and the camera will connect to your Wi-Fi network.

### Links
* [MJSXJ02HL application](https://github.com/kasitoru/mjsxj02hl_application)
* [Build tools for mjsxj02hl firmware](https://github.com/kasitoru/mjsxj02hl_firmware)
* [WEB interface for mjsxj02hl firmware](https://github.com/kasitoru/mjsxj02hl_web)
* [mjsxj02hl_uboot](https://github.com/kasitoru/mjsxj02hl_uboot)
* [Прошивка для IP-камеры MJSXJ02HL с поддержкой RTSP и MQTT](https://kasito.ru/mjsxj02hl_firmware/)
* [Прошивка загрузчика IP-камеры MJSXJ02HL с помощью CH341A](https://kasito.ru/proshivka-zagruzchika-ip-kamery-mjsxj02hl-s-pomoshhyu-ch341a/)
* [Прошивка загрузчика IP-камеры MJSXJ02HL с помощью USB](https://kasito.ru/proshivka-zagruzchika-ip-kamery-mjsxj02hl-s-pomoshhyu-usb/)
* [Прошивка загрузчика IP-камеры MJSXJ02HL с помощью MicroSD карты](https://kasito.ru/proshivka-zagruzchika-ip-kamery-mjsxj02hl-s-pomoshhyu-microsd-karty/)

