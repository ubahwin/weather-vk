#!/bin/bash

openapi-generator generate -i docs/openapi.yaml -g swift5 -o tmp

if [ -d "tmp/OpenAPIClient/Classes/OpenAPIs/Models" ]; then
    cp -r tmp/OpenAPIClient/Classes/OpenAPIs/Models/. WeatherVK/Network/DTO/Response/
fi

if [ -d "WeatherVK/Network/DTO/Response" ]; then
    cd WeatherVK/Network/DTO/Response/

    for file in *.swift; do
        sed -i '' 's/, JSONEncodable//g' "$file"
    done

    cd ../../../..
fi

ls

rm -rf tmp

echo "Done."
