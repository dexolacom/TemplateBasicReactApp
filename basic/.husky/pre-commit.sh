#!/bin/sh
. "$(dirname "$0")/_/husky.sh"


blackList="console.info\|console.log\|alert\|var_dump"
result=0
while read FILE; do
    if [[ -f $FILE ]]; then
        if [[ "$FILE" =~ ^.+(ts|tsx|html|js)$ ]]; then
            RESULT=$(grep -i -m 1 "$blackList" "$FILE")
            if [[ ! -z $RESULT ]]; then
                echo "$FILE contains denied word: $RESULT"
                result=1
            fi
        fi
fi
done << EOT
    $(git diff --cached --name-only)
EOT

if [ $result -ne 0 ]; then
    echo "Aborting commit due to denied words"
    exit $result
fi
