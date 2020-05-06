import requests
import sys
import os
import glob

def minify_file(file_path):
    url = "https://closure-compiler.appspot.com/compile"
    original_code = open(file_path, "r",encoding='utf-8').read()
    
    file_name = file_path.split("/")[len(file_path.split("/"))-1]
    path = file_path.replace(file_name,"")
    print(path)
    f = open(path + "original_" + file_name, "w",encoding='utf-8')
    f.write(original_code)
    f.close()

    r = requests.post(url,data={
        "js_code": original_code,
        "compilation_level": "SIMPLE_OPTIMIZATIONS",
        "output_format":"text",
        "output_info": "compiled_code"
    })
    minified_code = r.text
    
    print(file_path)
    overwrite_f = open(file_path, "w",encoding='utf-8')
    overwrite_f.write(minified_code)
    overwrite_f.close()

def deminify_file(file_path):
    file_name = file_path.split("/")[len(file_path.split("/"))-1]
    path = file_path.replace(file_name,"")
    original_code = open(path + "original_" + file_name, "r",encoding='utf-8').read()
    
    replace_original_f = open(file_path, "w",encoding='utf-8')
    replace_original_f.write(original_code)
    replace_original_f.close()
    
    os.remove(path + "original_" + file_name)

def minify_files():
    for file in files:
        minified_code = get_closure_code_from_file(file)
        
file = "/Users/brandoncompertore/OneDrive - The Ohio State University/Programs/Classifly/web_portal/js/core.js"

if __name__ == "__main__":
    action = sys.argv[1].lower()
    files = sys.argv[2].split(",")
    
    for file in files:
        if action == "minify":
            minify_file(file)
        elif action == "deminify":
            deminify_file(file)
