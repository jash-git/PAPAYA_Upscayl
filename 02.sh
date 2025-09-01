cd part

#舊版語法: ls -1t --time=creation -r > ../list.txt
#新版語法 加上雙引號包覆和逗號結尾方便放入HTML給JS使用
ls -1t --time=creation -r | awk '{print "\"" $0 "\","}' > ../list.txt