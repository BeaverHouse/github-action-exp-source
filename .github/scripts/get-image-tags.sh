#!/bin/bash

components=(
    cat
    dog
    fish
    octopus
)

# 각 컴포넌트의 버전 정보를 수집하여 JSON 형식으로 저장
image_tags_json="{"
for component in "${components[@]}"; do
    VERSION=$(grep "VERSION=" $PWD/$component/INFO | cut -d'=' -f2)
    echo "Component: $component, Version: $VERSION" >&2 # Send to stderr
              
    image_tags_json="$image_tags_json\"$component\": \"$VERSION\","
done

# 마지막 쉼표 제거
image_tags_json=${image_tags_json%,}
image_tags_json="$image_tags_json}"

# Send to stdout
# Get value by following command:
# $(sh .github/scripts/get-image-tags.sh 2>/dev/null)
echo "$image_tags_json"