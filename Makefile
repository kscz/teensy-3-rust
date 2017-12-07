
.PHONY: all
all: target/thumbv7em-none-eabi/release/blink.hex

target/thumbv7em-none-eabi/release/blink.hex: target/thumbv7em-none-eabi/release/blink
	arm-none-eabi-objcopy -O ihex -R .eeprom $< $@ 

.PHONY: target/thumbv7em-none-eabi/release/blink
target/thumbv7em-none-eabi/release/blink:
	xargo build --target=thumbv7em-none-eabi --release

.PHONY: clean
clean:
	xargo clean

.PHONY: flash
flash: target/thumbv7em-none-eabi/release/blink.hex
	teensy_loader_cli -v -w --mcu=mk20dx256 $<

