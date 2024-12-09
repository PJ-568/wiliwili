#!/bin/bash

# 将路径设置为传入的第一个参数
path=$1

# 将 $path/library/borealis/library/lib/platforms/glfw/glfw_video.cpp 文件
# 中的第一个 glfwSwapInterval(1); 替换为 glfwSwapInterval(2); 以实现二分之一垂直同步帧率
sed -i 's/glfwSwapInterval(1);/glfwSwapInterval(2);/g' "$path"/library/borealis/library/lib/platforms/glfw/glfw_video.cpp && echo "替换完成"

exit 0
