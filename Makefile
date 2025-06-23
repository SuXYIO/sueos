TARGET=img/sueos.img

$(TARGET): bin/main.bin
	bximage -func=create -fd=1.44M -q $(TARGET)
	dd if=bin/main.bin of=$(TARGET) bs=512 count=1 conv=notrunc

bin/main.bin: main.asm
	nasm -f bin main.asm -o bin/main.bin

clean:
	rm -f bin/*
	rm -f img/*
