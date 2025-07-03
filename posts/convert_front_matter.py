import os
import re
import toml
import yaml

def convert_toml_to_yaml(toml_str):
    data = toml.loads(toml_str)
    return yaml.dump(data, sort_keys=False)

def process_markdown_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Match TOML front matter
    match = re.match(r'^\+\+\+\n(.*?)\n\+\+\+\n(.*)', content, re.DOTALL)
    if not match:
        return False  # Skip files without TOML front matter

    toml_block, body = match.groups()
    yaml_block = convert_toml_to_yaml(toml_block)

    new_content = f'---\n{yaml_block}---\n{body.lstrip()}'

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(new_content)
    return True

def convert_directory(root_dir):
    converted_files = 0
    for dirpath, _, filenames in os.walk(root_dir):
        for file in filenames:
            if file.endswith('.md'):
                full_path = os.path.join(dirpath, file)
                if process_markdown_file(full_path):
                    print(f'Converted: {full_path}')
                    converted_files += 1
    print(f'\n✅ Done. Converted {converted_files} file(s).')

if __name__ == '__main__':
    # Set your Hugo content directory here
    content_directory = 'content'
    convert_directory(content_directory)
