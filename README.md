# my_flutter_template

创建 Flutter 项目的模板：

1. 在 pubspec.yaml 添加第三方库，添加 images 、 fonts 类型，以及创建 assets/images 文件；
2. 在 Android 项目 AndroidManifest.xml 添加权限，修改 build.gradle 包名；
3. 在 iOS 项目 Info.plist 添加权限；
    3.1 pod install 之后生成 Podfile 文件后，修改第一行为： platform :ios, '12.0'
    3.2 将最后的 post_install 修改为如下代码：
    
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

4. 复制 lib 文件下的所有文件。