import os

def count_lines_in_files(directory, extension):
    total_lines = 0
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(extension):
                filepath = os.path.join(root, file)
                with open(filepath, 'r') as f:
                    lines = f.readlines()
                    for line in lines:
                        if line.strip():
                            total_lines += 1
    return total_lines

directory =    input("Enter the directory path: ")
extenstion = input("Enter the file extenstion (e.g., '.txt'): ")

line_count = count_lines_in_files(directory, extenstion)
print(f"Total lines in files with extenstion '{extenstion}' in directory '{directory}': {line_count}")
