#!/bin/bash

open_and_move() {
    app_name="$1"
    workspace="$2"
    app_id="$3"

    # Check if the app is running
    if ! pgrep -q "$app_name"; then
        # If not running, open it
        open -a "$app_name"
        # Wait for the app to open (adjust sleep time as needed)
        sleep 5
    fi

    # Move to workspace and move the window
    aerospace workspace "$workspace"
    aerospace move-node-to-workspace "$workspace" --if.app-id="$app_id"
}

# Workspace 1: General 
open_and_move "Google Chrome" 1 "com.google.Chrome"
open_and_move "Slack" 1 "com.tinyspeck.slackmacgap"

# Workspace 2: Development
open_and_move "Visual Studio Code" 2 "com.microsoft.VSCode"
open_and_move "iTerm" 2 "com.googlecode.iterm2"

# Workspace 3: AI
open_and_move "OpenAI Chat" 3 "com.openai.chat"
open_and_move "Safari" 3 "com.apple.Safari"

# Workspace 4: Personal
open_and_move "C¡ursor" 4 "com.todesktop.230313mzl4w4u92"
open_and_move "Notion" 4 "notion.id"


