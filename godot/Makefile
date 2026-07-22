
build:
	bash ./pre-build.sh
	make build_web
	make upload_web

build_all:
	bash ./pre-build.sh
	make build_web
	make build_lin
	make build_win
	make upload_all

build_web:
	rm -rf ./builds/web/
	mkdir -p ./builds/
	mkdir -p ./builds/web/
	godot --headless --path . --export-release "Web"

build_lin:
	rm -rf ./builds/linux/
	mkdir -p ./builds/
	mkdir -p ./builds/linux/
	godot --headless --path . --export-release "Linux"

build_win:
	rm -rf ./builds/windows/
	mkdir -p ./builds/
	mkdir -p ./builds/windows/
	godot --headless --path . --export-release "Windows"

upload_web:
	bash ./butler-upload_web.sh

upload_all:
	bash ./butler-upload_all.sh

