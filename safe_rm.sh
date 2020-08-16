#!/bin/bash
# 安全的rm脚本
# reference: https://blog.csdn.net/newbietao/article/details/79833655
 
 
dir=$(date "+%y_%m_%d")
# dir="/trash/$dir"
dir="$HOME/trash/$dir"
#echo $dir
if [ ! -d $dir ]; then
  mkdir -p $dir
fi
 
is_f=false
args=""
 
function f_remove() {
  for i in ${args}; do
    if [ -d "$i" -o -f "$i" ]; then
      name=`basename $i`
      if [ -d "$dir/$name" -o -f "$dir/$name" ]; then
        new_name="$dir/${name}_$(date '+%T')"
        mv $i $new_name && echo "$i deleted, you can see in $new_name"
      else
        mv $i $dir && echo "$i deleted, you can see in $dir/$i"
      fi
    else
      echo "参数错误"
    fi
  done
}
 
 
function remove() {
  for j in ${args}; do
    if [ -d "$j" -o -f "$j" ]; then
      name=`basename $j`
      read -p "Remove $name?[y/n]" bool
      if [ $bool == "n" ]; then
        exit
      elif [ $bool == "y" ]; then
        if [ -d "$dir/$name" -o -f "$dir/$name" ]; then
          new_name="$dir/${name}_$(date '+%T')"
          mv $j $new_name && echo "$j deleted, you can see in $new_name"
        else
          mv $j $dir && echo "$j deleted, you can see in $dir/$j"
        fi
      fi
    else
      echo "参数错误"
    fi
  done
}
 
 
while [ "$1" ]; do
  case "$1" in
    -fr|-rf)
      is_f=true
      shift
      ;;
    -i)
      is_f=false
      shift
      ;;
    *)
      args="$1 $args"
      shift
      ;;  
  esac
done
 
 
if [[ $is_f = true ]]; then
  f_remove
else
  remove
fi
