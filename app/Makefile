.PHONY: build doc

build:
	flutter build web --wasm --release

doc:
	flutter build web --release  --base-href /example-flutter-web/ --no-source-maps --web-renderer canvaskit -o ../docs
