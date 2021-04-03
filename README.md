# My Flutter Template

#### 创建 Flutter 项目的模板：

0. 创建一个新项目，项目名自己填；
1. 在 pubspec.yaml 复制第三方库，添加 images 、 fonts 类型。 在根目录创建 assets/images 、 assets/fonts 文件；
2. 在 Android 项目 AndroidManifest.xml 添加权限，修改 build.gradle 包名；
3. 在 iOS 项目 Info.plist 文件，复制添加权限；

    3.1 在根目录 cd ios 进入 iOS 项目， pod install 生成 Podfile 文件后，修改第一行为： platform :ios, '12.0'；
    
    3.2 将最后的 post_install 修改为如下代码：
    
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