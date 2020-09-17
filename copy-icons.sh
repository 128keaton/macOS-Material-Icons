#!/bin/bash

echo "Creating file structure"

rm -rf Icons/

mkdir Icons/
mkdir Icons/filled/
mkdir Icons/outlined/
mkdir Icons/rounded/
mkdir Icons/two-tone/
mkdir Icons/sharp/

echo "Copying filled icons"
find ./material-design-icons/png/ -name "baseline*48dp.png" -type f -exec cp {} ./Icons/filled \;

echo "Copying outlined icons"
find ./material-design-icons/png/ -name "outline*48dp.png" -type f -exec cp {} ./Icons/outlined \;

echo "Copying rounded icons"
find ./material-design-icons/png/ -name "round*48dp.png" -type f -exec cp {} ./Icons/rounded \;

echo "Copying two-tone icons"
find ./material-design-icons/png/ -name "twotone*48dp.png" -type f -exec cp {} ./Icons/two-tone \;

echo "Copying sharp icons"
find ./material-design-icons/png/ -name "sharp*48dp.png" -type f -exec cp {} ./Icons/sharp \;

echo "Done!"

