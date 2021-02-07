# cd $WORK_PATH/trunk 执行在这个目录下

# 1.修改一些默认参数 ./user/shared/defaults.h（需要不同设备不同拷贝到相应sh文件就好)

user_name="admin"                        # 用户名 admin
user_password=$user_name                 # 用户密码 admin
lan_ip="192.168.2"                       # lan 地址 192.168.3.1 一定别写后面的 .1
wifi_password="18277357732"               # wifi密码，切记密码最少8位 admin
version_time=$(date "+%Y%m%d")           # 自动时间更新时版本号: 20200320
default_path="./user/shared/defaults.h"  # 默认文件配置目录


echo '修改用户名'
sed -i 's/#define\s*SYS_USER_ROOT\s*"admin"/#define  SYS_USER_ROOT     "'$user_name'"/g' $default_path

echo '修改密码'
sed -i 's/#define\s*DEF_ROOT_PASSWORD\s*"admin"/#define  DEF_ROOT_PASSWORD     "'$user_password'"/g' $default_path

echo "修改Lan ip"
sed -i "s/192.168.2/$lan_ip/g" $default_path

echo "修改Wif密码"
sed -i "s/1234567890/$wifi_password/g" $default_path

echo "更新版本号时间"
sed -i "s/FIRMWARE_BUILDS_REV=[0-9]*/FIRMWARE_BUILDS_REV=$version_time/g" ./versions.inc


### Include dropbear SSH. ~0.3MB
echo "CONFIG_FIRMWARE_INCLUDE_DROPBEAR=y" >> .config

### Make the dropbear symmetrical ciphers and hashes faster. ~0.06MB
echo "CONFIG_FIRMWARE_INCLUDE_DROPBEAR_FAST_CODE=y" >> .config

### Include HTTPS support for DDNS client. openssl ~1.2MB
echo "CONFIG_FIRMWARE_INCLUDE_DDNS_SSL=y" >> .config

### Include HTTPS support. openssl ~1.2MB
echo "CONFIG_FIRMWARE_INCLUDE_HTTPS=y" >> .config
