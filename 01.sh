#!/bin/bash

mkdir part

# Set input video file name
input_file="input.mp4"

duration=$(./mp4_tool/ffprobe.exe -v error -select_streams v:0 -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 $input_file | awk '{print int($1)}')

# 顯示影片總秒數
echo "影片總秒數: $duration"

# Set segment duration in seconds
segment_duration=80

# Set output file name pattern
output_file_pattern="./part/part%04d.mp4"

# Calculate total number of segments
total_segments=$duration/$segment_duration+1

# Split the video into segments
for i in $(seq 0 $((total_segments - 1))); do
start_time=$((i * segment_duration))
output_file=$(printf "$output_file_pattern" $i)
./mp4_tool/ffmpeg.exe -i "$input_file" -ss $start_time -t $segment_duration -vcodec copy -acodec copy "$output_file"
done