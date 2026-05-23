.PHONY: test pkg pkg-linux pkg-mac pkg-mac-silicon

RELEASE_DIR := docs/releases/v0.1.0

test:
	cd docs && python3 -m http.server 8089; cd -

pkg: pkg-linux-intel pkg-mac-intel
	@echo ""
	@echo "✓ All packages:"
	@ls -lh $(RELEASE_DIR)/

pkg-linux-intel:
	@mkdir -p $(RELEASE_DIR)
	cp ../out/rustty_*_linux-x86-64 $(RELEASE_DIR)/
	cd $(RELEASE_DIR) && tar -czf rustty-linux-x86_64.tar.gz rustty_*_linux-x86-64 && rm rustty_*_linux-x86-64
	cp ../out/*.AppImage $(RELEASE_DIR)/
	@echo "✓ Linux: AppImage + Binary (tar.gz)"

pkg-mac-intel:
	@mkdir -p $(RELEASE_DIR)
	cp ../out/*_x64.dmg $(RELEASE_DIR)/Rustty_0.1.0_x64.dmg
	@echo "✓ macOS: DMG (Intel)"

pkg-mac-silicon:
	@mkdir -p $(RELEASE_DIR)
	cp ../out/*_aarch64.dmg $(RELEASE_DIR)/Rustty_0.1.0_aarch64.dmg
	@echo "✓ macOS: DMG (Apple Silicon)"
