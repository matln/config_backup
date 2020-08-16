#!/bin/bash
# 安全的rm脚本
# reference: https://blog.csdn.net/newbietao/article/details/79833655
 
 
dir=$(date "+%y_%m_%d")
# dir="/trash/$dir"
dir="/data/$USER/trash/$dir"
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
        mv $i $new_name && echo "$i has been moved to $new_name. You can use \`\\rm -r $new_name\` to permanently delete $i."
      else
        mv $i $dir && echo "$i has been moved to $dir/$i. You can use \`\\rm -r $dir/$i\` to permanently delete $i."
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
          mv $j $new_name && echo "$j has been moved to $new_name. You can use \`\\rm -r $new_name\` to permanently delete $j."
        else
          mv $j $dir && echo "$j has been moved to $dir/$j. You can use \`\\rm -r $dir/$j\` to permanently delete $j."
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
