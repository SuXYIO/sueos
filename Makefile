TARGET=img/sueos.img

$(TARGET): bin/mbr.bin bin/os.bin
	bximage -func=create -fd=1.44M -q $(TARGET)
	dd if=bin/mbr.bin of=$(TARGET) bs=512 count=1 conv=notrunc
	dd if=bin/os.bin of=$(TARGET) bs=512 count=1 conv=notrunc seek=2

bin/mbr.bin: mbr.asm
	nasm -I include/ -f bin mbr.asm -o bin/mbr.bin

bin/os.bin: os.asm
	nasm -I include/ -f bin os.asm -o bin/os.bin

clean:
	rm -f bin/*
	rm -f img/*
