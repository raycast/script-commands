EXECUTABLE_NAME = toolkit

TOOLKIT_PATH = Tools/Toolkit
BUILD_PATH_RELEASE = $(TOOLKIT_PATH)/.build/release
EXECUTABLE_PATH_RELEASE = $(BUILD_PATH_RELEASE)/Toolkit

BUILD_PATH_DEBUG = $(TOOLKIT_PATH)/.build/debug
EXECUTABLE_PATH_DEBUG = $(BUILD_PATH_DEBUG)/Toolkit

.PHONY: clean
clean:
	rm -rf $(TOOLKIT_PATH)/.build $(EXECUTABLE_NAME)

.PHONY: build
build: clean
	swift build -c release --disable-sandbox --package-path $(TOOLKIT_PATH)
	ln -s $(EXECUTABLE_PATH_RELEASE) $(EXECUTABLE_NAME)

.PHONY: build-debug
build-debug:
	if [ -f $(EXECUTABLE_NAME) ]; then rm $(EXECUTABLE_NAME); fi

	swift build --package-path $(TOOLKIT_PATH)
	ln -s $(EXECUTABLE_PATH_DEBUG) $(EXECUTABLE_NAME)

.PHONY: gen-docs
gen-docs:
	./$(EXECUTABLE_NAME) generate-documentation

.PHONY: gen-docs-and-commit
gen-docs-and-commit: gen-docs
	./$(TOOLKIT_PATH)/integration.sh commit_documentation

.PHONY: set-executable
set-executable:
	./$(EXECUTABLE_NAME) set-executable

.PHONY: set-executable-and-commit
set-executable-and-commit: set-executable
	./$(TOOLKIT_PATH)/integration.sh commit_executable

.PHONY: lint
lint:
	@echo "Linting code format with SwiftLint"
	@swiftlint $(TOOLKIT_PATH) --config $(TOOLKIT_PATH)/.swiftlint.yml

.PHONY: fix
fix:
	@echo "Fixing code format with SwiftLint"
	@swiftlint $(TOOLKIT_PATH) --fix  --config $(TOOLKIT_PATH)/.swiftlint.yml

.PHONY: format
format:
	@echo "Fixing code format with SwiftFormat"
	@swiftformat $(TOOLKIT_PATH) --config $(TOOLKIT_PATH)/.swiftformat

.PHONY: open
open:
	open -a /Applications/Xcode.app $(TOOLKIT_PATH)
