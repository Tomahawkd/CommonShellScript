set -e
tmp_name="install_image"
attach_path="/Volumes/install_build"
name="$(ls -1 /Applications | grep "^Install[[:space:]]macOS[[:space:]]" | cut -d'.' -f1)"
echo "using installer ${name}"

echo creating empty image
hdiutil create -o /tmp/${tmp_name}.cdr -size 16000m -layout SPUD -fs HFS+J

echo mounting to volumes
hdiutil attach /tmp/${tmp_name}.cdr.dmg -noverify -mountpoint ${attach_path}

echo using installer
sudo "/Applications/${name}.app/Contents/Resources/createinstallmedia" --volume ${attach_path}

echo eject volume
hdiutil detach "/Volumes/${name}"

echo converting to iso
hdiutil convert /tmp/${tmp_name}.cdr.dmg -format UDTO -o "${HOME}/Desktop/${name}.iso"

echo clean up space
mv "${HOME}/Desktop/${name}.iso.cdr" "${HOME}/Desktop/${name}.iso"
rm /tmp/${tmp_name}.cdr.dmg