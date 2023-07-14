#!/bin/bash

# Function to perform the dry run and print renamed files
dry_run_rename() {
  local directory="$1"

  # Iterate through each file in the directory
  for file in "$directory"/*; do
    if [[ -f "$file" ]]; then
      local filename=$(basename "$file")
      local newname=$(echo "$filename" | sed -E 's/([a-z0-9])([A-Z])/\1-\2/g' | tr '[:upper:]' '[:lower:]')
      echo "$filename => $newname"
    fi
  done
}

# Function to rename the files
rename_files() {
  local directory="$1"

  # Iterate through each file in the directory
  for file in "$directory"/*; do
    if [[ -f "$file" ]]; then
      local filename=$(basename "$file")
      local newname=$(echo "$filename" | sed -E 's/([a-z0-9])([A-Z])/\1-\2/g' | tr '[:upper:]' '[:lower:]')
      mv "$file" "$directory/$newname"
    fi
  done
}

# Check if directory argument is provided
if [[ $# -eq 0 ]]; then
  echo "Please provide the directory as an argument."
  exit 1
fi

# Get the directory path from the argument
directory="$1"

# Perform dry run and print renamed files
echo "Dry run: Renamed files"
echo "======================"
dry_run_rename "$directory"
echo "======================"

# Prompt for confirmation
read -p "Do you want to rename the files? (y/n): " confirm
if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
  # Rename the files
  rename_files "$directory"
  echo "Files renamed successfully."
else
  echo "Operation canceled. No files were renamed."
fi
