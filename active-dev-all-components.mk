clone:
	git clone https://github.com/microNET-OS/microBOOT.git
	git clone https://github.com/microNET-OS/microCORE.git

kernel:
	make -C microCORE
	cp -r microCORE/bin bin
	rm -rf microCORE

bootloader:
	make -C microBOOT
	cp -r microBOOT/bin bin
	rm -rf microBOOT

image: kernel bootloader
	res/GenerateImage bin/microCORE.kernel bin/bootloader.efi

clean:
	rm -rfv bin iso microNET.iso
  
rid: clean
  rm -rfv microBOOT microCORE
	
qemu: image
	qemu-system-x86_64 -bios res/OVMF.fd -cdrom microNET.iso -m 512M
