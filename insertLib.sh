TARGET_APP_PATH="$BUILT_PRODUCTS_DIR/$TARGET_NAME.app"
echo "app路径:$TARGET_APP_PATH"
# 拿到MachO文件的路径
APP_BINARY=`plutil -convert xml1 -o - $TARGET_APP_PATH/Info.plist|grep -A1 Exec|tail -n1|cut -f2 -d\>|cut -f1 -d\<`
#上可执行权限
chmod +x "$TARGET_APP_PATH/$APP_BINARY"
TARGET_APP_FRAMEWORKS_PATH="$TARGET_APP_PATH/Frameworks"
# 拷贝包到framework里面去
INJECT_FRAMEWORK_BUILD_PATH="$SRCROOT/HCTestInsertLib.framework"
cp -rf "$INJECT_FRAMEWORK_BUILD_PATH" "$TARGET_APP_FRAMEWORKS_PATH"
#签名：如果不签名，那么dyld load的时候签名校验不过就会加载失败 报 image not found
/usr/bin/codesign --force --sign "$EXPANDED_CODE_SIGN_IDENTITY" "$TARGET_APP_FRAMEWORKS_PATH/HCTestInsertLib.framework"
#注入：修改MachO文件
yololib "$TARGET_APP_PATH/$APP_BINARY" "Frameworks/HCTestInsertLib.framework/HCTestInsertLib"






