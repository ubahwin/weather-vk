#!/bin/bash

openapi-generator generate -i docs/openapi.yaml -g swift5 -o tmp

if [ -d "tmp/OpenAPIClient/Classes/OpenAPIs/Models" ]; then
    cp -r tmp/OpenAPIClient/Classes/OpenAPIs/Models/. WeatherVK/Network/DTO/Response/
fi

rm -rf tmp

echo "Done."
