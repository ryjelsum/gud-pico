Raspberry Pi Pico GUD USB Display
---------------------------------

[GUD](https://github.com/notro/gud/wiki) reference implementation for the Raspberry Pi Pico, modified to work with 240x240 ST7789 displays. With a modified resolution (WIDTH and HEIGHT in pico-display.c), it can be made to work on ST7735 displays, though mine displayed inverted/improper colors. 

All of my changes are contained in the [st7789-240x240](https://github.com/ryjelsum/gud-pico/tree/st7789-240x240) branch.

The ```PICO_SDK_PATH``` env var should point to the Pico SDK. A shell.nix is provided for nix(OS), but it isn't fully functional, you'll need to set ```PICO_SDK_PATH``` manually to whatever path it gets fetched to. This doesn't build with pico-sdk from NixOS, since it doesn't include submodules like the TinyUSB dependency. I am not great with Nix and I'd welcome improvements.

cpol and cpha (inside the mipi\_dbi struct inside pico\_display.c) may need to be changed to work with your display. This is made for a 7-pin "ST7789" display which has four buttons integrated into it, I assume it will work for most 240x240 displays marketed as ST7789 driven. If your display needs SPI_MODE3 passed into the init function to work with the Adafruit ST77xx library on arduino-pico, this *will* work, if you uncomment the lines ```.cpol = 1, .cpha = 1```. 

# Build
```
$ git clone https://github.com/ryjelsum/gud-pico -b st7789-240x240
$ cd gud-pico
$ mkdir build && cd build
$ cmake ..
$ make

```

This should work without configuration needed on stock linux kernels above 5.15. Hotplugging it does make Xorg crash for me.

# Future?

- Fix st7735 (colors are inverted/mismatched, this seems to be a pretty simple fix that just may not be in mipi_dbi)
- Make code more modular for different LCDs, handle different clock polarity and phase, and other issues between displays like whatever the st7735 issue is.