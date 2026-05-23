.PHONY: test pkg pkg-linux-intel pkg-mac-intel pkg-mac-silicon version

VERSION := 0.2.0
RELEASE_DIR := docs/releases/v$(VERSION)

test:
	cd docs && python3 -m http.server 8089; cd -

pkg: pkg-linux-intel pkg-mac-intel
	@echo ""
	@echo "✓ All packages:"
	@ls -lh $(RELEASE_DIR)/

pkg-linux-intel:
	@mkdir -p $(RELEASE_DIR)
	cp ../out/keedown_*_linux-x86-64 $(RELEASE_DIR)/
	cd $(RELEASE_DIR) && tar -czf keedown-linux-x86_64.tar.gz keedown_*_linux-x86-64 && rm keedown_*_linux-x86-64
	cp ../out/*.AppImage $(RELEASE_DIR)/
	@echo "✓ Linux: AppImage + Binary (tar.gz)"

pkg-mac-intel:
	@mkdir -p $(RELEASE_DIR)
	cp ../out/*_x64.dmg $(RELEASE_DIR)/Keedown_$(VERSION)_x64.dmg
	@echo "✓ macOS: DMG (Intel)"

pkg-mac-silicon:
	@mkdir -p $(RELEASE_DIR)
	cp ../out/*_aarch64.dmg $(RELEASE_DIR)/Keedown_$(VERSION)_aarch64.dmg
	@echo "✓ macOS: DMG (Apple Silicon)"

# Stamp version into index.html
version:
	sed -i 's/Keedown_[0-9]\+\.[0-9]\+\.[0-9]\+/Keedown_$(VERSION)/g' docs/index.html
	sed -i 's/keedown-linux-x86_64\.tar\.gz/keedown-linux-x86_64.tar.gz/g' docs/index.html
	sed -i 's|releases/v[0-9]\+\.[0-9]\+\.[0-9]\+|releases/v$(VERSION)|g' docs/index.html
	sed -i 's/Keedown v[0-9]\+\.[0-9]\+\.[0-9]\+/Keedown v$(VERSION)/g' docs/index.html
	@echo "✓ index.html updated to v$(VERSION)"
