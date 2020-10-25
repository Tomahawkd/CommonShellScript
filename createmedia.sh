tmp_name="install_image"
attach_path="/Volumes/install_build"
name="$(ls -1 /Applications | grep "^Install[[:space:]]macOS[[:space:]]" | cut -d'.' -f1)"


echo "using installer ${name}" 
hdiutil create -o /tmp/${tmp_name}.cdr -size 16000m -layout SPUD -fs HFS+J
hdiutil attach /tmp/${tmp_name}.cdr.dmg -noverify -mountpoint ${attach_path}
sudo "/Applications/${name}.app/Contents/Resources/createinstallmedia" --volume ${attach_path}
hdiutil detach "/Volume/{name}"
hdiutil convert /tmp/${tmp_name}.cdr.dmg -format UDTO -o "${HOME}/Desktop/${name}.iso"
mv "${HOME}/Desktop/${name}.iso.cdr" "${HOME}/Desktop/${name}.iso"
rm /tmp/${tmp_name}.cdr.dmg