#!/bin/bash

# Set up the start and end dates
START_DATE="2024-01-01"
END_DATE=$(date +%F) # Today's date

# Loop over each day
current_date="$START_DATE"
while [ "$current_date" != "$END_DATE" ]; do
    # Change to your repository directory
    # cd /path/to/your/repository

    # Set initial time for the day (12:00 PM)
    current_time="12:00:00"

    # Make 50 commits on this day
    for i in {1..50}; do
        # Modify main.rs in some way
        echo "// Commit number $i on $current_date at $current_time" >> src/main.rs

        # Format the date and time for macOS
        formatted_date=$(date -j -f "%Y-%m-%d %H:%M:%S" "$current_date $current_time" +"%a %b %d %H:%M %Y %z")

        # Add and commit with the specific formatted date and time
        git add src/main.rs
        GIT_COMMITTER_DATE="$formatted_date" git commit -m "Commit $i on $formatted_date" --date="$formatted_date"

        # Increment time by 1 minute for macOS
        current_time=$(date -j -v+1M -f "%Y-%m-%d %H:%M:%S" "$current_date $current_time" +"%H:%M:%S")
    done
    git push origin master
    # Go to the next day
    current_date=$(date -j -v+1d -f "%Y-%m-%d" "$current_date" +"%Y-%m-%d")
done

# Push the changes to the remote repository
git push origin master
