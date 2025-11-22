## Run the following command to generate the asset references:

flutter pub run build_runner build

## If you want it to automatically rebuild when assets change:

flutter pub run build_runner watch

### run g. enerator - assets, fonts, localization of content

dart run build_runner build --delete-conflicting-outputs

### run to remove unused imports

dart fix --apply --code=unused_import
