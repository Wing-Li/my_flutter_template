# My Flutter Template

#### 创建 Flutter 项目的模板：

使用 Flutter 3.0.0 , Dart 2.17.0

0. 创建一个新项目，项目名自己填；
1. 在 pubspec.yaml 复制第三方库，添加 images 、 fonts 类型。 在根目录创建 assets/images 、 assets/fonts 文件；
2. 在 Android 项目 AndroidManifest.xml 添加权限，修改 build.gradle 包名等；

    2.1 AndroidManifest.xml 添加权限，修改名称，图标；

    2.2 修改 build.gradle 包名，修改签名文件：
    
    ```
    // 生成签名的命令：keytool -genkey -v -keystore testprod.jks -alias testprod -storepass testprod -keypass testprod -keyalg RSA -keysize 2048 -validity 36500
    
    signingConfigs {
        config {
            keyAlias 'test'
            keyPassword 'test'
            storeFile file('test.jks')
            storePassword 'test'
        }
    }
    
    buildTypes {
        debug {
            signingConfig signingConfigs.config
        }
        release {
            signingConfig signingConfigs.config
        }
    }
    ```

3. 在 iOS 项目 Info.plist 文件，复制添加权限；

    3.1 在根目录 cd ios 进入 iOS 项目，执行命令： pod install 生成 Podfile ；
    

    3.2 修改 iOS 最低版本：
   
      1. 在 Podfile 文件修改第一行为： platform :ios, '12.0'；
      2. 在 Runner/Info.plist 里将 LSMinimumSystemVersion 改为 12.0；
      3. 在 Flutter/AppFrameworkInfo.plist 里将 MinimumOSVersion 改为 12.0；
      4. 点击根目录 Runner，在页面右边 TARGETS/Runner -> General -> Deployment Info 里 iphone 旁边的对应的 iOS 版本改为 12.1；
   
    
    3.3 将最后的 post_install 修改为如下代码：
    
    ```
    post_install do |installer|
      installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = "12.0"
                  config.build_settings['ENABLE_BITCODE'] = 'NO'
              end
          end
          project.build_configurations.each do |bc|
              bc.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = "12.0"
          end
      end
    end
    ```

4. 复制 lib 文件下的所有文件。
5. 右键 lib 文件夹，选择“Replace in Path..”，将 "my_flutter_template" 替换成自己的项目名。


**结束，可以开始写自己的代码了。**
