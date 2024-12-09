#!/bin/bash

# 检查路径参数是否提供
if [ -z "$1" ]; then
  echo "错误：未提供路径参数"
  exit 1
fi

# 将路径设置为传入的第一个参数
path=$1

# 检查路径是否存在且为目录
if [ ! -d "$path" ]; then
  echo "错误：路径无效或不是目录"
  exit 1
fi

# 定义替换函数
replace_in_file() {
  local file_path="$1"
  local search_pattern="$2"
  local replace_pattern="$3"
  
  if [ ! -f "$file_path" ]; then
    echo "错误：文件不存在 - $file_path"
    return 1
  fi
  
  sed -i.bak "s/$search_pattern/$replace_pattern/g" "$file_path"
  if [ $? -ne 0 ]; then
    echo "错误：替换失败 - $file_path"
    return 1
  fi
  
  return 0
}

# 将 $path/library/borealis/library/lib/platforms/glfw/glfw_video.cpp 文件
# 中的第一个 glfwSwapInterval(1); 替换为 glfwSwapInterval(2); 以实现二分之一垂直同步帧率
replace_in_file "$path/library/borealis/library/lib/platforms/glfw/glfw_video.cpp" "glfwSwapInterval(1);" "glfwSwapInterval(2);"
if [ $? -ne 0 ]; then
  exit 1
fi

# 将 $path/library/borealis/library/lib/platforms/driver/d3d11.cpp 文件
# 中的第一个 this->swapChain->Present1(1, 0, &presentParameters); 替换为 this->swapChain->Present1(2, 0, &presentParameters); 以在 d3d 实现二分之一垂直同步帧率
replace_in_file "$path/library/borealis/library/lib/platforms/driver/d3d11.cpp" "this->swapChain->Present1(1, 0," "this->swapChain->Present1(2, 0,"
if [ $? -ne 0 ]; then
  exit 1
fi

echo "替换完成"
exit 0
