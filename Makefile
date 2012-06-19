TARGET=tgstation
all:
	DreamMaker $(TARGET).dme

clean:
	rm -rf $(TARGET).zip
	rm -rf $(TARGET).dmb
	rm -rf $(TARGET).rsc

zip:
	rm -rf $(TARGET).zip
	zip -R $(TARGET).zip *.dm *.dme
