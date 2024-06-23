Raspberry Pi Pico GUD USB Display
---------------------------------

[GUD](https://github.com/notro/gud/wiki) reference implementation for the Raspberry Pi Pico, modified to work with 240x240 ST7789 displays (other displays to be tested but other st77xx displays may work with changed WIDTH and HEIGHT in pico_display.c).

All of my changes are contained in the [st7789-240x240](https://github.com/ryjelsum/gud-pico/tree/st7789-240x240) branch.

The ```PICO_SDK_PATH``` env var should point to the Pico SDK. A shell.nix is provided for nix(OS), but it isn't fully functional. This shell.nix isn't fully functional on its own, you'll need to set ```PICO_SDK_PATH``` manually to whatever path it gets fetched to. This doesn't build with pico-sdk from NixOS, since it doesn't include submodules like the TinyUSB dependency. I am not great with Nix and I'd welcome improvements.

cpol and cpha (inside the mipi\_dbi struct inside pico\_display.c) may need to be changed to work with your display. This is made for a 7-pin "ST7789" display which has four buttons integrated into it, I assume it will work for most 240x240 displays marketed as ST7789 driven. If your display needs SPI_MODE3 passed into the init function to work with the Adafruit ST77xx library on arduino-pico, this *will* work. If not, you will need to change those to 0 or comment those out.

# Build
```
$ git clone https://github.com/ryjelsum/gud-pico -b st7789-240x240
$ cd gud-pico
$ mkdir build && cd build
$ cmake ..
$ make

```

This should work without configuration on stock linux kernels above 5.15. Hotplugging it does make Xorg crash for me.

# Future

- Test st7735, other SPI LCDs available on Aliexpress (though IMO, the 1.3" 240x240 works best for this). If it works: 
- Make code more modular for different LCDs, handle different clock polarity and phase 