# Setting up and Using CodeLlama-7B with llama.cpp on Windows with GitBash

The following assumes you have [GitBash](https://git-scm.com/downloads) and [Cmake](https://cmake.org/download/) installed and setup on your windows machine.
It also assumes that you have a compiler installed. Either MSVC through [Visual Studio Installer](https://www.youtube.com/watch?v=yBvxsw6OOw4) or GCC via [MSYS2](https://www.msys2.org/).

## 1. Initial Setup

```bash
# Clone llama.cpp
git clone https://github.com/ggerganov/llama.cpp
cd llama.cpp

# Build the project
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release

```

## 2. Download CodeLlama Model

1. Visit: https://huggingface.co/TheBloke/CodeLlama-7B-Instruct-GGUF
2. Download: `codellama-7b-instruct.Q4_K_M.gguf`
3. Move the downloaded file to the `models` directory

## 3. Create Custom Prompt Template

Create a file named `code_prompt.txt` with this content:
```text
[INST] You are an expert programmer. Write clear, efficient, and well-documented code based on the user's requirements.

Write code for the following task:
{{TASK}}

Provide the complete code with explanations.
[/INST]
```

## 4. Running the Model

Basic command structure:
```bash
./build/bin/Release/llama-cli.exe \
    -m ./models/codellama-7b-instruct.Q4_K_M.gguf \
    --color \
    -i \
    -r "User:" \
    --temp 0.2 \
    -c 4096 \
    -n 4096 \
    -t 8
```

## 5. Example React Query

Here's how to get a React Hello World example:

```bash
# Create a specific prompt file for React (react_prompt.txt):
echo '[INST] Create a simple React Hello World component that displays "Hello, World!" in blue color. Include proper imports and show how to use the component. [/INST]' > ./prompts/react_prompt.txt

# Run the query
./build/bin/Release/llama-cli \
    -m ./models/codellama-7b-instruct.Q4_K_M.gguf \
    --color \
    -f ./prompts/react_prompt.txt \
    --temp 0.2 \
    -c 4096 \
    -n 4096 \
    -t 8
```

## 6. Parameter Explanations

```bash
-m        # Path to the model
--color   # Enable colored output
-i        # Interactive mode
-r        # Set custom prompt prefix
--temp    # Temperature (lower = more focused)
-c        # Context size
-n        # Maximum tokens to generate
-t        # Number of threads
```

## 7. Best Practices for Code Generation

1. Use lower temperature (0.1-0.3) for more focused code
2. Include specific requirements in prompts
3. Request documentation and usage examples
4. Use the interactive mode for follow-up questions

## 8. Common Issues and Solutions

1. **Out of Memory**:
   - Reduce context size (-c flag)
   - Use fewer threads
   - Close other applications

2. **Slow Generation**:
   - Increase thread count if CPU allows
   - Reduce context size
   - Enable GPU acceleration if available

3. **Poor Code Quality**:
   - Lower the temperature
   - Make prompts more specific
   - Request examples and documentation
