# HDR-and-Bloom

HDR 和泛光的结合使用，表达明亮的光源区域，产生光晕效果

## 依赖
* glfw3.lib 推荐在[官方网站](http://www.glfw.org/download.html)下载源代码，然后自行编译。本项目编译使用的是CMake和Visual Studio 2015.
* GLAD 打开GLAD的[在线服务](http://glad.dav1d.de/)可轻松配置。本项目使用OpenGL 4.3.
* stb_image.h 是[Sean Barrett](https://github.com/nothings)的一个非常流行的单头文件图像加载库，可以在[这里](https://github.com/nothings/stb/blob/master/stb_image.h)下载。本项目使用其来加载纹理图片。
* GLM 一个只有头文件的库，不用链接和编译。可以在它们的[网站](http://glm.g-truc.net/0.9.5/index.html)上下载。本项目使用其作为数学库。
* Assimp 一个非常流行的模型导入库，可以在[下载页面](http://assimp.org/main_downloads.html)选择相应的版本，自行使用CMake 和 Visual Studio 2015编译。

## HDR

显示器被限制为只能显示值为0.0到1.0间的颜色，但是在光照方程中却没有这个限制。通过使片段的颜色超过1.0，有了一个更大的颜色范围，即 **HDR（High Dynamic Range, 高动态范围）** ，这样，亮的东西可以变得非常亮，暗的东西可以变得非常暗，而且充满细节

**浮点帧缓冲** :可以存储超过0.0到1.0范围的浮点值

**色调映射(Tone Mapping)** ：从HDR转换至LDR，即[0.0, 1.0]:

	1. **Reinhard色调映射算法** ：平均将所有亮度值分散到LDR上，这个算法是倾向于明亮的区域的，暗的区域会不那么精细也不那么有区分度。
	2. **曝光(Exposure)色调映射算法** ：高曝光值会使黑暗部分显示更多细节
```
	result = vec3(1.0) - exp(-hdrColor * exposure);
```
	
## 泛光(Bloom)

使所有明亮区域产生光晕效果，Bloom和HDR结合使用效果很好。

为实现泛光，像平时一样渲染一个有光场景，提取出场景的HDR颜色缓冲以及只有这个场景明亮区域可见的图片。被提取带有亮度的图片接着被模糊，结果被添加到HDR场景上面。

**提取亮色** ： **MTR（Multiple Render Targets, 多渲染目标）** 技巧，即可以在一次渲染中输出不同的片段着色器。 可以恰当地将颜色转为灰度，当超过阈值1.0时，保留

高级地模糊过滤器： ***高斯模糊(Gaussian blur)** ,权重随距离地变大逐渐减小。优化方式： 将二维方程分解为两个更小地方程：一个描述水平权重，一个描述垂直权重，以32*32的模糊kernel为例，只需要做32+32次采样，不再是32*32次，这个方式叫做 **两步高斯模糊**

## 效果

- HDR

![HDR](https://github.com/SweeneyChoi/HDR-and-Bloom/blob/master/images/HDR.png)

- 泛光

![泛光](https://github.com/SweeneyChoi/HDR-and-Bloom/blob/master/images/Bloom.png)


