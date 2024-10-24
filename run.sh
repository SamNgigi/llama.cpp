#!/bin/bash

MODEL_PATH="./models/codellama-7b-instruct.Q4_K_M.gguf"
PROMPTS_DIR="./prompts/"
OUTPUT_DIR="./outputs/"
LLAMA_CLI="./build/bin/Release/llama-cli.exe"
LLAMA_SERVER="./build/bin/Release/llama-server.exe"
BASE_PROMPT="${PROMPTS_DIR}/my-base-coder.txt"


# Configuration presets
declare -A CONFIGS
CONFIGS=(
    ["default"]="--temp 0.2 -c 4096 -n 4096 -t 8 --color"
    ["code"]="--temp 0.1 -c 6144 -n 8192 -t 12 --color --repeat-penalty 1.2"
    ["creative"]="--temp 0.7 -c 4096 -n 4096 -t 8 --color --repeat-penalty 1.1"
)


# $LLAMA_SERVER -m $MODEL_PATH --port 8081  // runs a local webserver on port 8081 for interacting with codellama model
# Create a specific prompt file for React (react_prompt.txt):
echo '[INST] Create a simple React Hello World component that displays "Hello, World!" in blue color. Include proper imports and show how to use the component. [/INST]' > ./prompts/react_prompt.txt

$LLAMA_CLI \
    -m $MODEL_PATH \
    --color \
    -f ./prompts/react_prompt.txt \
    --temp 0.2 \
    -c 4096 \
    -n 4096 \
    -t 8
